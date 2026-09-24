# Checkpoint 1: element-mapping plan and file-change list

This is the **target** state after Phases 4–7, assuming ADR-001 to ADR-006 are accepted. The current
state, element by element, is in `docs/hiqa-2026/traceability-matrix.csv` (Phase 2). Each phase
updates `docs/hiqa-2026/mapping/*.csv` element by element as it lands, and the generator plus the
snapshot cross-check keep the matrix honest.

Legend: **M** Mandatory → `min ≥ 1` + MS · **R** Required → MS · **O** Optional → allowed · **∅**
not in dataset → `0..0`.
Profile short names: `PatEP` = IECorePatientEPrescription, `PatPS` = IECorePatientSummaryPatient,
`MR` = IECoreMedicationRequestEPrescription, `MD` = IECoreMedicationDispenseEDispensation,
`Med` = IECoreMedicationEPrescription, `Prac`/`Role`/`Org`/`Loc` = the IE Core
Practitioner/PractitionerRole/Organization/Location, `BndEP`/`BndXB` = the ePrescription Bundle and
its cross-border variant, `Comp`/`BndPS` = the PS Composition and Bundle.

## A. ePrescription / eDispensation (HIQA EP)

| HIQA EP | Target | Key constraints (each carries the EP ID in `^comment`) | Phase |
|---|---|---|---|
| 1.1.1–1.1.4 Name | `PatEP.name` | name 1..*; `given` **1..*** (1.1.2 M); `family` **1..1** (1.1.3 M); prefix/suffix O | 4 |
| 1.2.1–1.2.7 Address | `PatEP.address` | address **1..*** MS; `line` 1..* (1.2.2 M); `state` 1..1 (1.2.4 M, county binding); `use` 1..1 MS (1.2.6 M: residence or temporary; homelessness → Requires Clarification, no HL7 code); `postalCode`, `city`, `country` R; `type` O | 4 |
| 1.3.1 IHI | `PatEP.identifier:IHI` | 0..1 MS; `^([0-9]{18}\|[0-9]{10})$` | 4 |
| 1.3.2 PPSN | `PatEP.identifier:PPSN` | 0..1 **no MS**; warning format; Requires Clarification | 4 |
| 1.3.3.x Other identifiers | `PatEP.identifier` | `type`, `value`, `period`, `assigner` MS; PCRS scheme types (ADR-006) | 4 |
| 1.4.1 DOB | `PatEP.birthDate` | 1..1 MS (inherited) | 4 |
| 1.4.2 Age < 12 | `MR.extension:ageAtPrescribing` + `BndEP` invariant `ie-rx-age-1` | Age (UCUM a, mo, d) required when under 12 at `authoredOn` | 4 |
| 1.4.3 Sex | `PatEP.extension:sexAssignedAtBirth` (`individual-recordedSexOrGender`, type LOINC 76689-9) | **1..1 MS** | 4 |
| 1.4.4 Gender cluster | `PatEP.extension:genderIdentity` | 0..1 MS; `.text` for other gender identity (1.4.4.2) | 4 |
| ∅ ethnicity, mother's maiden name, nationality, birth place, country of affiliation, marital status, religion, pronouns | `PatEP` | **0..0** each | 4 |
| 1.5.1–1.5.3 Communication | `PatEP.telecom` | MS; mobile/email via `system` + `use` | 4 |
| 1.6.1 Reason for not recording allergies | `List.emptyReason` in `IECoreListAllergiesAtPrescribing` | `entry` xor `emptyReason`; `list-empty-reason` | 5 |
| 1.6.2.x Allergies + provenance | `IECoreAllergyIntolerance` | `code` 1..1; `reaction.substance` MS; `recorder`, `recordedDate` MS | 5 |
| 1.6.3 / 1.6.4 Weight / height | `IECoreBodyWeight` / `IECoreBodyHeight` via `MR.supportingInformation` | O; performer MS within the entry | 5 |
| 1.6.5 Additional notes | `MR.note` | O | 5 |
| 2.1–2.4 Name | `Prac.name` | `given` 1..* and `family` 1..1 in the EP context | 5 |
| 2.5 Role / speciality | `Role.code`, `Role.specialty` | R: MS | 5 |
| 2.6 Registration | `Prac.identifier:IMC\|PSI\|NMBI\|DentalCouncil` | EP invariant: at least one registration identifier (**M**) | 5 |
| 2.7–2.9 Facility | `Org.name`, `Org.identifier:PSIRPB`, `Org.address` | address 1..1 with `postalCode`, `line`, `state`, `country` 1..1 (2.9.x M) | 5 |
| 2.10 Communication | `Role.telecom` | **1..*** with a phone (2.10.1 M); email R; cross-border: phone **and** email | 5 |
| 2.11 GLN | `Loc.identifier:GLN` | system `http://www.gs1.org/gln`; 13 digits + GS1 check digit | 5 |
| 2.12 GMS Panel ID | `Org.identifier:GMSPanel` | O | 5 |
| 2.13 Signature | `IECoreProvenanceEPrescriptionSignature` | required in `BndXB` | 5 |
| 3.1 Prescription identifier | `MR.identifier` 1..* + `MR.groupIdentifier` | `groupIdentifier` required when there is more than one item (`BndEP` invariant) | 5 |
| 3.2 Date/time of issue | `MR.authoredOn` | 1..1 (also MPD) | 5 |
| 3.3 Prescription status | derived from item status | documented; no container | 5 |
| 3.4 Presented form | `DocumentReference`/`Binary` entry in `BndEP` | O | 5 |
| 3.5.1–3.5.3 Item id, status, medication | `MR.identifier`, `status`, `statusReason`, `medication[x]` | `statusReason` required when status is on-hold/cancelled/stopped (**invariant**, 3.5.2.2) | 5 |
| 3.5.4 / 3.5.5 Indication, intended use | `MR.reasonCode`, `MR.category` | O | 5 |
| 3.5.6 Period of use | `MR.extension:effectiveDosePeriod` (MPD) | R: MS | 5 |
| 3.5.7 Quantity | `MR.dispenseRequest.quantity` **1..1** (brief) + words-and-figures extension (3.5.7.2) | CD invariant | 5 |
| 3.5.8 Dosage | `MR.dosageInstruction` 1..* | text 1..1; structured-implies-text invariant | 5 |
| 3.5.9 Validity | `dispenseRequest.validityPeriod` MS; `extension:doNotExtend` (3.5.9.2) | CD Schedules 2/3 ≤ 14 days (invariant) | 5 |
| 3.5.10 Substitution | `substitution.allowedBoolean` (Do Not Substitute = false) + `reason` | reason required when not allowed (3.5.10.3) | 5 |
| 3.5.11–3.5.13 Repeats, instalments, interval | `numberOfRepeatsAllowed`, `extension:numberOfInstalments`, `dispenseInterval` | instalments required for CD Schedules 2/3/4 Part 1; `courseOfTherapyType` MS | 5 |
| 3.5.14 Off label | MPD `offLabelUse` (IHE extension) | replaces `IECoreOffLabelUse` | 5 |
| 4.1–4.3 Identifier, classification, name | `Med.code` (NMPC placeholder CS + SNOMED CT), `extension:classification` (ATC, supply legal status, MDA schedule) | MDA schedule placeholder CS | 5, 7 |
| 4.4–4.7 MAH, dose form, ingredients, strength, pack | `Med.manufacturer`, `form` (EDQM), `ingredient` **1..*** (item 1..1, strength Ratio UCUM), `amount` | EDQM bindings (7) | 5, 7 |
| 4.8–4.9 Device, characteristics | not modelled in R4 Medication → **Gap (Optional)**, documented | — | — |
| 4.10 Batch | `Med.batch` | R: MS | 5 |
| 5.1–5.2.7 Dosage | `Dosage` (MPD `Dosage-eu-mpd`) | `patientInstruction`, `doseAndRate.dose[x]`, `timing.repeat.frequency`/`period` MS; route EDQM | 5, 7 |
| 6.1–6.3 Identifier, recorded, status | `MD.identifier`, `extension:recorded` **1..1** (6.2 M), `status`, `statusReason` | `statusReason` required for non-dispensation (declined/stopped) | 5 |
| 6.4 Receiver | `MD.receiver` (Patient/Practitioner) + `extension:receiverRelatedPerson` → `IECoreRelatedPerson` | O | 5 |
| 6.5 Related request | `MD.authorizingPrescription` **1..1** | stricter than HIQA (OI-012) | 5 |
| 6.6–6.12 Medication, quantity, date/time, substitution, dosage, notes | `MD.medication[x]`, `quantity` 1..1, `whenHandedOver` **1..1**, `substitution.wasSubstituted`, `dosageInstruction`, `note` | — | 5 |

