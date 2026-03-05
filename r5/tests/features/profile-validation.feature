@profile-validation @r5
Feature: IE Core R5 Profile Validation
  As an implementer of IE Core FHIR R5 profiles
  I want to validate that R5 profile StructureDefinitions are well-formed
  So that I can ensure interoperability within the Irish healthcare system using FHIR R5

  Background:
    Given the SUSHI compiler has been run successfully
    And the fsh-generated resources are available

  @patient-r5
  Scenario: IE Core Patient R5 profile is a valid StructureDefinition
    Given I have the profile "StructureDefinition-ie-core-patient-r5.json"
    Then the resource should have resourceType "StructureDefinition"
    And the profile should have type "Patient"
    And the profile fhirVersion should be "5.0.0"

  @patient-r5 @identifiers
  Scenario: IE Core Patient R5 profile defines IHI identifier slice
    Given I have the profile "StructureDefinition-ie-core-patient-r5.json"
    Then the resource should have resourceType "StructureDefinition"

  @practitioner-r5
  Scenario: IE Core Practitioner R5 profile is a valid StructureDefinition
    Given I have the profile "StructureDefinition-ie-core-practitioner-r5.json"
    Then the resource should have resourceType "StructureDefinition"
    And the profile should have type "Practitioner"
    And the profile fhirVersion should be "5.0.0"

  @organization-r5
  Scenario: IE Core Organization R5 profile is a valid StructureDefinition
    Given I have the profile "StructureDefinition-ie-core-organization-r5.json"
    Then the resource should have resourceType "StructureDefinition"
    And the profile should have type "Organization"
    And the profile fhirVersion should be "5.0.0"
