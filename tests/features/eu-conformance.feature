@eu-conformance
Feature: EU Core Conformance
  As an EU Member State implementation
  I want to verify that IE Core profiles derive from EU Core profiles
  So that cross-border interoperability is ensured

  Background:
    Given the SUSHI compiler has been run successfully
    And the fsh-generated resources are available

  @eu-patient
  Scenario: IE Core Patient derives from EU Core Patient
    Given I have the profile "StructureDefinition-ie-core-patient.json"
    Then the profile baseDefinition should be "http://hl7.eu/fhir/base/StructureDefinition/patient-eu-core"

  @eu-practitioner
  Scenario: IE Core Practitioner derives from EU Core Practitioner
    Given I have the profile "StructureDefinition-ie-core-practitioner.json"
    Then the profile baseDefinition should be "http://hl7.eu/fhir/base/StructureDefinition/practitioner-eu-core"

  @eu-practitionerrole
  Scenario: IE Core PractitionerRole derives from EU Core PractitionerRole
    Given I have the profile "StructureDefinition-ie-core-practitionerrole.json"
    Then the profile baseDefinition should be "http://hl7.eu/fhir/base/StructureDefinition/practitionerRole-eu-core"

  @eu-organization
  Scenario: IE Core Organization derives from EU Core Organization
    Given I have the profile "StructureDefinition-ie-core-organization.json"
    Then the profile baseDefinition should be "http://hl7.eu/fhir/base/StructureDefinition/organization-eu-core"

  @eu-location
  Scenario: IE Core Location derives from EU Core Location
    Given I have the profile "StructureDefinition-ie-core-location.json"
    Then the profile baseDefinition should be "http://hl7.eu/fhir/base/StructureDefinition/location-eu-core"

  @eu-canonical
  Scenario: All IE Core profiles use the correct canonical base URL
    Given I have all IE Core profile StructureDefinitions
    Then every profile URL should start with "https://hl7-ie.github.io/fhir/ie/core/"
