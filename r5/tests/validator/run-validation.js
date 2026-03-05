const { execSync } = require('child_process');
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
  console.error('fsh-generated not found. Run: sushi r5/');
  process.exit(1);
}

const DEPENDENCY_IGS = [
  'hl7.fhir.eu.base-r5#0.1.0'
];

const fshGenAbsolute = path.resolve(FSH_GENERATED).replace(/\\/g, '/');
const depArgs = DEPENDENCY_IGS.map(d => `-ig ${d}`).join(' ');

const examples = glob.sync(path.join(FSH_GENERATED, '*.json').replace(/\\/g, '/'))
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

console.log(`\n=== FHIR R5 Validator: Validating ${examples.length} example resources ===\n`);

if (examples.length === 0) {
  console.log('No R5 example resources found to validate. Skipping.');
  fs.writeFileSync(
    path.join(REPORTS_DIR, 'validation-results.json'),
    JSON.stringify({ summary: { passed: 0, failed: 0, total: 0, note: 'No R5 examples yet' }, results: [] }, null, 2)
  );
  process.exit(0);
}

let passed = 0;
let failed = 0;
const results = [];

for (const example of examples) {
  const name = path.basename(example);
  const exampleAbsolute = path.resolve(example).replace(/\\/g, '/');

  const cmd = [
    `java -Xmx4g -jar "${path.resolve(VALIDATOR_JAR).replace(/\\/g, '/')}"`,
    `"${exampleAbsolute}"`,
    '-version 5.0.0',
    `-ig "${fshGenAbsolute}"`,
    depArgs,
    '-tx n/a',
    '-no-extensible-binding-warnings',
    '-best-practice ignore'
  ].join(' ');

  try {
    const output = execSync(cmd, {
      encoding: 'utf8',
      timeout: 300000,
      stdio: ['pipe', 'pipe', 'pipe']
    });

    const hasError = /\*FAILURE\*/.test(output) || /[1-9]\d* error/.test(output);
    if (hasError) {
      const errorLines = output.split('\n').filter(l => /Error @|error/.test(l)).slice(0, 3).join('; ');
      console.log(`  FAIL  ${name}`);
      if (errorLines) console.log(`        ${errorLines}`);
      failed++;
      results.push({ file: name, status: 'FAIL', output });
    } else {
      console.log(`  PASS  ${name}`);
      passed++;
      results.push({ file: name, status: 'PASS', output });
    }
  } catch (err) {
    const stderr = err.stderr ? err.stderr.toString() : '';
    const stdout = err.stdout ? err.stdout.toString() : '';
    const combined = stdout + stderr;

    const errorLines = combined.split('\n')
      .filter(l => /error|Error|Exception|FAILURE|cannot resolve|not found/i.test(l))
      .slice(0, 5)
      .join('\n        ');

    console.log(`  FAIL  ${name}`);
    if (errorLines) {
      console.log(`        ${errorLines}`);
    } else {
      console.log(`        Exit code: ${err.status || 'unknown'}`);
      const lastLines = combined.split('\n').filter(l => l.trim()).slice(-5).join('\n        ');
      if (lastLines) console.log(`        ${lastLines}`);
    }

    failed++;
    results.push({ file: name, status: 'FAIL', output: combined || err.message });
  }
}

console.log(`\n=== R5 Results: ${passed} passed, ${failed} failed out of ${examples.length} ===\n`);

fs.writeFileSync(
  path.join(REPORTS_DIR, 'validation-results.json'),
  JSON.stringify({ summary: { passed, failed, total: examples.length }, results }, null, 2)
);

if (failed > 0) process.exit(1);
