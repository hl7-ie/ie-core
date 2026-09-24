const { Given, When, Then } = require('@cucumber/cucumber');
const { expect } = require('chai');
const fs = require('fs');
const path = require('path');

const RESOURCES = path.join(__dirname, '..', '..', '..', 'fsh-generated', 'resources');

// Read a FHIRPath `value.matches('<regex>')` invariant from the generated StructureDefinition,
// so these tests exercise the IG's actual rule rather than a copy of it.
function invariantRegex(profileId, key) {
  const sd = JSON.parse(fs.readFileSync(path.join(RESOURCES, `StructureDefinition-${profileId}.json`), 'utf8'));
  for (const el of sd.differential.element) {
    for (const c of el.constraint || []) {
      if (c.key === key) {
        const m = c.expression.match(/matches\('(.+)'\)/);
        if (!m) throw new Error(`${key} is not a matches() invariant: ${c.expression}`);
        return new RegExp(m[1]);
      }
    }
  }
  throw new Error(`Invariant ${key} not found in ${profileId}`);
}

const PATTERNS = {
  // HIQA EP/PS 1.3.1: "A unique 18 or 10-digit number" (ie-pat-1)
  IHI: () => invariantRegex('ie-core-patient', 'ie-pat-1'),
  // HIQA EP/PS 1.3.2: "seven numbers followed by either one or two letters" (ie-pat-ppsn-1)
  PPSN: () => invariantRegex('ie-core-patient-eprescription', 'ie-pat-ppsn-1'),
  // HIQA EP 1.2.1 guidance: Eircode format XXX XXXX (guidance only; not an IG invariant)
  Eircode: () => /^[A-Za-z]\d{2}\s?[A-Za-z0-9]{4}$/
};

Given('a Patient identifier with system {string}', function (system) {
  this.identifierSystem = system;
});

When('the identifier value is {string}', function (value) {
  this.identifierValue = value;
});

When('the postal code value is {string}', function (value) {
  this.postalCode = value;
});

Then('the value should match the {word} pattern', function (name) {
  expect(this.identifierValue ?? this.postalCode).to.match(PATTERNS[name]());
});

Then('the value should not match the {word} pattern', function (name) {
  expect(this.identifierValue ?? this.postalCode).to.not.match(PATTERNS[name]());
});
