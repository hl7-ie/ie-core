@eu-conformance @r5
Feature: EU Core R5 Conformance
  As an EU Member State implementation
  I want to verify that IE Core R5 profiles derive from EU Core R5 profiles
  So that cross-border interoperability is ensured under EHDS with FHIR R5

  Background:
    Given the SUSHI compiler has been run successfully
    And the fsh-generated resources are available

  @eu-patient-r5
  Scenario: IE Core Patient R5 derives from EU Core Patient R5
    Given I have the profile "StructureDefinition-ie-core-patient-r5.json"
    Then the profile baseDefinition should be "http://hl7.eu/fhir/base-r5/StructureDefinition/patient-eu-core"

  @eu-practitioner-r5
  Scenario: IE Core Practitioner R5 derives from EU Core Practitioner R5
    Given I have the profile "StructureDefinition-ie-core-practitioner-r5.json"
    Then the profile baseDefinition should be "http://hl7.eu/fhir/base-r5/StructureDefinition/practitioner-eu-core"

  @eu-organization-r5
  Scenario: IE Core Organization R5 derives from EU Core Organization R5
    Given I have the profile "StructureDefinition-ie-core-organization-r5.json"
    Then the profile baseDefinition should be "http://hl7.eu/fhir/base-r5/StructureDefinition/organization-eu-core"

  @eu-canonical-r5
  Scenario: All IE Core R5 profiles use the correct canonical base URL
    Given I have all IE Core R5 profile StructureDefinitions
    Then every profile URL should start with "https://hl7-ie.github.io/ie-core-fhir-ig-draft/fhir/ie/core-r5/"

  @fhir-version-r5
  Scenario: All R5 profiles declare FHIR version 5.0.0
    Given I have all IE Core R5 profile StructureDefinitions
    Then every profile fhirVersion should be "5.0.0"
