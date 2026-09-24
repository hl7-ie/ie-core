@invariants
Feature: Profile Invariant Validation
  As a data quality specialist
  I want to verify that IE Core invariants correctly reject invalid data
  So that data integrity is maintained

  # IHI: HIQA EP/PS 1.3.1 "A unique 18 or 10-digit number" (invariant ie-pat-1, read from the IG)
  @ihi-valid @hiqa
  Scenario Outline: Valid IHI numbers are accepted (18 or 10 digits)
    Given a Patient identifier with system "https://hl7-ie.github.io/ie-core/fhir/ie/core/sid/ihi"
    When the identifier value is "<ihi>"
    Then the value should match the IHI pattern

    Examples:
      | ihi                |
      | 210000000012345678 |
      | 100000000000000001 |
      | 1234567890         |

  @ihi-invalid @hiqa
  Scenario Outline: Invalid IHI numbers are rejected
    Given a Patient identifier with system "https://hl7-ie.github.io/ie-core/fhir/ie/core/sid/ihi"
    When the identifier value is "<ihi>"
    Then the value should not match the IHI pattern

    Examples:
      | ihi                 |
      | 12345               |
      | 12345678901         |
      | 21000000001234567A  |
      | ABCDEFGHIJKLMNOPQR  |
      | 2100000000123456789 |

  # PPSN: HIQA EP/PS 1.3.2 "seven numbers followed by either one or two letters" (ie-pat-ppsn-1, warning)
  # The unsourced GMS/DPS/LTI/HAA format rules were removed (ADR-006).
  @ppsn-valid @hiqa
  Scenario Outline: Valid PPSN formats are accepted
    Given a Patient identifier with system "https://hl7-ie.github.io/ie-core/fhir/ie/core/sid/pps"
    When the identifier value is "<ppsn>"
    Then the value should match the PPSN pattern

    Examples:
      | ppsn      |
      | 1234567T  |
      | 1234567TW |

  @ppsn-invalid @hiqa
  Scenario Outline: Invalid PPSN formats are flagged
    Given a Patient identifier with system "https://hl7-ie.github.io/ie-core/fhir/ie/core/sid/pps"
    When the identifier value is "<ppsn>"
    Then the value should not match the PPSN pattern

    Examples:
      | ppsn       |
      | 123456T    |
      | 1234567    |
      | 1234567TWX |

  @eircode
  Scenario Outline: Valid Eircode format
    When the postal code value is "<eircode>"
    Then the value should match the Eircode pattern

    Examples:
      | eircode  |
      | D02 XY12 |
      | T12 AB34 |
      | A65 F4E2 |
