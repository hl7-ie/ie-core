const { Given, When, Then } = require('@cucumber/cucumber');
const { expect } = require('chai');

const PATTERNS = {
  IHI: /^[0-9]{18}$/,
  GMS: /^[0-9]{7}[A-Za-z]$/,
  DPS: /^[0-9]{7}[A-Za-z]{1,2}$/,
  LTI: /^[0-9]{7}[A-Za-z]{1,2}$/,
  HAA: /^[A-Za-z0-9]{8,10}$/,
  Eircode: /^[A-Za-z]\d{2}\s?[A-Za-z0-9]{4}$/
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

Then('the value should match the IHI pattern', function () {
  expect(this.identifierValue).to.match(PATTERNS.IHI);
});

Then('the value should not match the IHI pattern', function () {
  expect(this.identifierValue).to.not.match(PATTERNS.IHI);
});

Then('the value should match the GMS pattern', function () {
  expect(this.identifierValue).to.match(PATTERNS.GMS);
});

Then('the value should not match the GMS pattern', function () {
  expect(this.identifierValue).to.not.match(PATTERNS.GMS);
});

Then('the value should match the Eircode pattern', function () {
  expect(this.postalCode).to.match(PATTERNS.Eircode);
});