## B. Patient Summary (HIQA PS)

| HIQA PS | Target | Key constraints | Phase |
|---|---|---|---|
| 1.1–1.3 Name, address, identifiers | `PatPS` (parent `patient-eu-eps`, imposes `IECorePatient`) | as EP; plus former names (`name.use=old`), preferred name (`usual`), middle names (`given[1..]`) | 4 |
| 1.3.4 Health insurance | `IECoreCoverage` entries in `BndPS` | R | 6 |
| 1.4.1–1.4.12 Demographics | `PatPS` | DOB 1..1 (1900-01-01 convention documented); estimated age O; **birthPlace** R; **sex at birth 1..1**; gender R; **mother's former surnames** 0..* R; **nationality** 0..* R; **country of affiliation** R; language O; **ethnicity 0..* R**; `deceased[x]` R; cause of death R → Requires Clarification (no element; candidate extension) | 4 |
| ∅ marital status, religion, pronouns | `PatPS` | **0..0** | 4 |
| 1.5 Communication | `PatPS.telecom` | preferred method via `rank` + guidance | 4 |
| 2 Health practitioner | `Prac`/`Role`/`Org` via `Comp.author` and `PatPS.generalPractitioner` | registration invariant as EP | 6 |
| 3 Nominated contact person | `PatPS.contact` | MS: `name`, `relationship`, `telecom`; `address` O | 4 |
| 4 Alerts | `Comp.section:sectionAlert` → `IECoreFlag` | `emptyReason` MS; `Flag.period`, `status` M | 6 |
| 5 Allergies | `sectionAllergies` → `IECoreAllergyIntolerance` | reaction substance and description MS | 6 |
| 6 Medication | `sectionMedications` → `IECoreMedicationStatement` | dose M; route and site R | 6 |
| 7 Health conditions | `sectionProblems` → `IECoreConditionProblemsHealthConcerns` | `clinicalStatus` 1..1 (7.3.2 M); severity, bodySite, stage R | 6 |
| 8 Observation results | `sectionResults` → EU Lab / `IECoreObservationClinicalResult` | effective and value required (8.2.1, 8.2.4 M; dataAbsentReason permitted) | 6 |
| 9 Procedures | `sectionProceduresHx` → `IECoreProcedure` | `performed[x]` relaxed to 0..1 MS (HIQA R) | 6 |
| 10 Devices / implants | `sectionMedicalDevices` → **DeviceUseStatement** (EPS `deviceStatement`) + `IECoreImplantableDevice` | period R; status M; bodySite, reason R | 6 |
| 11 Patient-provided data | `sectionPatientStory` | narrative | 6 |
| 12 Social context | `sectionSocialHistory` | narrative + `IECoreSimpleObservation` entries | 6 |
| 13 AHD | `sectionAdvanceDirectives` → `IECoreADIDocumentReference` | attachment 1..1 (13.3.2); category R (Requires Clarification) | 6 |
| 14 Travel history | `sectionTravelHx` (EPS `travelObservation`) | country visited M within the entry | 6 |
| 15 Pregnancy | `sectionPregnancyHx` (status, outcome, **gestationalAge**) | EDD M within the entry | 6 |
| 16 Immunisation | `sectionImmunizations` → `IECoreImmunization` | target disease, dose number, performer, location R | 6 |
| 17 Functional status | `sectionFunctionalStatus` | Condition / ClinicalImpression | 6 |
| 18 Care plan | `sectionPlanOfCare` → `IECoreCarePlan` | title and description R | 6 |
| 19.1 Document provenance | `Comp` + `BndPS.identifier` 1..1 | attester and legal authenticator as `attester` with mode | 6 |
| 19.2 Entry provenance | native `recorder`/`recordedDate`/`asserter` MS on each entry profile | — | 6 |
| every section | `section.text` MS; `emptyReason` MS where HIQA has an empty reason | invariant: `entry.exists() or emptyReason.exists()` for the sections HIQA makes Required | 6 |

