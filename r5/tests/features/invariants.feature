@invariants @r5
Feature: Profile Invariant Validation (R5)
  As a data quality specialist
  I want to verify that IE Core R5 invariants use the same identifier patterns as R4
  So that data integrity is maintained across FHIR versions

  @ihi-valid
  Scenario Outline: Valid IHI numbers are accepted
    Given a Patient identifier with system "https://hl7-ie.github.io/ie-core/fhir/ie/core/sid/ihi"
    When the identifier value is "<ihi>"
    Then the value should match the IHI pattern

    Examples:
      | ihi                |
      | 210000000012345678 |
      | 100000000000000001 |
      | 999999999999999999 |
      | 1234567890         |

  @ihi-invalid
  Scenario Outline: Invalid IHI numbers are rejected
    Given a Patient identifier with system "https://hl7-ie.github.io/ie-core/fhir/ie/core/sid/ihi"
    When the identifier value is "<ihi>"
    Then the value should not match the IHI pattern

    Examples:
      | ihi               |
      | 12345             |
      | 12345678901        |
      | 21000000001234567A |
      | ABCDEFGHIJKLMNOPQR |
      |                    |

  @eircode
  Scenario Outline: Valid Eircode format
    When the postal code value is "<eircode>"
    Then the value should match the Eircode pattern

    Examples:
      | eircode  |
      | D02 XY12 |
      | T12 AB34 |
      | A65 F4E2 |
