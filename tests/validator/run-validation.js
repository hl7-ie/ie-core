const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');
const glob = require('glob');

const VALIDATOR_JAR = path.join(__dirname, 'validator_cli.jar');
const IG_PACKAGE = path.resolve(__dirname, '..', '..');
const FSH_GENERATED = path.join(IG_PACKAGE, 'fsh-generated', 'resources');
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

const examples = glob.sync(path.join(FSH_GENERATED, '*.json').replace(/\\/g, '/'))
  .filter(f => {
    const name = path.basename(f);
    return !name.startsWith('StructureDefinition-') &&
           !name.startsWith('ValueSet-') &&
           !name.startsWith('CodeSystem-') &&
           !name.startsWith('ImplementationGuide-') &&
           !name.startsWith('SearchParameter-') &&
           !name.startsWith('CapabilityStatement-');
  });

console.log(`\n=== FHIR Validator: Validating ${examples.length} example resources ===\n`);

let passed = 0;
let failed = 0;
const results = [];

for (const example of examples) {
  const name = path.basename(example);
  const resource = JSON.parse(fs.readFileSync(example, 'utf8'));
  const profiles = (resource.meta && resource.meta.profile) || [];

  const profileArgs = profiles.map(p => `-profile ${p}`).join(' ');

  try {
    const cmd = `java -jar "${VALIDATOR_JAR}" "${example}" -version 4.0.1 -ig "${IG_PACKAGE}" ${profileArgs} -output-style compact`;
    const output = execSync(cmd, { encoding: 'utf8', timeout: 120000, stdio: ['pipe', 'pipe', 'pipe'] });

    const hasError = /\*FAILURE\*/.test(output) || / 0 errors/.test(output) === false;
    if (hasError && /[1-9]\d* error/.test(output)) {
      console.log(`  FAIL  ${name}`);
      failed++;
      results.push({ file: name, status: 'FAIL', output });
    } else {
      console.log(`  PASS  ${name}`);
      passed++;
      results.push({ file: name, status: 'PASS', output });
    }
  } catch (err) {
    console.log(`  FAIL  ${name}: ${err.message.split('\n')[0]}`);
    failed++;
    results.push({ file: name, status: 'FAIL', output: err.stderr || err.message });
  }
}

console.log(`\n=== Results: ${passed} passed, ${failed} failed out of ${examples.length} ===\n`);

fs.writeFileSync(
  path.join(REPORTS_DIR, 'validation-results.json'),
  JSON.stringify({ summary: { passed, failed, total: examples.length }, results }, null, 2)
);

if (failed > 0) process.exit(1);
