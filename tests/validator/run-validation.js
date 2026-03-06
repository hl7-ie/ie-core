const { exec } = require('child_process');
const fs = require('fs');
const path = require('path');
const glob = require('glob');

const VALIDATOR_JAR = path.join(__dirname, 'validator_cli.jar');
const IG_ROOT = path.resolve(__dirname, '..', '..');
const FSH_GENERATED = path.join(IG_ROOT, 'fsh-generated', 'resources');
const REPORTS_DIR = path.join(__dirname, '..', 'reports');

if (!fs.existsSync(REPORTS_DIR)) fs.mkdirSync(REPORTS_DIR, { recursive: true });

if (!fs.existsSync(VALIDATOR_JAR)) {
  console.error('validator_cli.jar not found. Run: npm run download:validator');
  process.exit(1);
}

if (!fs.existsSync(FSH_GENERATED)) {
  console.error('fsh-generated not found. Run sushi first: sushi .');
  process.exit(1);
}

const DEPENDENCY_IGS = [
  'hl7.fhir.eu.base#0.1.0',
  'hl7.fhir.uv.ips#1.1.0',
  'hl7.fhir.eu.laboratory#0.1.1'
];

// Domain filtering: pass --domain <name> to validate only a subset of resources.
// Each domain maps to a regex that matches the JSON filename prefix (ResourceType-).
const DOMAIN_PATTERNS = {
  persons:       /^(Patient|Practitioner|PractitionerRole)-/,
  organizations: /^(Organization|Location)-/,
  clinical:      /^(Condition|AllergyIntolerance|Immunization|Observation|Encounter|Provenance)-/,
  medication:    /^Medication-/,
  prescription:  /^MedicationRequest-/,
  dispense:      /^MedicationDispense-/,
};

const domainArgIdx = process.argv.indexOf('--domain');
const domainArg = domainArgIdx !== -1 ? process.argv[domainArgIdx + 1] : null;

if (domainArg && !DOMAIN_PATTERNS[domainArg]) {
  console.error(`Unknown domain: "${domainArg}". Valid domains: ${Object.keys(DOMAIN_PATTERNS).join(', ')}`);
  process.exit(1);
}

const fshGenAbsolute = path.resolve(FSH_GENERATED).replace(/\\/g, '/');
const depArgs = DEPENDENCY_IGS.map(d => `-ig ${d}`).join(' ');

const candidateExamples = glob.sync(path.join(FSH_GENERATED, '*.json').replace(/\\/g, '/'))
  .filter(f => {
    const name = path.basename(f);
    return !name.startsWith('StructureDefinition-') &&
           !name.startsWith('ValueSet-') &&
           !name.startsWith('CodeSystem-') &&
           !name.startsWith('ImplementationGuide-') &&
           !name.startsWith('SearchParameter-') &&
           !name.startsWith('CapabilityStatement-') &&
           !name.startsWith('TestScript-');
  });

const examples = domainArg
  ? candidateExamples.filter(f => DOMAIN_PATTERNS[domainArg].test(path.basename(f)))
  : candidateExamples;

const CONCURRENCY = 4;
const domainLabel = domainArg ? ` [${domainArg}]` : '';

console.log(`\n=== FHIR Validator${domainLabel}: Validating ${examples.length} example resources (concurrency: ${CONCURRENCY}) ===\n`);

function validateExample(example) {
  return new Promise((resolve) => {
    const name = path.basename(example);
    const exampleAbsolute = path.resolve(example).replace(/\\/g, '/');

    const cmd = [
      `java -Xmx1500m -jar "${path.resolve(VALIDATOR_JAR).replace(/\\/g, '/')}"`,
      `"${exampleAbsolute}"`,
      '-version 4.0.1',
      `-ig "${fshGenAbsolute}"`,
      depArgs,
      '-tx n/a',
      '-no-extensible-binding-warnings',
      '-best-practice ignore'
    ].join(' ');

    exec(cmd, { encoding: 'utf8', timeout: 180000, maxBuffer: 10 * 1024 * 1024 }, (err, stdout, stderr) => {
      if (err) {
        const combined = (stdout || '') + (stderr || '');
        const errorLines = combined.split('\n')
          .filter(l => /error|Error|Exception|FAILURE|cannot resolve|not found/i.test(l))
          .slice(0, 5)
          .join('\n        ');

        console.log(`  FAIL  ${name}`);
        if (errorLines) {
          console.log(`        ${errorLines}`);
        } else {
          console.log(`        Exit code: ${err.code || 'unknown'}`);
          const lastLines = combined.split('\n').filter(l => l.trim()).slice(-5).join('\n        ');
          if (lastLines) console.log(`        ${lastLines}`);
        }

        resolve({ file: name, status: 'FAIL', output: combined || err.message });
      } else {
        const hasError = /\*FAILURE\*/.test(stdout) || /[1-9]\d* error/.test(stdout);
        if (hasError) {
          const errorLines = stdout.split('\n').filter(l => /Error @|error/.test(l)).slice(0, 3).join('; ');
          console.log(`  FAIL  ${name}`);
          if (errorLines) console.log(`        ${errorLines}`);
          resolve({ file: name, status: 'FAIL', output: stdout });
        } else {
          console.log(`  PASS  ${name}`);
          resolve({ file: name, status: 'PASS', output: stdout });
        }
      }
    });
  });
}

async function runWithConcurrency(items, limit, fn) {
  const results = [];
  for (let i = 0; i < items.length; i += limit) {
    const batch = items.slice(i, i + limit);
    const batchResults = await Promise.all(batch.map(fn));
    results.push(...batchResults);
  }
  return results;
}

(async () => {
  if (examples.length === 0) {
    console.log('No example resources found to validate. Skipping.');
    const reportFile = domainArg ? `validation-results-${domainArg}.json` : 'validation-results.json';
    fs.writeFileSync(
      path.join(REPORTS_DIR, reportFile),
      JSON.stringify({ summary: { passed: 0, failed: 0, total: 0 }, results: [] }, null, 2)
    );
    process.exit(0);
  }

  // Run the first example sequentially so the FHIR validator can download and
  // lock the package cache without contention, then run the rest in parallel.
  console.log('Warming up FHIR package cache (1 sequential run)...\n');
  const warmupResult = await validateExample(examples[0]);
  const remaining = examples.slice(1);
  const concurrentResults = await runWithConcurrency(remaining, CONCURRENCY, validateExample);
  const results = [warmupResult, ...concurrentResults];

  const passed = results.filter(r => r.status === 'PASS').length;
  const failed = results.filter(r => r.status === 'FAIL').length;

  console.log(`\n=== Results${domainLabel}: ${passed} passed, ${failed} failed out of ${examples.length} ===\n`);

  const reportFile = domainArg ? `validation-results-${domainArg}.json` : 'validation-results.json';
  fs.writeFileSync(
    path.join(REPORTS_DIR, reportFile),
    JSON.stringify({ summary: { passed, failed, total: examples.length }, results }, null, 2)
  );

  if (failed > 0) process.exit(1);
})();
