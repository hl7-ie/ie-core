# ADR-002: Context-specific demographics and data minimisation

- **Status:** Accepted (Checkpoint 1, 2026-09-24). **BREAKING.**
- **Date:** 2026-09-24
- **Related:** baseline C-01, H-01, H-02, H-04, L-01; hazards HZ-01, HZ-02, HZ-04, HZ-06; ADR-006
  (identifiers)

## Context

`IECorePatient` (parent EU Base `patient-eu-core`) is the single Patient profile for every use case.
It marks `ethnicity`, `mothersMaidenName`, `personalPronouns`, `genderIdentity` and
`interpreterRequired` as MustSupport. It is the only allowed `subject` of every MedicationRequest and
MedicationDispense.

The two HIQA drafts disagree on purpose:

| Data | HIQA EP (prescription/dispense) | HIQA PS (patient summary) |
|---|---|---|
| Ethnicity (GDPR Art. 9) | **absent** | 1.4.10 Required 0..* coded |
| Mother's maiden / former surnames | **absent** | 1.4.6 Required 0..* ("former surnames") |
| Nationality | **absent** | 1.4.7 Required 0..* coded |
| Place of birth | **absent** | 1.4.3 Required 0..1 (county or city) |
| Country of affiliation | **absent** | 1.4.8 Required 0..1 |
| Marital status, religion, pronouns | **absent** | **absent** |
| Sex (assigned at birth) | 1.4.3 **Mandatory** 1..1 | 1.4.4 **Mandatory** 1..1 |
| Gender cluster (coded + other gender identity free text) | 1.4.4 Required 0..1 | 1.4.5 Required 0..1 |
| Date of birth | 1.4.1 Mandatory (a legal requirement cross-border) | 1.4.1 Mandatory (unknown = 1900-01-01) |
| Age if under 12 (value + unit) | 1.4.2 Required; a legal requirement when under 12 (P only) | — (1.4.2 is *estimated* age, Optional) |
| IHI | 1.3.1 Required, "18 or 10-digit" | 1.3.1 Required, "18 or 10-digit" |
| PPS Number | 1.3.2 Required | 1.3.2 Required |

Under MustSupport, a sender that holds ethnicity must send it in every prescription. That is
special-category data flowing to every pharmacy, and cross-border, with no purpose for it in the
prescription. It breaches GDPR Art. 5(1)(c) and Art. 9, and it contradicts the HIQA EP dataset.

## Requirements

1. EP and ED exchanges must not carry data outside the HIQA EP dataset; it must be **prohibited**,
   not just "not required".
2. The PS must be able to carry the PS demographics HIQA lists as Required.
3. Sex assigned at birth must be separate from administrative gender and from gender identity.
4. Valid 10-digit IHIs must not be rejected.
5. Minimal churn for existing implementers of `IECorePatient` in other use cases (encounters, labs).

## Options

| | A. Remove ethnicity and the rest from the IG entirely | **B. Permissive base + use-case profiles** | C. Status quo |
|---|---|---|---|
| Summary | Delete the extensions, CodeSystem and ValueSet | `IECorePatient` becomes permissive (no MS on special-category data). `IECorePatientEPrescription` sets them to `0..0`. `IECorePatientSummaryPatient` makes them MS per PS 1.4 | Keep MS on the one base profile |
| Advantages | Simplest; no special-category data anywhere | Each use case gets exactly its HIQA dataset; prohibition is enforced by validation; the PS can still meet HIQA 1.4.10 | No work |
| Disadvantages | **Cannot meet HIQA PS 1.4.10 (Required)**; loses health-disparity data the PS standard asks for | More profiles (+2); implementers must choose the right one | Contradicts HIQA EP; unlawful by default |
| Risks | Non-conformance with the PS standard | Wrong profile chosen → caught by the `subject only Reference(...)` constraints and Bundle entry profiles | Regulatory and reputational |
| Cost | Low | Medium (Phase 4) | none |
| Operational impact | Systems holding ethnicity cannot share it even where lawful | Senders filter per use case, which most EHRs already do per message type | Senders over-share |
| GDPR / EHDS impact | Minimal data; but under-delivers on the EHDS PS priority category | **Art. 5(1)(c) enforced per purpose**; Art. 9 data only in the PS, and only when recorded (MS = "if known") | Art. 5(1)(c) and Art. 9 exposure |

### Sex and gender sub-decision

| | `Patient.gender` only (status quo) | `individual-recordedSexOrGender` with type LOINC 76689-9 "Sex assigned at birth" | `patient-sexParameterForClinicalUse` |
|---|---|---|---|
| Fit to HIQA "Sex (assigned at birth)" | ✗ administrative gender | ✓ it is a *recorded* sex with a typed meaning | ✗ it is a clinical-context parameter, not a record of sex at birth |
| Maturity | core | extension, **active** (uv.extensions.r4 5.1.0) | extension, **draft** |
| Codes | administrative-gender | value: example binding administrative-gender; type: LOINC 76689-9 ✔ verified on tx.fhir.org (LOINC 2.82) | — |
| Recommendation | keep `Patient.gender` 1..1 (inherited) as administrative gender | **Use for HIQA Sex; Mandatory in both use-case profiles** | Not used. Mentioned in guidance as the clinical-system concept |

