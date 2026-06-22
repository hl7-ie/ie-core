const fs = require('fs');
const path = require('path');
const glob = require('glob');

const ROOT = path.resolve(__dirname, '..', '..');
const FSH_DIR = path.join(ROOT, 'input', 'fsh').replace(/\\/g, '/');
const FSH_GENERATED = path.join(ROOT, 'fsh-generated', 'resources').replace(/\\/g, '/');
const REPORTS_DIR = path.join(__dirname, '..', 'reports');

if (!fs.existsSync(REPORTS_DIR)) fs.mkdirSync(REPORTS_DIR, { recursive: true });

if (!fs.existsSync(FSH_GENERATED)) {
  console.error('fsh-generated not found. Run sushi first: sushi .');
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

// --- Check 1: Every profile must have a description ---
console.log('\n=== Quality Control Checks ===\n');
console.log('1. Checking profile descriptions...');
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
console.log('2. Checking profile status = draft...');
for (const pf of profiles) {
  const sd = JSON.parse(fs.readFileSync(pf, 'utf8'));
  check(
    'profile-status-draft',
    sd.status === 'draft',
    `${sd.id} has status "${sd.status}" instead of "draft"`
  );
}

// --- Check 3: All ValueSets must have at least one compose.include ---
console.log('3. Checking ValueSet composition...');
const valueSets = glob.sync(`${FSH_GENERATED}/ValueSet-*.json`);
for (const vsf of valueSets) {
  const vs = JSON.parse(fs.readFileSync(vsf, 'utf8'));
  check(
    'valueset-has-compose',
    vs.compose && vs.compose.include && vs.compose.include.length > 0,
    `${vs.id} has no compose.include`
  );
}

// --- Check 4: CodeSystems must have at least one concept ---
console.log('4. Checking CodeSystem concepts...');
const codeSystems = glob.sync(`${FSH_GENERATED}/CodeSystem-*.json`);
for (const csf of codeSystems) {
  const cs = JSON.parse(fs.readFileSync(csf, 'utf8'));
  check(
    'codesystem-has-concepts',
    cs.concept && cs.concept.length > 0,
    `${cs.id} has no concepts`
  );
}

// --- Check 5: Examples must reference a valid profile ---
console.log('5. Checking example meta.profile references...');
const examples = glob.sync(`${FSH_GENERATED}/*.json`)
  .filter(f => {
    const n = path.basename(f);
    return !n.startsWith('StructureDefinition-') && !n.startsWith('ValueSet-') &&
           !n.startsWith('CodeSystem-') && !n.startsWith('ImplementationGuide-') &&
           !n.startsWith('SearchParameter-') && !n.startsWith('CapabilityStatement-');
  });
for (const ef of examples) {
  const res = JSON.parse(fs.readFileSync(ef, 'utf8'));
  if (res.meta && res.meta.profile && res.meta.profile.length > 0) {
    check(
      'example-has-profile',
      res.meta.profile[0].includes('hl7-ie.github.io') || res.meta.profile[0].includes('hl7.org'),
      `${path.basename(ef)} profile reference: ${res.meta.profile[0]}`
    );
  }
}

// --- Check 6: No FSH files with ^status = #active ---
console.log('6. Checking FSH definition files for status = active...');
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
console.log('7. Checking sushi-config.yaml...');
const configPath = path.join(ROOT, 'sushi-config.yaml');
if (fs.existsSync(configPath)) {
  const config = fs.readFileSync(configPath, 'utf8');
  check('config-has-canonical', config.includes('canonical:'), 'Missing canonical URL');
  check('config-has-version', config.includes('version:'), 'Missing version');
  check('config-has-jurisdiction', config.includes('jurisdiction:'), 'Missing jurisdiction');
  check('config-has-publisher', config.includes('publisher:'), 'Missing publisher');
  check('config-has-eu-dependency', config.includes('hl7.fhir.eu.base'), 'Missing EU Base dependency');
}

// --- Check 8: Canonical URL consistency ---
console.log('8. Checking canonical URL consistency...');
for (const pf of profiles) {
  const sd = JSON.parse(fs.readFileSync(pf, 'utf8'));
  check(
    'canonical-url-consistent',
    sd.url && sd.url.startsWith('https://hl7-ie.github.io/ie-core-fhir-ig-draft/fhir/ie/core/'),
    `${sd.id} URL: ${sd.url}`
  );
}

// --- Summary ---
const total = passed + issues.length;
console.log(`\n=== Quality Results: ${passed}/${total} passed, ${issues.length} issues ===\n`);

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
