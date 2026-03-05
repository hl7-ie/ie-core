@profile-validation
Feature: IE Core Profile Validation
  As an implementer of IE Core FHIR profiles
  I want to validate that example resources conform to IE Core profiles
  So that I can ensure interoperability within the Irish healthcare system

  Background:
    Given the SUSHI compiler has been run successfully
    And the fsh-generated resources are available

  @patient
  Scenario: IE Core Patient example validates against the profile
    Given I have the example resource "Patient-ie-core-patient-example.json"
    Then the resource should have resourceType "Patient"
    And the resource should have a meta.profile containing "http://hl7.hse.ie/fhir/ie/core/StructureDefinition/ie-core-patient"
    And the resource should have at least 1 identifier
    And the resource should have a name with a family component
    And the resource should have a gender value

  @patient @identifiers
  Scenario: IE Core Patient IHI identifier format is valid
    Given I have the example resource "Patient-ie-core-patient-example.json"
    When I extract identifiers with system "http://hl7.hse.ie/fhir/ie/core/sid/ihi"
    Then each identifier value should match pattern "^[0-9]{18}$"

  @patient @identifiers
  Scenario: IE Core Patient GMS identifier format is valid
    Given I have the example resource "Patient-ie-core-patient-example.json"
    When I extract identifiers with system "http://hl7.hse.ie/fhir/ie/core/sid/gms"
    Then each identifier value should match pattern "^[0-9]{7}[A-Za-z]$"

  @practitioner
  Scenario: IE Core Practitioner example validates against the profile
    Given I have the example resource "Practitioner-ie-core-practitioner-example.json"
    Then the resource should have resourceType "Practitioner"
    And the resource should have at least 1 identifier
    And the resource should have a name with a family component

  @organization
  Scenario: IE Core Organization example validates against the profile
    Given I have the example resource "Organization-ie-core-organization-example.json"
    Then the resource should have resourceType "Organization"
    And the resource should have an active status
    And the resource should have a name value

  @encounter
  Scenario: IE Core Encounter example validates against the profile
    Given I have the example resource "Encounter-ie-core-encounter-example.json"
    Then the resource should have resourceType "Encounter"
    And the resource should have a status value
    And the resource should have a class value

  @observation
  Scenario: IE Core Observation Lab example validates against the profile
    Given I have the example resource "Observation-ie-core-observation-lab-example.json"
    Then the resource should have resourceType "Observation"
    And the resource should have a status value
    And the resource should have a code value

  @condition
  Scenario: IE Core Condition example validates against the profile
    Given I have the example resource "Condition-ie-core-condition-example.json"
    Then the resource should have resourceType "Condition"
    And the resource should have a code value
    And the resource should have a subject reference
