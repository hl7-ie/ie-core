const fs = require('fs');
const path = require('path');

const REPORTS_DIR = __dirname;
const R5_REPORTS_DIR = path.resolve(__dirname, '..', '..', 'r5', 'tests', 'reports');
const OUTPUT_DIR = path.resolve(__dirname, 'html');

if (!fs.existsSync(OUTPUT_DIR)) fs.mkdirSync(OUTPUT_DIR, { recursive: true });

function loadJson(filePath) {
  try {
    if (fs.existsSync(filePath)) return JSON.parse(fs.readFileSync(filePath, 'utf8'));
  } catch { /* ignore parse errors */ }
  return null;
}

function formatTimestamp() {
  return new Date().toISOString().replace('T', ' ').replace(/\.\d+Z$/, ' UTC');
}

function escapeHtml(value) {
  return String(value ?? '')
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#39;');
}

function scenarioRows(cucumberJson) {
  if (!cucumberJson || !Array.isArray(cucumberJson)) return '';
  const rows = [];
  for (const feature of cucumberJson) {
    const featureName = feature.name || 'Unknown';
    for (const scenario of (feature.elements || [])) {
      if (scenario.type !== 'scenario') continue;
      const steps = scenario.steps || [];
      const statuses = steps
        .map(s => s.result && s.result.status)
        .filter(Boolean);
      const failed = statuses.some(status => ['failed', 'ambiguous'].includes(status));
      const passed = statuses.length > 0 && statuses.every(status => status === 'passed');
      const status = passed ? 'PASS' : failed ? 'FAIL' : 'SKIP';
      const durationMs = steps.reduce((sum, s) => sum + ((s.result && s.result.duration) || 0), 0) / 1e6;
      const safeFeatureName = escapeHtml(featureName);
      const safeScenarioName = escapeHtml(scenario.name || 'Unnamed scenario');
      const iconForStatus = status === 'PASS' ? '&#9989;' : status === 'FAIL' ? '&#10060;' : '&#9888;';
      rows.push(`<tr class="${status.toLowerCase()}"><td>${iconForStatus}</td><td>${safeFeatureName}</td><td>${safeScenarioName}</td><td>${status}</td><td>${durationMs.toFixed(1)}ms</td></tr>`);
    }
  }
  return rows.join('\n');
}

function qualityRows(qualityJson) {
  if (!qualityJson) return '';
  const rows = [];
  const s = qualityJson.summary || {};
  rows.push(`<tr><td>&#9989;</td><td colspan="3">Passed</td><td><strong>${s.passed || 0}</strong></td></tr>`);
  if (s.issues > 0) {
    rows.push(`<tr class="fail"><td>&#10060;</td><td colspan="3">Issues</td><td><strong>${s.issues}</strong></td></tr>`);
    for (const d of (qualityJson.details || [])) {
      rows.push(`<tr class="fail"><td></td><td colspan="3">${escapeHtml(d.check)}</td><td>${escapeHtml(d.detail)}</td></tr>`);
    }
  }
  return rows.join('\n');
}

function validationRows(valJson) {
  if (!valJson) return '';
  const rows = [];
  for (const r of (valJson.results || [])) {
    const icon = r.status === 'PASS' ? '&#9989;' : '&#10060;';
    rows.push(`<tr class="${r.status.toLowerCase()}"><td>${icon}</td><td colspan="3">${escapeHtml(r.file)}</td><td>${escapeHtml(r.status)}</td></tr>`);
  }
  return rows.join('\n');
}

function summaryBadge(label, passed, total) {
  const pct = total > 0 ? Math.round((passed / total) * 100) : 0;
  const cls = pct === 100 ? 'badge-pass' : pct >= 80 ? 'badge-warn' : 'badge-fail';
  return `<span class="badge ${cls}">${label}: ${passed}/${total} (${pct}%)</span>`;
}

const r4Cucumber = loadJson(path.join(REPORTS_DIR, 'cucumber-report.json'));
const r4Quality = loadJson(path.join(REPORTS_DIR, 'quality-results.json'));
const r4Validation = loadJson(path.join(REPORTS_DIR, 'validation-results.json'));
const r5Cucumber = loadJson(path.join(R5_REPORTS_DIR, 'cucumber-report.json'));
const r5Quality = loadJson(path.join(R5_REPORTS_DIR, 'quality-results.json'));
const r5Validation = loadJson(path.join(R5_REPORTS_DIR, 'validation-results.json'));

