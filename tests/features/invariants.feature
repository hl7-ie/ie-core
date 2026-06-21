@invariants
Feature: Profile Invariant Validation
  As a data quality specialist
  I want to verify that IE Core invariants correctly reject invalid data
  So that data integrity is maintained

  @ihi-valid
  Scenario Outline: Valid IHI numbers are accepted
    Given a Patient identifier with system "https://hl7-ie.github.io/fhir/ie/core/sid/ihi"
    When the identifier value is "<ihi>"
    Then the value should match the IHI pattern

    Examples:
      | ihi                |
      | 210000000012345678 |
      | 100000000000000001 |
      | 999999999999999999 |

  @ihi-invalid
  Scenario Outline: Invalid IHI numbers are rejected
    Given a Patient identifier with system "https://hl7-ie.github.io/fhir/ie/core/sid/ihi"
    When the identifier value is "<ihi>"
    Then the value should not match the IHI pattern

    Examples:
      | ihi               |
      | 12345             |
      | 21000000001234567A |
      | ABCDEFGHIJKLMNOPQR |
      |                    |

  @gms-valid
  Scenario Outline: Valid GMS numbers are accepted
    Given a Patient identifier with system "https://hl7-ie.github.io/fhir/ie/core/sid/gms"
    When the identifier value is "<gms>"
    Then the value should match the GMS pattern

    Examples:
      | gms      |
      | 1234567A |
      | 9876543Z |
      | 0000001B |

  @gms-invalid
  Scenario Outline: Invalid GMS numbers are rejected
    Given a Patient identifier with system "https://hl7-ie.github.io/fhir/ie/core/sid/gms"
    When the identifier value is "<gms>"
    Then the value should not match the GMS pattern

    Examples:
      | gms       |
      | 123456A   |
      | 12345678  |
      | 1234567AB |
      | ABCDEFGH  |

  @eircode
  Scenario Outline: Valid Eircode format
    When the postal code value is "<eircode>"
    Then the value should match the Eircode pattern

    Examples:
      | eircode  |
      | D02 XY12 |
      | T12 AB34 |
      | A65 F4E2 |
