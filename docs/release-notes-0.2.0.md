# IE Core 0.2.0 "Nostalgic IE": release notes (draft, 24 September 2026)

**Status:** draft. Merged to `main` (PR #26); not tagged, and not yet released on Simplifier.net. A proof of concept by Nithin Mohan; not affiliated with, or
endorsed by, HIQA, the HSE, HL7 Ireland or the Department of Health. Not for clinical use.

## What this release is

**Package:** `nostalgic-ie.fhir.core` (ADR-008; the `hl7.*` prefix is reserved for HL7). **Code name:** Nostalgic IE.

IE Core 0.2.0 realigns the ePrescription, eDispensation and Patient Summary profiles with two HIQA **consultation
drafts** (September 2026). It builds on HL7 Europe MPD 1.0.0 and the HL7 Europe Patient Summary (EPS 1.0.0-ballot).
Every HIQA data element is traced, and no code, identifier system or requirement was invented. Where HIQA does not
settle a point, the IG uses a clearly named placeholder listed in `docs/hiqa-2026/open-issues.md`.

## Highlights

- **Traceability.** HIQA logical models for both standards and a 563-row matrix (548 HIQA elements, plus prohibited
  data). HIQA Mandatory elements aligned: ePrescription 40 of 54, Patient Summary 46 of 68. Every remaining
  Partial and Gap item has a stated reason.
- **Data minimisation.** A separate ePrescription patient profile carries only the HIQA EP dataset: ethnicity,
  mother's maiden name, nationality, religion, marital status and similar data are prohibited, and a guard script
  enforces this in CI. The Patient Summary patient carries the PS dataset.
- **Prescribing safety rules** as FHIR invariants, each with a failing-case test:
  - an allergy statement on every prescription, belonging to the right patient;
  - the age of a child under 12 (or when the date of birth is partial);
  - the controlled-drug rules: words and figures, validity, instalments and interval;
  - a reason for 'Do Not Substitute' and for every non-dispensation;
  - the prescriber's telephone number, plus secure email and signature for cross-border prescriptions.
- **Patient Summary** on HL7 Europe EPS. Every section HIQA gives an empty reason to must carry entries or the reason.
- **Terminology integrity.** 309 codes verified on tx.fhir.org, 0 invalid. 37 wrong-meaning codes were removed; the
  worst was Omeprazole coded as Imipramine. SNOMED CT Irish Edition named correctly (`version`, not `system`).
- **Eight synthetic scenario examples**, and the 22 older payload Bundles cleaned and made to validate.
- **CI hardening:** pinned actions, tools and checksums; least privilege; new quality gates; Dependabot.

## Breaking changes

| Change | Why | ADR |
|---|---|---|
| ePrescription/eDispensation subjects must be `IECorePatientEPrescription`; sensitive demographics prohibited | HIQA EP dataset; GDPR data minimisation | ADR-002 |
| `IECorePatient` drops MustSupport on ethnicity, maiden name, pronouns, interpreter | not in the HIQA datasets for most use cases | ADR-002 |
| MedicationRequest, MedicationDispense and Medication derive from HL7 Europe MPD; dispenses need `recorded` and a Medication reference | European alignment; HIQA EP 6.2 | ADR-003 |
| Prescription items must reference a Medication (no inline CodeableConcept) | HIQA EP 4.7.2; controlled-drug rules | ADR-003 addendum |
| Cross-border is signalled by the `IECoreBundleEPrescriptionCrossBorder` profile; the invented `xt-ehr` tag is gone | no source for the tag | ADR-003 |
| Patient Summary Composition and Bundle derive from HL7 Europe EPS | European alignment | ADR-004 |
| Unsourced identifier profiles and aliases removed (HPI, CRN, IMN, GMS/DPS/LTI/HAA formats); HIQA registration identifiers added | no authoritative source | ADR-006 |
| Wrong-meaning, non-existent and inactive codes removed; ethnicity uses CSO v1.0 codes | terminology integrity | ADR-007 |
| `AllergyIntolerance.clinicalStatus` 0..1 with `ie-allergy-1` | lets an allergy entered in error be retracted | review R-09 |
| R5 track frozen; its GMS slice removed | not aligned with HIQA | ADR-005 |
| Sample payload identifiers, fullUrls and CDA OIDs changed | invented URIs and OIDs removed | ADR-006/007 |
| Package id `nostalgic-ie.fhir.core` (was `hl7.fhir.ie.core`, never published) | `hl7.*` is reserved for HL7 | ADR-008 |
| Discharge-details section coded LOINC 8650-4 (was 8648-8, the hospital-course code) | wrong code; HL7 Europe HDR uses 8650-4 | ADR-007 |

## Quality at release

| Check | `main` | 0.2.0 |
|---|---|---|
| SUSHI | 0 errors | 0 errors, 0 warnings |
| FHIR Validator, examples (codes on tx.fhir.org) | not run | 168 / 168 pass |
| Validator QA, all resources | 48 errors | 33 errors (28 IG-parameter artefact, 5 Irish Edition ValueSets tx.fhir.org cannot check) |
| BDD scenarios | 120 | 176 pass |
| Quality checks | — | 544 / 544 |
| IG Publisher QA (CI) | not run | first CI run: 23 errors, 2,359 broken links; the Simplifier iteration fixes the causes of the other 18 errors and the broken links (to be confirmed by the next CI run); the 5 Irish Edition ValueSet errors remain (OI-022) |

## Known limitations

- The HIQA drafts publish no coded values and no identifier system URIs, so placeholders remain: the MDA schedule,
  supply legal status, NMPC product codes, PCRS scheme types and the `sid/*` identifier systems (OI-003, OI-007,
  OI-018).
- The SNOMED CT Irish Edition and NMPC cannot be checked on public terminology servers (OI-022).
- Controlled-drug rules use conservative readings where HIQA is open; the first-instalment-within-14-days check
  belongs at dispensing (OI-027, decision recorded).
- Some Mandatory elements are only partly enforced, for example the facility address (OI-013) and the prescriber
  registration number (EP 2.6).
- The 22 legacy payload Bundles validate but are plain collections without an allergy statement or signature; the
  eight HIQA scenario Bundles are the conformant references.

## Upgrading from 0.1.x

1. ePrescription senders: claim `ie-core-patient-eprescription` and remove prohibited demographics; send
   `Patient.extension:sexAssignedAtBirth`.
2. Send prescriptions as an `ie-core-bundle-eprescription` with the allergy statement List, and reference a
   `Medication` from every item.
3. Dispensers: add the MPD `recorded` extension, reference a `Medication`, and give a reason for every
   non-dispensation.
4. Replace any identifier systems or codes removed by ADR-006/ADR-007 (see `docs/hiqa-2026/terminology-remediation.csv`).
