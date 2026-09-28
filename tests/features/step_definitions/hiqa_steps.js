// Steps for the HIQA Patient Summary feature file. HIQA ePrescription/eDispensation tests live in IE Medication Events (ADR-009).
const { Given, When, Then } = require('@cucumber/cucumber');
const { expect } = require('chai');
const { execFileSync } = require('child_process');
const path = require('path');
const { checkInvariant, loadExample } = require('../support/invariants');

const IE = 'https://hl7-ie.github.io/ie-core/fhir/ie/core';
const IG_ROOT = path.resolve(__dirname, '..', '..', '..');

const entriesOf = (bundle, type) => (bundle.entry || []).map(e => e.resource).filter(r => r.resourceType === type);
const first = (bundle, type) => entriesOf(bundle, type)[0];
const extUrl = name => `${IE}/StructureDefinition/${name}`;

// Named changes that each break exactly one HIQA rule. Applied to a deep copy of the loaded example.
const MUTATIONS = {
  'remove the allergies section empty reason': r => {
    const s = r.section.find(x => x.code.coding.some(c => c.code === '48765-2'));
    delete s.emptyReason;
  },
  'remove the attestation time': r => {
    delete r.attester[0].time;
  }
};

Given('the HIQA example {string}', function (filename) {
  this.resource = loadExample(filename);
});

When('I {string}', function (change) {
  const fn = MUTATIONS[change];
  if (!fn) throw new Error(`Unknown change "${change}". Known: ${Object.keys(MUTATIONS).join('; ')}`);
  this.resource = JSON.parse(JSON.stringify(this.resource));
  fn(this.resource);
});

Then('invariant {string} should pass', async function (key) {
  const res = await checkInvariant(this.resource, key);
  expect(res.passed, `${key} (${res.invariant.expression}) failed on ${this.resource.resourceType}/${this.resource.id}`).to.be.true;
});

Then('invariant {string} should fail', async function (key) {
  const res = await checkInvariant(this.resource, key);
  expect(res.passed, `${key} should have failed on the changed ${this.resource.resourceType}/${this.resource.id}`).to.be.false;
});

Then('the Bundle should claim profile {string}', function (id) {
  expect(this.resource.meta.profile).to.include(`${IE}/StructureDefinition/${id}`);
});

// ── Patient Summary ─────────────────────────────────────────────────
function composition(bundle) {
  const c = first(bundle, 'Composition');
  expect(bundle.entry[0].resource.resourceType, 'the first entry must be the Composition').to.equal('Composition');
  return c;
}
const sectionByLoinc = (comp, loinc) => comp.section.find(s => s.code.coding.some(c => c.code === loinc));

Then('the Composition should pass invariant {string}', async function (key) {
  const res = await checkInvariant(composition(this.resource), key);
  expect(res.passed, `${key} failed`).to.be.true;
});

Then('section {string} should have {int} entr(y)(ies)', function (loinc, n) {
  const s = sectionByLoinc(composition(this.resource), loinc);
  expect(s, `section ${loinc} missing`).to.exist;
  expect((s.entry || []).length).to.equal(n);
});

Then('section {string} should have empty reason {string}', function (loinc, code) {
  const s = sectionByLoinc(composition(this.resource), loinc);
  expect(s, `section ${loinc} missing`).to.exist;
  expect(s.entry, 'an empty section must not have entries').to.be.undefined;
  expect(s.emptyReason.coding[0].system).to.equal('http://terminology.hl7.org/CodeSystem/list-empty-reason');
  expect(s.emptyReason.coding[0].code).to.equal(code);
});

Then('every section should have a narrative', function () {
  for (const s of composition(this.resource).section) {
    expect(s.text && s.text.div, `section ${s.title} has no narrative`).to.match(/<div/);
  }
});

Then('every section entry should resolve to an entry in the Bundle', function () {
  const refs = new Set(this.resource.entry.map(e => `${e.resource.resourceType}/${e.resource.id}`));
  for (const s of composition(this.resource).section) {
    for (const e of s.entry || []) expect(refs.has(e.reference), `${e.reference} not in Bundle`).to.be.true;
  }
});

Then('example {string} should carry extension {string}', function (filename, name) {
  const r = loadExample(filename);
  expect((r.extension || []).some(x => x.url === extUrl(name) || x.url.endsWith(`/${name}`))).to.be.true;
});

// ── Scripts run as tests (traceability) ──────────────────────
function python() {
  for (const cmd of ['python', 'python3', 'py']) {
    try {
      execFileSync(cmd, ['--version'], { stdio: 'ignore' });
      return cmd;
    } catch (e) { /* try the next */ }
  }
  throw new Error('Python 3 is required for this scenario');
}

When('I run the script {string}', function (script) {
  const [file, ...args] = script.split(' ');
  try {
    this.scriptOutput = execFileSync(python(), [path.join(IG_ROOT, file), ...args],
      { cwd: IG_ROOT, encoding: 'utf8', stdio: ['ignore', 'pipe', 'pipe'] });
    this.scriptStatus = 0;
  } catch (e) {
    this.scriptOutput = String(e.stdout || '') + String(e.stderr || '');
    this.scriptStatus = e.status;
  }
});

Then('the script should succeed', function () {
  expect(this.scriptStatus, this.scriptOutput).to.equal(0);
});
