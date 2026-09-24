# ADR-004: Patient Summary parent profile

- **Status:** Accepted (Checkpoint 1, 2026-09-24). **BREAKING** (section slice names change).
- **Date:** 2026-09-24
- **Related:** baseline M-02; ADR-002 (`IECorePatientSummaryPatient`); HIQA PS sections 1–19

## Context

`IECoreCompositionPatientSummary` derives from base `Composition`, with its own section slice names
(`medications`, `alerts`, …). There is no PS Bundle profile and no PS example. HIQA PS asks for 15
clinical sections, each with narrative and an empty reason, plus document- and entry-level
provenance (Section 19).

### What exists on packages.fhir.org (checked 2026-09-24, not assumed)

| Package | Status | Composition base | Notes |
|---|---|---|---|
| `hl7.fhir.uv.ips` 2.0.0 (2.0.1 available) | STU 2 (published) | Composition | 16 section slices; no travel history |
| `hl7.fhir.eu.eps` **1.0.0-ballot** (R4, 2026-06-06) | ballot / draft | EU Base `composition-eu-core` | **`imposeProfile` → IPS Composition, Bundle and Patient**, so conformance to EPS implies IPS. Adds `sectionTravelHx` (LOINC 10182-4, `travelObservation`), `sectionPatientHx` (11329-0) and `gestationalAge` in pregnancy. `sectionProceduresHx` and `sectionMedicalDevices` are **1..1** (IPS: 0..1). Depends on IPS 2.0.0, EU Base 2.0.0, `ihe.pharm.mpd.r4` 1.0.0-comment-2 and `hl7.fhir.uv.xver-r5.r4` 0.1.0 |
| An "HL7 Europe PS" under other ids (`hl7.fhir.eu.ps`, `…patient-summary`) | **not found** | — | — |

### SUSHI trial build (scratch copy)

| Trial | SUSHI errors | Nature |
|---|---|---|
| Composition → IPS `Composition-uv-ips` | 1 | `subject only Reference(IECorePatient)` must reference an IPS-derived Patient |
| Composition → EPS `composition-eu-eps` (+ `hl7.fhir.eu.eps` dependency) | 1 | same, with `patient-eu-eps` |

Not visible to SUSHI, but certain: our slices (`medications`, `alerts`, …) **duplicate** the
parent's slices (`sectionMedications`, …) with the same `code` pattern. The validator would report
overlapping slices, so the slices must be **renamed to the parent's names**.

### HIQA fit (section by section)

| HIQA PS | IPS 2.0 | EU EPS ballot | Comment |
|---|---|---|---|
| 4 Alerts | `sectionAlerts` (Flag) | `sectionAlert` (Flag) | slice name differs between IPS and EPS |
| 5 Allergies | ✓ 1..1 | ✓ 1..1 | |
| 6 Medication | ✓ 1..1 | ✓ 1..1 | |
| 7 Health conditions | ✓ 1..1 | ✓ 1..1 | |
| 8 Observation results | `sectionResults` | ✓ (EU `medicalTestResult`) | EU Lab alignment only in EPS |
| 9 Procedures | 0..1 | **1..1** | HIQA 9.2 empty reason Required → 1..1 fits |
| 10 Devices / implants | DeviceUseStatement | DeviceUseStatement, **1..1** | closes PS 10.3.1, 10.3.3.3 and 10.4 gaps (period, body site, reason) |
| 11 Patient-provided data | `sectionPatientStory` | ✓ | |
| 12 Social context | ✓ | ✓ | |
| 13 Advance healthcare directive | Consent or DocumentReference | same | see below |
| 14 Travel history | **✗** | **✓ `sectionTravelHx`** | HIQA 14.2.3 country visited is Mandatory in the record entry |
| 15 Pregnancy | status + outcome | + **gestationalAge** | HIQA 15.2.4 gestational age is Mandatory in the record entry |
| 16 Immunisation | ✓ | ✓ | |
| 17 Functional status | ✓ | ✓ | |
| 18 Care plan | ✓ | ✓ | |

## Options

| | A. IPS 2.0.x | **B. HL7 Europe EPS 1.0.0-ballot** | C. Base Composition (status quo) |
|---|---|---|---|
| Advantages | Published STU; global | Covers every HIQA clinical section incl. travel and gestational age; EHDS/MyHealth@EU direction; still IPS-conformant via `imposeProfile`; same EU Base 2.0.0 root as `IECorePatient` | Freedom |
| Disadvantages | No travel history: HIQA 14 would need a section code the parent does not define (against the brief's "LOINC codes from IPS/parent only") | **Ballot**: may change before STU; heavier dependency tree | No interoperability guarantee; everything hand-built |
| Risks | Divergence from the EU PS | Breaking changes in EPS STU → re-test (pin 1.0.0-ballot; fallback to A) | NCPeH transformation burden |
| Cost | Medium | Medium | High (in the long run) |
| Operational impact | Transform to EU format at the NCPeH | Minimal transformation cross-border | High |
| GDPR / EHDS impact | Neutral | **Best fit** for the EHDS PS priority category (March 2029) | Weak |

## Decision (recommended)

**Option B (EU EPS 1.0.0-ballot), with Option A as the documented fallback** if EPS has not reached
STU by the time HIQA finalises its standard.

- Add dependency `hl7.fhir.eu.eps: 1.0.0-ballot`.
- `IECoreCompositionPatientSummary` parent `composition-eu-eps`. Section slices **renamed to the
  EPS names**. Only IE constraints are added: MS where HIQA says Required, `emptyReason` MS on
  every section HIQA gives an empty reason to, and `^comment` with the PS element IDs.
- `IECoreBundlePatientSummary` (new) parent `bundle-eu-eps`. `identifier` 1..1 carries PS 19.1.2
  (R4 `Composition.identifier` is 0..1).
- `IECorePatientSummaryPatient` (ADR-002) parent **`patient-eu-eps`**, with
  `structuredefinition-imposeProfile` → `IECorePatient`. This mirrors the EPS pattern and keeps the
  IE identifier and address rules.
- Section codes come **only** from the parent. No IE-invented section codes.
- **Advance healthcare directive (PS 13):** entries are `IECoreADIDocumentReference`
  (DocumentReference). Consent is not used. Justification: under the Assisted Decision-Making
  (Capacity) Act 2015, an AHD is a *written document* (with the DHR appointment where there is
  one). HIQA 13.3.2 makes the attachment Mandatory and 13.3.1 gives only a category.
  `Consent.provision` would imply a structured, machine-actionable decision that HIQA does not
  define, and misstructuring a legally binding refusal is a patient-safety risk. The attachment
  is the authoritative source.
- **Nominated contact person (PS 3):** `Patient.contact` (MS in the PS patient), not RelatedPerson.
  It is a property of the patient record for emergencies, and it keeps the data in the PS
  Patient's minimisation scope.
- **Health insurance (PS 1.3.4):** `IECoreCoverage` entries in the PS Bundle (`beneficiary` = PS
  patient). The EHIC is an "other identifier" example (PS 1.3.3.1).
- **Provenance (PS 19.2):** entry author, date and source use each resource's native elements
  (`recorder`, `recordedDate`, `asserter`/`informationSource`), made MS where HIQA says Required.
  `Provenance` is optional for richer history.

## Consequences

- **BREAKING:** section slice names change (`medications` → `sectionMedications`, …); PS subject
  profile changes. No PS instances exist in the repo.
- New ballot dependency. The IG release notes must say so, and the CI must pin it.
- The empty-section example (Phase 8) demonstrates `emptyReason` in every section.