## C. File-change list

**New files**

| Path | Phase |
|---|---|
| `input/fsh/profiles/IECorePatientEPrescription.fsh`, `IECorePatientSummaryPatient.fsh` | 4 |
| `input/fsh/extensions/HIQAExtensions.fsh` (age at prescribing, mother's former surname, country of affiliation, words-and-figures quantity, instalments, do-not-extend, MDA schedule, medication classification, related-person receiver) | 4, 5 |
| `input/fsh/profiles/IECoreBundleEPrescription.fsh` (+ cross-border), `IECoreListAllergiesAtPrescribing.fsh`, `IECoreProvenanceEPrescriptionSignature.fsh` | 5 |
| `input/fsh/profiles/IECoreBundlePatientSummary.fsh`, `IECoreDeviceUseStatement.fsh`, travel / gestational-age observation profiles (only if EPS ones are insufficient) | 6 |
| `input/fsh/terminology/HIQAPlaceholders.fsh` (NMPC placeholder CS, MDA schedule CS, PCRS scheme CS; all "Requires Clarification") | 5, 7 |
| `input/fsh/identifiers/NamingSystems.fsh` (placeholder URIs, OI-003) | 4 |
| Examples: 8 new scenarios (Phase 8 list) as FSH instances | 8 |
| `tests/features/hiqa-eprescription.feature`, `hiqa-patient-summary.feature`, `data-minimisation.feature`, traceability test, `scripts/hiqa/guard_no_ethnicity_in_eprescription.py` | 8 |
| Pages: `hiqa-2026-alignment.md`, `data-minimisation.md`, `open-issues.md` | 9 |
| `docs/hiqa-2026/consultation-feedback.md`, release-notes draft | 11 |
| `.github/dependabot.yml` | 9 |

**Changed files**

| Path | Change | Phase |
|---|---|---|
| `input/fsh/profiles/IECorePatient.fsh` | drop MS on ethnicity, maiden name, pronouns, interpreter; remove GMS, DPS, LTI, HAA and IMN slices; IHI 18/10; sex-at-birth extension | 4 |
| `input/fsh/identifiers/Identifiers.fsh` | remove 7 unsourced identifier profiles (ADR-006) | 4 |
| `input/fsh/extensions/Extensions.fsh` | ethnicity → CodeableConcept 0..*; rename duplicate-name entities (SUSHI warning) | 4 |
| `input/fsh/aliases.fsh` | add MPD, EPS and GLN aliases; remove unused and unsourced aliases | 4, 5 |
| `input/fsh/profiles/IECorePractitioner.fsh`, `IECoreOrganization.fsh`, `IECoreLocation.fsh` | registration, PSI RPB and GLN slices; remove HPI and CRN | 5 |
| `input/fsh/profiles/IECoreEPrescription.fsh` | re-parent on MPD; retire `IECoreOffLabelUse`; new constraints | 5 |
| `input/fsh/profiles/IECorePatientSummary.fsh` | re-parent on EPS; rename slices; section constraints | 6 |
| `IECoreAllergyIntolerance.fsh`, `IECoreProcedure.fsh`, `IECoreCondition.fsh`, `IECoreImmunization.fsh`, `IECoreMedicationStatement.fsh`, `IECoreCarePlan.fsh`, `IECoreFlag.fsh`, `IECoreObservation.fsh` | MS for HIQA Required elements; `performed[x]` relaxed | 5, 6 |
| `input/fsh/terminology/CodeSystems.fsh`, `ValueSets.fsh` | audit; ethnicity CS verification; new value sets from HIQA text or recognised standards | 7 |
| `input/fsh/capability/CapabilityStatements.fsh`, `searchparameters/SearchParameters.fsh` | new profiles; `MedicationDispense?prescription` | 5, 6 |
| `input/fsh/examples/*.fsh`, `input/examples/*.json`, `scenario-*.json`, `IE_to_DE_ePrescription_CDA.xml`, `input/postman/*.json` | identifier migration; remove invented tags; add `recorded`, allergy List and signature; no ethnicity or maiden name | 8 |
| `sushi-config.yaml` | add `hl7.fhir.eu.eps` 1.0.0-ballot; version 0.2.0 (Phase 11); menu | 4, 9, 11 |
| `input/pagecontent/*.md` (index, ehds-conformance, crossborder-*, irish-legislation, must-support, security, terminology-services, testing, changes) | per Phase 9 | 9 |
| `r5/**` | freeze banner; IHI 18/10; drop GMS invariant | 9 |
| `.github/workflows/*.yml` | pin SHAs and tool versions; least privilege; caching; new gates | 9 |
| `docs/hiqa-2026/mapping/*.csv` → regenerated matrix and page | every phase | 4–7 |

**Deleted:** none at file level. Profiles are removed inside `Identifiers.fsh`; `IECoreOffLabelUse`
is removed inside `IECoreEPrescription.fsh`.
