const { Given, When, Then } = require('@cucumber/cucumber');
const { expect } = require('chai');

const PATTERNS = {
  // HIQA EP/PS 1.3.1: 18 or 10 digits (ie-pat-r5-1). GMS/DPS/LTI/HAA formats removed: unsourced (ADR-006).
  IHI: /^([0-9]{18}|[0-9]{10})$/,
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

Then('the value should match the Eircode pattern', function () {
  expect(this.postalCode).to.match(PATTERNS.Eircode);
});
