const { Then } = require('@cucumber/cucumber');
const { expect } = require('chai');

Then('every ValueSet should have a compose with at least {int} include(s)', function (count) {
  for (const vs of this.valueSets) {
    expect(vs.compose, `ValueSet ${vs.id} missing compose`).to.exist;
    expect(vs.compose.include, `ValueSet ${vs.id} missing compose.include`).to.be.an('array');
    expect(vs.compose.include.length, `ValueSet ${vs.id}`).to.be.at.least(count);
  }
});

Then('every CodeSystem should have at least {int} concept(s)', function (count) {
  for (const cs of this.codeSystems) {
    expect(cs.concept, `CodeSystem ${cs.id} missing concepts`).to.be.an('array');
    expect(cs.concept.length, `CodeSystem ${cs.id}`).to.be.at.least(count);
  }
});

Then('the CodeSystem should have at least {int} concepts', function (count) {
  expect(this.resource.concept).to.be.an('array');
  expect(this.resource.concept.length).to.be.at.least(count);
});

Then('the CodeSystem should contain concept with code {string}', function (code) {
  const found = this.resource.concept.some(c => c.code === code);
  expect(found, `Concept "${code}" not found in CodeSystem`).to.be.true;
});

Then('every terminology resource should have status {string}', function (status) {
  const all = [...this.valueSets, ...this.codeSystems];
  for (const res of all) {
    expect(res.status, `${res.resourceType}/${res.id}`).to.equal(status);
  }
});