**Gender cluster** (EP 1.4.4 / PS 1.4.5): `individual-genderIdentity` (active), MS. Coded value
with `valueCodeableConcept.text` for "other gender identity" (EP 1.4.4.2 / PS 1.4.5.2). HIQA
publishes no value set. The existing `ie-core-gender-identity` ValueSet is kept and flagged for
Phase 7 terminology verification. **Pronouns** (in neither dataset): `0..0` in both use-case profiles,
allowed but not MS in the base.

### IHI

`ie-pat-1` becomes `value.matches('^([0-9]{18}|[0-9]{10})$')`, severity error, with
`^comment` citing EP/PS 1.3.1. OI-002 stays open (no check-digit rule until HSE publishes one).

### PPSN

A `PPSN` identifier slice on the **use-case** profiles, `0..1`, **no MustSupport**, format from
HIQA ("seven numbers followed by either one or two letters", EP 1.3.2) as a **warning**-severity
invariant. Labelled "Requires Clarification": the legal basis for using the PPSN as a health
identifier is open (OI-008). No MS means a sender is never *obliged* to send it.

### Age under 12 (EP 1.4.2)

On `IECoreMedicationRequestEPrescription`, a new extension `IECorePatientAgeAtPrescribing`
(`valueAge`, UCUM `a`, `mo` or `d`) plus invariant `ie-rx-age-1`, severity error:
*if the subject's birthDate is less than 12 years before `authoredOn`, the age extension SHALL be
present*. It is placed on the prescription because HIQA ties it to the prescription record ("P"
only) and age is evaluated at the time of prescribing. FHIRPath cannot resolve the subject from
inside a standalone MedicationRequest, so the invariant is evaluated at **Bundle** level
(`IECoreBundleEPrescription`, ADR-003), where the Patient entry is available.

## Decision (recommended)

**Option B**, with the sub-decisions above:

| Profile | Parent | Ethnicity | Mother's maiden / former surnames | Nationality | Birth place | Country of affiliation | Marital, religion | Pronouns | Sex at birth | Gender identity | PPSN |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `IECorePatient` (base, all other use cases) | `patient-eu-core` | 0..* allowed, **no MS** | 0..1 allowed, no MS | allowed | allowed | allowed | allowed | allowed, no MS | 0..1 MS | 0..* MS | not sliced |
| `IECorePatientEPrescription` (new) | `IECorePatient` | **0..0** | **0..0** | **0..0** | **0..0** | **0..0** | **0..0** | **0..0** | **1..1 MS** | 0..1 MS | 0..1, no MS |
| `IECorePatientSummaryPatient` (new) | `IECorePatient` + `imposeProfile` EU EPS patient (ADR-004) | 0..* **MS** | 0..* MS (`patient-mothersMaidenName` repeated for former surnames; see note) | 0..* MS | 0..1 MS | 0..1 MS (placeholder extension) | **0..0** | **0..0** | **1..1 MS** | 0..1 MS | 0..1, no MS |

Wiring:
- `IECoreMedicationRequestEPrescription.subject`, `IECoreMedicationDispenseEDispensation.subject` →
  `Reference(IECorePatientEPrescription)`.
- The ePrescription Bundle (ADR-003) Patient entry → `IECorePatientEPrescription`.
- `IECoreCompositionPatientSummary.subject` and the PS Bundle Patient entry →
  `IECorePatientSummaryPatient`.

Notes:
- `patient-mothersMaidenName` is `0..1` in the core extension. PS 1.4.6 asks for *all former
  surnames* (0..*). Recommendation: an IE extension `IECoreMothersFormerSurname` (string, 0..*)
  in the PS profile, **Requires Clarification** in the feedback (does HIQA mean the mother's
  birth surname only?).
- **Country of affiliation** has no HL7 extension. Recommendation: an IE extension
  `IECoreCountryOfAffiliation` (CodeableConcept, ISO 3166). The name comes from the HIQA text; the
  definition cites PS 1.4.8.
- Ethnicity changes from `valueCode` 0..1 to `valueCodeableConcept` 0..*. The binding becomes
  **extensible** and stays scoped to the PS (CSO verification in Phase 7, OI-005).

## Consequences

- **BREAKING:** existing ePrescription instances with ethnicity, maiden name or pronouns become
  **invalid**. (None exist in the repo's examples, payloads or tests; baseline §3.)
- **BREAKING:** `IECorePatient` loses MS on ethnicity, maiden name, pronouns and interpreter
  required. Receivers of other use cases are no longer obliged to process them.
- Identity matching in ePrescription without the mother's maiden name → HZ-06 (mitigated: IHI +
  DOB + forename + surname + address, all Mandatory in EP except the IHI, which is Required).
- Sex at birth is now separate, which closes HZ-01. Display guidance on disclosure risk goes into
  `security.md` and `crossborder-patient-profile.md`.
- `changes.md` entry under **BREAKING** with a link to this ADR.
