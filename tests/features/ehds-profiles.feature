@ehds-profiles
Feature: EHDS Priority Category Profiles
  As an EU Member State implementation
  I want to verify that IE Core includes profiles for all 5 EHDS priority categories
  So that cross-border interoperability is supported

  Background:
    Given the SUSHI compiler has been run successfully
    And the fsh-generated resources are available

  @patient-summary
  Scenario: IE Core Patient Summary profile exists
    Given I have the profile "StructureDefinition-ie-core-composition-patient-summary.json"
    Then the resource should have resourceType "StructureDefinition"
    And the profile should have type "Composition"

  @eprescription
  Scenario: IE Core ePrescription profile exists
    Given I have the profile "StructureDefinition-ie-core-medicationrequest-eprescription.json"
    Then the resource should have resourceType "StructureDefinition"
    And the profile should have type "MedicationRequest"

  @edispensation
  Scenario: IE Core eDispensation profile exists
    Given I have the profile "StructureDefinition-ie-core-medicationdispense-edispensation.json"
    Then the resource should have resourceType "StructureDefinition"
    And the profile should have type "MedicationDispense"

  @eprescription-medication
  Scenario: IE Core ePrescription Medication profile exists
    Given I have the profile "StructureDefinition-ie-core-medication-eprescription.json"
    Then the resource should have resourceType "StructureDefinition"
    And the profile should have type "Medication"

  @laboratory-report
  Scenario: IE Core Laboratory Report profile exists
    Given I have the profile "StructureDefinition-ie-core-laboratory-report.json"
    Then the resource should have resourceType "StructureDefinition"
    And the profile should have type "DiagnosticReport"

  @hospital-discharge
  Scenario: IE Core Hospital Discharge Report profile exists
    Given I have the profile "StructureDefinition-ie-core-composition-discharge-report.json"
    Then the resource should have resourceType "StructureDefinition"
    And the profile should have type "Composition"

  @eprescription-derives
  Scenario: ePrescription profile derives from IE Core MedicationRequest
    Given I have the profile "StructureDefinition-ie-core-medicationrequest-eprescription.json"
    Then the profile baseDefinition should be "https://hl7-ie.github.io/hl7-ie-fhir-draft-ig/fhir/ie/core/StructureDefinition/ie-core-medicationrequest"

  @edispensation-derives
  Scenario: eDispensation profile derives from IE Core MedicationDispense
    Given I have the profile "StructureDefinition-ie-core-medicationdispense-edispensation.json"
    Then the profile baseDefinition should be "https://hl7-ie.github.io/hl7-ie-fhir-draft-ig/fhir/ie/core/StructureDefinition/ie-core-medicationdispense"

  @all-five-categories
  Scenario: All 5 EHDS priority categories have IE Core profiles
    Given I have all IE Core profile StructureDefinitions
    Then a profile should exist with id containing "patient-summary"
    And a profile should exist with id containing "medicationrequest-eprescription"
    And a profile should exist with id containing "medicationdispense-edispensation"
    And a profile should exist with id containing "laboratory-report"
    And a profile should exist with id containing "discharge-report"
