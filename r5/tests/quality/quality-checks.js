const fs = require('fs');
const path = require('path');
const glob = require('glob');

const ROOT = path.resolve(__dirname, '..', '..');
const FSH_DIR = path.join(ROOT, 'input', 'fsh').replace(/\\/g, '/');
const FSH_GENERATED = path.join(ROOT, 'fsh-generated', 'resources').replace(/\\/g, '/');
const REPORTS_DIR = path.join(__dirname, '..', 'reports');

if (!fs.existsSync(REPORTS_DIR)) fs.mkdirSync(REPORTS_DIR, { recursive: true });

if (!fs.existsSync(FSH_GENERATED)) {
  console.error('fsh-generated not found. Run sushi r5/.');
  process.exit(1);
}

let issues = [];
let passed = 0;

function check(name, condition, detail) {
  if (condition) {
    passed++;
  } else {
    issues.push({ check: name, detail });
  }
}

console.log('\n=== R5 Quality Control Checks ===\n');

// --- Check 1: Every profile must have a description ---
console.log('1. Checking R5 profile descriptions...');
const profiles = glob.sync(`${FSH_GENERATED}/StructureDefinition-ie-core-*.json`);
for (const pf of profiles) {
  const sd = JSON.parse(fs.readFileSync(pf, 'utf8'));
  check(
    'profile-has-description',
    sd.description && sd.description.length > 20,
    `${sd.id} missing or short description`
  );
}

// --- Check 2: Every profile must have status = draft ---
console.log('2. Checking R5 profile status = draft...');
for (const pf of profiles) {
  const sd = JSON.parse(fs.readFileSync(pf, 'utf8'));
  check(
    'profile-status-draft',
    sd.status === 'draft',
    `${sd.id} has status "${sd.status}" instead of "draft"`
  );
}

// --- Check 3: R5 profiles must declare fhirVersion 5.0.0 ---
console.log('3. Checking R5 fhirVersion = 5.0.0...');
for (const pf of profiles) {
  const sd = JSON.parse(fs.readFileSync(pf, 'utf8'));
  check(
    'profile-fhir-version-r5',
    sd.fhirVersion === '5.0.0',
    `${sd.id} has fhirVersion "${sd.fhirVersion}" instead of "5.0.0"`
  );
}

// --- Check 4: All ValueSets must have at least one compose.include ---
console.log('4. Checking ValueSet composition...');
const valueSets = glob.sync(`${FSH_GENERATED}/ValueSet-*.json`);
for (const vsf of valueSets) {
  const vs = JSON.parse(fs.readFileSync(vsf, 'utf8'));
  check(
    'valueset-has-compose',
    vs.compose && vs.compose.include && vs.compose.include.length > 0,
    `${vs.id} has no compose.include`
  );
}

// --- Check 5: CodeSystems must have at least one concept ---
console.log('5. Checking CodeSystem concepts...');
const codeSystems = glob.sync(`${FSH_GENERATED}/CodeSystem-*.json`);
for (const csf of codeSystems) {
  const cs = JSON.parse(fs.readFileSync(csf, 'utf8'));
  check(
    'codesystem-has-concepts',
    cs.concept && cs.concept.length > 0,
    `${cs.id} has no concepts`
  );
}

// --- Check 6: No FSH files with ^status = #active ---
console.log('6. Checking R5 FSH definition files for status = active...');
const fshFiles = glob.sync(`${FSH_DIR}/**/*.fsh`)
  .filter(f => !path.basename(f).toLowerCase().includes('example'));
for (const ff of fshFiles) {
  const content = fs.readFileSync(ff, 'utf8');
  check(
    'no-active-status',
    !content.includes('^status = #active') && !/^\*\s+status\s*=\s*#active/m.test(content),
    `${path.basename(ff)} contains "active" status in a definition`
  );
}

// --- Check 7: sushi-config.yaml must have required fields ---
console.log('7. Checking R5 sushi-config.yaml...');
const configPath = path.join(ROOT, 'sushi-config.yaml');
if (fs.existsSync(configPath)) {
  const config = fs.readFileSync(configPath, 'utf8');
  check('config-has-canonical', config.includes('canonical:'), 'Missing canonical URL');
  check('config-has-version', config.includes('version:'), 'Missing version');
  check('config-has-jurisdiction', config.includes('jurisdiction:'), 'Missing jurisdiction');
  check('config-has-publisher', config.includes('publisher:'), 'Missing publisher');
  check('config-has-fhir-r5', config.includes('5.0.0'), 'sushi-config.yaml should declare FHIR R5 (5.0.0)');
}

// --- Check 8: Canonical URL consistency (R5) ---
console.log('8. Checking R5 canonical URL consistency...');
for (const pf of profiles) {
  const sd = JSON.parse(fs.readFileSync(pf, 'utf8'));
  check(
    'canonical-url-consistent',
    sd.url && sd.url.startsWith('https://hl7-ie.github.io/ie-core/fhir/ie/core-r5/'),
    `${sd.id} URL: ${sd.url}`
  );
}

// --- Check 9: R5 profiles should derive from EU Core R5 where applicable ---
console.log('9. Checking EU Core R5 derivation...');
const euR5Derivations = {
  'ie-core-patient-r5': 'http://hl7.eu/fhir/base-r5/StructureDefinition/patient-eu-core',
  'ie-core-practitioner-r5': 'http://hl7.eu/fhir/base-r5/StructureDefinition/practitioner-eu-core',
  'ie-core-organization-r5': 'http://hl7.eu/fhir/base-r5/StructureDefinition/organization-eu-core'
};
for (const pf of profiles) {
  const sd = JSON.parse(fs.readFileSync(pf, 'utf8'));
  if (euR5Derivations[sd.id]) {
    check(
      'eu-core-r5-derivation',
      sd.baseDefinition === euR5Derivations[sd.id],
      `${sd.id} should derive from ${euR5Derivations[sd.id]}, got ${sd.baseDefinition}`
    );
  }
}

// --- Summary ---
const total = passed + issues.length;
console.log(`\n=== R5 Quality Results: ${passed}/${total} passed, ${issues.length} issues ===\n`);

if (issues.length > 0) {
  console.log('Issues found:');
  for (const issue of issues) {
    console.log(`  - [${issue.check}] ${issue.detail}`);
  }
}

fs.writeFileSync(
  path.join(REPORTS_DIR, 'quality-results.json'),
  JSON.stringify({ summary: { passed, issues: issues.length, total }, details: issues }, null, 2)
);

if (issues.length > 0) process.exit(1);
