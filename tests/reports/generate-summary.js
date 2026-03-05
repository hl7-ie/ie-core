const fs = require('fs');
const path = require('path');

const REPORTS_DIR = __dirname;
const R5_REPORTS_DIR = path.resolve(__dirname, '..', '..', 'r5', 'tests', 'reports');
const outputFile = process.argv[2] || path.join(REPORTS_DIR, 'test-summary.md');

function loadJson(filePath) {
  try {
    if (fs.existsSync(filePath)) return JSON.parse(fs.readFileSync(filePath, 'utf8'));
  } catch { /* ignore */ }
  return null;
}

function cucumberSummary(cj) {
  if (!cj || !Array.isArray(cj)) return { passed: 0, failed: 0, total: 0, scenarios: [] };
  let passed = 0, failed = 0;
  const scenarios = [];
  for (const f of cj) {
    for (const s of (f.elements || [])) {
      if (s.type !== 'scenario') continue;
      const hasFail = (s.steps || []).some(st => st.result && st.result.status === 'failed');
      hasFail ? failed++ : passed++;
      scenarios.push({ feature: f.name, name: s.name, status: hasFail ? 'FAIL' : 'PASS' });
    }
  }
  return { passed, failed, total: passed + failed, scenarios };
}

function badge(label, passed, total) {
  if (total === 0) return `![${label}](https://img.shields.io/badge/${encodeURIComponent(label)}-no_data-lightgrey)`;
  const pct = Math.round((passed / total) * 100);
  const color = pct === 100 ? 'brightgreen' : pct >= 80 ? 'yellow' : 'red';
  return `![${label}](https://img.shields.io/badge/${encodeURIComponent(label)}-${passed}%2F${total}%20(${pct}%25)-${color})`;
}

const r4Cucumber = loadJson(path.join(REPORTS_DIR, 'cucumber-report.json'));
const r4Quality = loadJson(path.join(REPORTS_DIR, 'quality-results.json'));
const r4Validation = loadJson(path.join(REPORTS_DIR, 'validation-results.json'));
const r5Cucumber = loadJson(path.join(R5_REPORTS_DIR, 'cucumber-report.json'));
const r5Quality = loadJson(path.join(R5_REPORTS_DIR, 'quality-results.json'));
const r5Validation = loadJson(path.join(R5_REPORTS_DIR, 'validation-results.json'));

const r4Bdd = cucumberSummary(r4Cucumber);
const r5Bdd = cucumberSummary(r5Cucumber);
const r4Qs = r4Quality ? r4Quality.summary : { passed: 0, issues: 0, total: 0 };
const r5Qs = r5Quality ? r5Quality.summary : { passed: 0, issues: 0, total: 0 };
const r4Vs = r4Validation ? r4Validation.summary : { passed: 0, failed: 0, total: 0 };
const r5Vs = r5Validation ? r5Validation.summary : { passed: 0, failed: 0, total: 0 };

let md = `## IE Core FHIR IG — Test Results\n\n`;

md += `${badge('R4 BDD', r4Bdd.passed, r4Bdd.total)} `;
md += `${badge('R4 Quality', r4Qs.passed, r4Qs.total)} `;
md += `${badge('R4 Validator', r4Vs.passed, r4Vs.total)} `;
md += `${badge('R5 BDD', r5Bdd.passed, r5Bdd.total)} `;
md += `${badge('R5 Quality', r5Qs.passed, r5Qs.total)} `;
md += `${badge('R5 Validator', r5Vs.passed, r5Vs.total)}\n\n`;

md += `### Summary\n\n`;
md += `| Suite | Edition | Passed | Failed | Total |\n`;
md += `|-------|---------|-------:|-------:|------:|\n`;
md += `| BDD / Cucumber | R4 | ${r4Bdd.passed} | ${r4Bdd.failed} | ${r4Bdd.total} |\n`;
md += `| Quality Control | R4 | ${r4Qs.passed} | ${r4Qs.issues} | ${r4Qs.total} |\n`;
md += `| FHIR Validator | R4 | ${r4Vs.passed} | ${r4Vs.failed} | ${r4Vs.total} |\n`;
md += `| BDD / Cucumber | R5 | ${r5Bdd.passed} | ${r5Bdd.failed} | ${r5Bdd.total} |\n`;
md += `| Quality Control | R5 | ${r5Qs.passed} | ${r5Qs.issues} | ${r5Qs.total} |\n`;
md += `| FHIR Validator | R5 | ${r5Vs.passed} | ${r5Vs.failed} | ${r5Vs.total} |\n\n`;

if (r4Bdd.scenarios.length > 0) {
  md += `<details><summary><strong>R4 BDD Scenarios (${r4Bdd.passed}/${r4Bdd.total})</strong></summary>\n\n`;
  md += `| Status | Feature | Scenario |\n`;
  md += `|--------|---------|----------|\n`;
  for (const s of r4Bdd.scenarios) {
    const icon = s.status === 'PASS' ? ':white_check_mark:' : ':x:';
    md += `| ${icon} | ${s.feature} | ${s.name} |\n`;
  }
  md += `\n</details>\n\n`;
}

if (r5Bdd.scenarios.length > 0) {
  md += `<details><summary><strong>R5 BDD Scenarios (${r5Bdd.passed}/${r5Bdd.total})</strong></summary>\n\n`;
  md += `| Status | Feature | Scenario |\n`;
  md += `|--------|---------|----------|\n`;
  for (const s of r5Bdd.scenarios) {
    const icon = s.status === 'PASS' ? ':white_check_mark:' : ':x:';
    md += `| ${icon} | ${s.feature} | ${s.name} |\n`;
  }
  md += `\n</details>\n\n`;
}

if (r4Validation && r4Validation.results && r4Validation.results.length > 0) {
  md += `<details><summary><strong>R4 FHIR Validator (${r4Vs.passed}/${r4Vs.total})</strong></summary>\n\n`;
  md += `| Status | Resource |\n`;
  md += `|--------|----------|\n`;
  for (const r of r4Validation.results) {
    const icon = r.status === 'PASS' ? ':white_check_mark:' : ':x:';
    md += `| ${icon} | ${r.file} |\n`;
  }
  md += `\n</details>\n\n`;
}

if (r4Quality && r4Quality.details && r4Quality.details.length > 0) {
  md += `<details><summary><strong>R4 Quality Issues (${r4Qs.issues})</strong></summary>\n\n`;
  md += `| Check | Detail |\n`;
  md += `|-------|--------|\n`;
  for (const d of r4Quality.details) {
    md += `| ${d.check} | ${d.detail} |\n`;
  }
  md += `\n</details>\n\n`;
}

if (r5Quality && r5Quality.details && r5Quality.details.length > 0) {
  md += `<details><summary><strong>R5 Quality Issues (${r5Qs.issues})</strong></summary>\n\n`;
  md += `| Check | Detail |\n`;
  md += `|-------|--------|\n`;
  for (const d of r5Quality.details) {
    md += `| ${d.check} | ${d.detail} |\n`;
  }
  md += `\n</details>\n\n`;
}

md += `---\n*Generated: ${new Date().toISOString()}*\n`;

fs.writeFileSync(outputFile, md);
console.log(`Summary written to ${outputFile}`);