function cucumberSummary(cj) {
  if (!cj || !Array.isArray(cj)) return { passed: 0, failed: 0, skipped: 0, total: 0 };
  let passed = 0, failed = 0, skipped = 0;
  for (const f of cj) {
    for (const s of (f.elements || [])) {
      if (s.type !== 'scenario') continue;
      const statuses = (s.steps || [])
        .map(st => st.result && st.result.status)
        .filter(Boolean);
      if (statuses.length > 0 && statuses.every(status => status === 'passed')) {
        passed++;
      } else if (statuses.some(status => ['failed', 'ambiguous'].includes(status))) {
        failed++;
      } else {
        skipped++;
      }
    }
  }
  return { passed, failed, skipped, total: passed + failed + skipped };
}

const r4Bdd = cucumberSummary(r4Cucumber);
const r5Bdd = cucumberSummary(r5Cucumber);
const r4Qs = r4Quality ? r4Quality.summary : { passed: 0, issues: 0, total: 0 };
const r5Qs = r5Quality ? r5Quality.summary : { passed: 0, issues: 0, total: 0 };
const r4Vs = r4Validation ? r4Validation.summary : { passed: 0, failed: 0, total: 0 };
const r5Vs = r5Validation ? r5Validation.summary : { passed: 0, failed: 0, total: 0 };

