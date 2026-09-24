# ADR-007: Terminology integrity remediation

- **Status:** Accepted (Phase 7, 2026-09-24). Required by the brief's guardrail: *"never invent codes;
  validate every explicit code on tx.fhir.org"*. Recorded as an ADR because it changes ValueSet content.
  **BREAKING** for any implementer relying on the removed codes.
- **Related:** clinical-safety hazard HZ-09; OI-005 (resolved), OI-018; baseline concern that content
  came from an untrusted hl7.ie source (ADR-006)

## Context

Phase 7 looked up every explicit external code in the FSH sources on tx.fhir.org
(`scripts/terminology/verify_codes.py`; SNOMED CT International, LOINC, UCUM, WHO ATC and HL7
Terminology). Of the codes checked at first:

| Problem | Codes | Examples |
|---|---|---|
| **Wrong meaning**: the IG's label contradicts the official meaning | 37 | "Omeprazole" coded as **Imipramine** (372718005) in an example medication and two JSON payloads; "Patient deceased during stay" = *Patient discharged alive*; "Heavy drinker" = *Light drinker*; "Private health insurance" = *Legally married*; "Clinical psychologist" = *Clinical nurse specialist* |
| Not in the terminology | 13 | invented SNOMED CT "Medical card holder", "GP visit card holder", "Drug payment scheme", "Long term illness scheme"; US-extension-only smoking and pregnancy-intent codes |
| Inactive | 6 | 228274009 (also mislabelled), 397709008, 264358009, … |
| Wrong code system | 2 | `condition-category#health-concern` (a US Core code); `v3-ActCode#pay` (belongs to `coverage-selfpay`) |
| Cosmetic label differences | 21 | "Diabetes mellitus type 2" vs *Type 2 diabetes mellitus* |

The audit also found:
- **6 bindings to ValueSets that do not exist** (3 id typos, 3 never defined), so those elements were
  effectively unbound.
- The medication ValueSet used the SNOMED CT **edition URI** as a code system (no code could ever match).
- The examples used `NMPC-…` codes from no defined code system.
- The ethnicity CodeSystem did not match the current CSO classification.

## Options

| | A. Leave as is, fix later | **B. Remediate by rule, verify everything, never guess** | C. Delete every non-HIQA ValueSet |
|---|---|---|---|
| Patient safety | Wrong-meaning codes stay in a published IG | Removed or corrected | Removed, but so is valid content |
| Effort | none | Medium (scripted, reviewed per code) | Low |
| Breaking | no | Yes, for the removed codes | Yes, broadly |

## Decision

**B.** Every decision is listed in `docs/hiqa-2026/terminology-remediation.csv`:
- **FIX:** keep the code and use the official display when its real meaning still fits the ValueSet or profile.
- **REMOVE:** delete it when the meaning does not fit, or the code is not found or inactive.
- **REPLACE:** only with a code found and checked on tx.fhir.org (Omeprazole → 317291008 product /
  387137007 substance; `pay` → `coverage-selfpay`; `health-concern` → the IE Core condition-category CodeSystem).
- Dangling bindings: typo'd ids fixed. The three undefined ValueSets now bind (preferred) to the ValueSets
  FHIR R4 core uses for the same elements.
- SNOMED CT Irish edition: `system = http://snomed.info/sct`, `version = http://snomed.info/sct/1601000220105`.
- `IECoreNMPCPlaceholder`: an explicitly labelled placeholder CodeSystem for the illustrative example
  codes (not the NMPC; OI-018).
- Ethnicity: the CodeSystem now carries the **CSO Data Standard for Ethnicity v1.0 (7 Feb 2025)**
  codes and names (OI-005 resolved).
- The verifier runs in CI (Phase 9), so a wrong or retired code fails the build.

## Consequences

- Result: 277 external codes verified, 0 not found or inactive; 0 dangling bindings.
- Some ValueSets outside the HIQA scope are now thin (e.g. pregnancy intent has only *Unknown*).
  They are flagged for a terminology review rather than padded with guessed codes.
