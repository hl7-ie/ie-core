@hiqa @hiqa-patient-summary
Feature: HIQA Draft National Standard for a Patient Summary (Sept 2026)
  As an implementer of IE Core
  I want Patient Summary documents to say why a section is empty
  So that a clinician can tell "nothing known" from "not asked" (clinical-safety hazard HZ-03)

  Background:
    Given the SUSHI compiler has been run successfully

  @ps-full
  Scenario: The full Patient Summary is a valid EPS document with populated sections
    Given the HIQA example "Bundle-hiqa-bundle-s7-patient-summary-full.json"
    Then the Bundle should claim profile "ie-core-bundle-patient-summary"
    And the Composition should pass invariant "ie-ps-1"
    And the Composition should pass invariant "ie-ps-attester-1"
    And every section should have a narrative
    And every section entry should resolve to an entry in the Bundle
    And section "48765-2" should have 1 entry
    And section "10160-0" should have 1 entry
    And section "11450-4" should have 1 entry
    And section "47519-4" should have 1 entry
    And section "11369-6" should have 1 entry
    And section "46264-8" should have empty reason "nilknown"
    And section "42348-3" should have empty reason "notasked"

  @ps-empty
  Scenario: The empty Patient Summary gives a reason for every empty section
    Given the HIQA example "Bundle-hiqa-bundle-s8-patient-summary-empty.json"
    Then the Composition should pass invariant "ie-ps-1"
    And every section should have a narrative
    And section "104605-1" should have empty reason "notasked"
    And section "48765-2" should have empty reason "nilknown"
    And section "10160-0" should have empty reason "nilknown"
    And section "11450-4" should have empty reason "nilknown"
    And section "47519-4" should have empty reason "notasked"
    And section "46264-8" should have empty reason "unavailable"
    And section "11369-6" should have empty reason "unavailable"
    And section "42348-3" should have empty reason "notasked"

  @ps-empty
  Scenario: A section with neither entries nor an empty reason is rejected
    Given the HIQA example "Composition-hiqa-ps-composition-tomas-empty.json"
    Then invariant "ie-ps-1" should pass
    When I "remove the allergies section empty reason"
    Then invariant "ie-ps-1" should fail

  @ps-provenance
  Scenario: An attestation must say who attested and when
    Given the HIQA example "Composition-hiqa-ps-composition-niamh.json"
    Then invariant "ie-ps-attester-1" should pass
    When I "remove the attestation time"
    Then invariant "ie-ps-attester-1" should fail

  @ps-demographics
  Scenario: The Patient Summary patient may carry the PS-only demographics
    Then example "Patient-hiqa-ps-patient-niamh.json" should carry extension "ie-core-ethnicity"
    And example "Patient-hiqa-ps-patient-niamh.json" should carry extension "patient-nationality"