const html = `<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>IE Core FHIR IG — Test Report Dashboard</title>
<style>
  :root { --pass: #28a745; --fail: #dc3545; --warn: #ffc107; --bg: #f8f9fa; --border: #dee2e6; --primary: #005eb8; }
  * { box-sizing: border-box; margin: 0; padding: 0; }
  body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; background: var(--bg); color: #333; }
  .header { background: var(--primary); color: white; padding: 24px 40px; }
  .header h1 { font-size: 1.5em; }
  .header p { opacity: 0.85; margin-top: 4px; font-size: 0.9em; }
  .container { max-width: 1200px; margin: 0 auto; padding: 24px; }
  .badges { display: flex; flex-wrap: wrap; gap: 12px; margin: 20px 0; }
  .badge { display: inline-block; padding: 6px 16px; border-radius: 20px; font-weight: 600; font-size: 0.9em; color: white; }
  .badge-pass { background: var(--pass); }
  .badge-warn { background: var(--warn); color: #333; }
  .badge-fail { background: var(--fail); }
  .section { background: white; border-radius: 8px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); margin-bottom: 24px; overflow: hidden; }
  .section h2 { background: var(--primary); color: white; padding: 12px 20px; font-size: 1.1em; }
  .section h3 { padding: 12px 20px 4px; color: var(--primary); border-bottom: 1px solid var(--border); }
  table { width: 100%; border-collapse: collapse; font-size: 0.9em; }
  th, td { padding: 8px 12px; text-align: left; border-bottom: 1px solid var(--border); }
  th { background: #f1f3f5; font-weight: 600; color: #495057; }
  tr.fail { background: #fff5f5; }
  tr.skip { background: #fffbe6; }
  tr.pass { }
  .tabs { display: flex; border-bottom: 2px solid var(--border); }
  .tab { padding: 10px 24px; cursor: pointer; font-weight: 600; color: #666; border-bottom: 3px solid transparent; transition: all 0.2s; }
  .tab.active { color: var(--primary); border-bottom-color: var(--primary); }
  .tab-content { display: none; }
  .tab-content.active { display: block; }
  .footer { text-align: center; padding: 20px; color: #999; font-size: 0.85em; }
  a { color: var(--primary); }
  .nav { display: flex; gap: 16px; margin-top: 8px; }
  .nav a { color: rgba(255,255,255,0.9); text-decoration: none; font-size: 0.9em; }
  .nav a:hover { color: white; text-decoration: underline; }
</style>
</head>
<body>
<div class="header">
  <h1>IE Core FHIR IG — Test Report Dashboard</h1>
  <p>Generated: ${formatTimestamp()}</p>
  <div class="nav">
    <a href="../index.html">R4 IG</a>
    <a href="../R5/index.html">R5 IG</a>
    <a href="../versions.html">Version Index</a>
  </div>
</div>
<div class="container">

<div class="badges">
  ${summaryBadge('R4 BDD', r4Bdd.passed, r4Bdd.total)}
  ${summaryBadge('R4 Quality', r4Qs.passed, r4Qs.total)}
  ${summaryBadge('R4 Validation', r4Vs.passed, r4Vs.total)}
  ${summaryBadge('R5 BDD', r5Bdd.passed, r5Bdd.total)}
  ${summaryBadge('R5 Quality', r5Qs.passed, r5Qs.total)}
  ${summaryBadge('R5 Validation', r5Vs.passed, r5Vs.total)}
</div>

<div class="section">
  <h2>Overview</h2>
  <table>
    <tr><th>Suite</th><th>Edition</th><th>Passed</th><th>Failed/Issues</th><th>Skipped</th><th>Total</th></tr>
    <tr><td>BDD / Cucumber</td><td>R4</td><td>${r4Bdd.passed}</td><td>${r4Bdd.failed}</td><td>${r4Bdd.skipped}</td><td>${r4Bdd.total}</td></tr>
    <tr><td>Quality Control</td><td>R4</td><td>${r4Qs.passed}</td><td>${r4Qs.issues}</td><td>0</td><td>${r4Qs.total}</td></tr>
    <tr><td>FHIR Validator</td><td>R4</td><td>${r4Vs.passed}</td><td>${r4Vs.failed}</td><td>0</td><td>${r4Vs.total}</td></tr>
    <tr><td>BDD / Cucumber</td><td>R5</td><td>${r5Bdd.passed}</td><td>${r5Bdd.failed}</td><td>${r5Bdd.skipped}</td><td>${r5Bdd.total}</td></tr>
    <tr><td>Quality Control</td><td>R5</td><td>${r5Qs.passed}</td><td>${r5Qs.issues}</td><td>0</td><td>${r5Qs.total}</td></tr>
    <tr><td>FHIR Validator</td><td>R5</td><td>${r5Vs.passed}</td><td>${r5Vs.failed}</td><td>0</td><td>${r5Vs.total}</td></tr>
  </table>
</div>

<div class="section">
  <h2>BDD Scenarios</h2>
  <div class="tabs">
    <div class="tab active" onclick="switchTab(event, 'bdd-r4')">R4</div>
    <div class="tab" onclick="switchTab(event, 'bdd-r5')">R5</div>
  </div>
  <div id="bdd-r4" class="tab-content active">
    <table>
      <tr><th></th><th>Feature</th><th>Scenario</th><th>Status</th><th>Duration</th></tr>
      ${scenarioRows(r4Cucumber)}
    </table>
  </div>
  <div id="bdd-r5" class="tab-content">
    <table>
      <tr><th></th><th>Feature</th><th>Scenario</th><th>Status</th><th>Duration</th></tr>
      ${scenarioRows(r5Cucumber)}
    </table>
  </div>
</div>

<div class="section">
  <h2>Quality Control</h2>
  <div class="tabs">
    <div class="tab active" onclick="switchTab(event, 'qc-r4')">R4</div>
    <div class="tab" onclick="switchTab(event, 'qc-r5')">R5</div>
  </div>
  <div id="qc-r4" class="tab-content active">
    <table>
      <tr><th></th><th colspan="3">Check</th><th>Detail</th></tr>
      ${qualityRows(r4Quality)}
    </table>
  </div>
  <div id="qc-r5" class="tab-content">
    <table>
      <tr><th></th><th colspan="3">Check</th><th>Detail</th></tr>
      ${qualityRows(r5Quality)}
    </table>
  </div>
</div>

<div class="section">
  <h2>FHIR Validator</h2>
  <div class="tabs">
    <div class="tab active" onclick="switchTab(event, 'val-r4')">R4</div>
    <div class="tab" onclick="switchTab(event, 'val-r5')">R5</div>
  </div>
  <div id="val-r4" class="tab-content active">
    <table>
      <tr><th></th><th colspan="3">Resource</th><th>Status</th></tr>
      ${validationRows(r4Validation)}
    </table>
  </div>
  <div id="val-r5" class="tab-content">
    <table>
      <tr><th></th><th colspan="3">Resource</th><th>Status</th></tr>
      ${validationRows(r5Validation)}
    </table>
  </div>
</div>

</div>
<div class="footer">
  IE Core FHIR IG &mdash; HL7 Ireland / HSE FHIR Working Group &mdash; <a href="https://github.com">View on GitHub</a>
</div>
<script>
function switchTab(e, id) {
  const section = e.target.closest('.section');
  section.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
  section.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'));
  e.target.classList.add('active');
  section.querySelector('#' + id).classList.add('active');
}
</script>
</body>
</html>`;

fs.writeFileSync(path.join(OUTPUT_DIR, 'index.html'), html);
console.log(`Dashboard generated: ${path.join(OUTPUT_DIR, 'index.html')}`);
