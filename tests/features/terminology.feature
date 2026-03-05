@terminology
Feature: Terminology Validation
  As an implementer
  I want to verify that IE Core terminologies are well-formed
  So that coded data exchange is reliable

  Background:
    Given the SUSHI compiler has been run successfully
    And the fsh-generated resources are available

  @valueset
  Scenario: All ValueSets have at least one include
    Given I have all IE Core ValueSet resources
    Then every ValueSet should have a compose with at least 1 include

  @codesystem
  Scenario: All CodeSystems have at least one concept
    Given I have all IE Core CodeSystem resources
    Then every CodeSystem should have at least 1 concept

  @county-codes
  Scenario: IE Core County CodeSystem contains all 26 Irish counties
    Given I have the resource "CodeSystem-ie-core-county-codes.json"
    Then the CodeSystem should have at least 26 concepts
    And the CodeSystem should contain concept with code "D"
    And the CodeSystem should contain concept with code "CO"
    And the CodeSystem should contain concept with code "G"

  @valueset-status
  Scenario: All terminologies have draft status
    Given I have all IE Core ValueSet resources
    And I have all IE Core CodeSystem resources
    Then every terminology resource should have status "draft"
