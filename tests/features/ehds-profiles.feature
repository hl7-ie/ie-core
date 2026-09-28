@ehds-profiles
Feature: EHDS Priority Category Profiles
  As an EU Member State implementation
  I want to verify that IE Core includes profiles for the EHDS priority categories it covers
  So that cross-border interoperability is supported

  Background:
    Given the SUSHI compiler has been run successfully
    And the fsh-generated resources are available

  @patient-summary
  Scenario: IE Core Patient Summary profile exists
    Given I have the profile "StructureDefinition-ie-core-composition-patient-summary.json"
    Then the resource should have resourceType "StructureDefinition"
    And the profile should have type "Composition"

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

  @ehds-categories
  Scenario: IE Core covers the Patient Summary, laboratory and discharge categories
    Given I have all IE Core profile StructureDefinitions
    Then a profile should exist with id containing "patient-summary"
    And a profile should exist with id containing "laboratory-report"
    And a profile should exist with id containing "discharge-report"

  @no-eprescription
  Scenario: ePrescription and eDispensation are not in IE Core (ADR-009: IE Medication Events)
    Given I have all IE Core profile StructureDefinitions
    Then no profile should exist with id containing "eprescription"
    And no profile should exist with id containing "edispensation"
    And no profile should exist with id containing "medicationrequest"
    And no profile should exist with id containing "medicationdispense"
