### Change Log

This page documents changes to the IE Core Implementation Guide.

### Version 0.2.0 (unreleased, draft): HIQA draft national standards (Sept 2026)

Aligns IE Core with the HIQA *Draft National Standard for Electronic Prescriptions and Electronic
Dispensations* and the *Draft National Standard for a Patient Summary* (both public consultation
drafts, September 2026). Decisions are recorded in ADR-001 to ADR-007 (`docs/adr/` in the source
repository). The HIQA element IDs are cited as EP x.y / PS x.y.

#### BREAKING

- **Context-specific patient profiles (ADR-002).** `IECorePatient` is now a permissive base:
  ethnicity, mother's maiden name, pronouns and interpreter-required are no longer MustSupport.
  - New `IECorePatientEPrescription`: exactly the HIQA EP patient dataset. Ethnicity, mother's
    maiden name, nationality, citizenship, place of birth, religion, marital status, pronouns,
    photo and contact are **prohibited (0..0)** (GDPR Art. 5(1)(c); Art. 9).
  - New `IECorePatientSummaryPatient` (parent HL7 Europe EPS patient; imposes `IECorePatient`):
    HIQA PS demographics incl. ethnicity (PS 1.4.10), nationality (1.4.7), mother's former
    surnames (1.4.6), place of birth (1.4.3), country of affiliation (1.4.8), and the
    nominated contact person (PS 3).
  - `IECoreMedicationRequestEPrescription.subject` and `IECoreMedicationDispenseEDispensation.subject`
    → `IECorePatientEPrescription`; `IECoreCompositionPatientSummary.subject` → `IECorePatientSummaryPatient`.
- **Identifier rationalisation (ADR-006).** Removed identifiers with no authoritative source:
  HPI (practitioner and organisation), IMN, CRN, and the GMS/DPS/LTI/HAA slices, datatype profiles
  and format invariants `ie-pat-2..5`. PCRS scheme numbers are now HIQA "other identifiers"
  (EP/PS 1.3.3) typed with a placeholder code system. The "Hospital Appointment Access" label was wrong;
  HIQA defines HAA as the Health (Amendment) Act card scheme.
- **Ethnicity extension** value changed from `code` 0..1 (required binding) to `CodeableConcept`
  (repeatable, extensible binding), per PS 1.4.10.

- **ePrescription/eDispensation re-parented on HL7 Europe MPD 1.0.0 (ADR-003).**
  `IECoreMedicationRequestEPrescription`, `IECoreMedicationDispenseEDispensation` and
  `IECoreMedicationEPrescription` now derive from the MPD profiles. The custom `IECoreOffLabelUse`
  extension is **retired** in favour of MPD's IHE off-label extension. Dispenses must carry MPD's
  `recorded` (HIQA EP 6.2). `authorizingPrescription` is exactly 1..1. `requester` must be a
  Practitioner or PractitionerRole (registration is Mandatory, EP 2.6).
- `IECorePractitioner` requires at least one registration identifier (EP/PS 2.6) and a given name.
- **Patient Summary re-parented on HL7 Europe EPS 1.0.0-ballot (ADR-004).**
  `IECoreCompositionPatientSummary` now derives from `composition-eu-eps` (which imposes the IPS
  Composition). The IE section slices are replaced by the EPS slices (`medications` →
  `sectionMedications`, `alerts` → `sectionAlert`, `travelHistory` → `sectionTravelHx`, …).
  Medical devices are DeviceUseStatement entries. `IECoreProcedure.performed[x]` is relaxed from
  1..1 to 0..1 (HIQA PS 9.3.1 Required).

- **Terminology integrity (ADR-007).** 37 codes whose meaning contradicted the IG's label were
  corrected or removed (e.g. "Omeprazole" was coded as Imipramine); 13 non-existent and 6 inactive
  codes were removed; 6 dangling ValueSet bindings were fixed. See `docs/hiqa-2026/terminology-remediation.csv`.
- **Ethnicity CodeSystem** now uses the CSO Data Standard for Ethnicity v1.0 (7 Feb 2025) codes
  (10–36, 99). The previous slug codes (`white-irish`, …) are removed.

- **Payload identifiers and codes (Phase 8).** The sample JSON payloads, CDA documents and Postman
  collection no longer use `http://hl7.hse.ie/...`, invented national identifier systems, invented
  national product codes, the invented `ehealth.ec.europa.eu/fhir/tag#xt-ehr` tag or the misused
  `v3-ActCode#PBILLACCT` tag. Prescription identifiers use the NePS system; dispense and document
  identifiers use `urn:uuid`; CDA OIDs use the HL7 example arc (OI-020). Hypercholesterolaemia is
  ICD-10 E78.0 (was E78.5, *Hyperlipidaemia, unspecified*).

- **Legacy payload Bundles validate (Phase 9).** The 22 JSON payloads in `input/examples` are published IG examples,
  but they had never validated (non-UUID `urn:uuid` fullUrls, `_comment`, missing dispense `recorded`, and so on).
  `scripts/audit/conform_payloads.py` fixed them without inventing clinical content; all 22 now validate. They are
  plain `collection` Bundles: they do **not** claim `IECoreBundleEPrescription` and carry no allergy statement or
  signature, so they are illustrative only; the HIQA scenario Bundles are the conformant references.
- **Independent review fixes (Phase 10, `docs/audit/review-hiqa-2026.md`).** Prescription items must reference a
  Medication (**BREAKING**); controlled-drug rules rewritten to the HIQA text (`ie-rx-cd-1/2/3`); new Bundle
  invariants `ie-bnd-rx-5` (one patient) and `ie-bnd-rx-6` (listed allergies included); `ie-bnd-rx-2` requires the
  allergy-statement List code; prescriber phone/email rules start from `requester`; the age is required when the date
  of birth is partial; `AllergyIntolerance.clinicalStatus` 0..1 with `ie-allergy-1` so an allergy entered in error can
  be retracted; group identifier compares system and value. NMPC ValueSets are marked experimental (refset IDs
  unverified, OI-018); unused aliases with unverified URIs removed; FSH examples no longer use invented national
  identifier or product code systems.
- **R5 track frozen (ADR-005).** Banner on the R5 pages; IHI accepts 18 or 10 digits; the unsourced GMS slice and
  format invariant were removed. R5 is no longer a CI gate.
- **Identifier pages (ADR-006).** HPI, DPS/LTI/HAA/GMS formats, IMN and CRN removed from the documentation; the IHI
  "modulus 11 / GS1 check digit" claim removed (no source; OI-002).
- **Terminology page.** SNOMED CT Irish Edition is named in `version`, never in `system`; the invented HPRA "code
  system" URI was removed (OI-023).

#### Changed

- New pages: [HIQA 2026 Alignment](hiqa-2026-alignment.html), [Data Minimisation](data-minimisation.html) and
  [Open Issues](open-issues.html) (generated from `docs/hiqa-2026/open-issues.md`), in a new HIQA 2026 menu.
- The home page opens with an INFO notice (HIQA consultation drafts) and a WARNING (proof of concept, not for clinical
  use, placeholders, fictional examples).
- CI: GitHub Actions pinned to commit SHAs; read-only permissions except the Pages deploy and the PR comment; SUSHI
  3.18.0, IG Publisher 2.3.4 and validator 6.10.4 pinned and checked by SHA-256; FHIR package and validator caches;
  new gates for the traceability, mapping, data-minimisation guard, codes, validator QA baseline and page links;
  Dependabot for Actions and npm. The version page no longer claims publication by HL7 Ireland or the HSE.
- `ie-bnd-xb-2` accepts the signature target as the entry `fullUrl` or as a relative reference.
- `ie-rx-cd-2` compares the validity end and the 14-day limit as dates (a date and a dateTime of
  different precision previously compared as empty).
- `tests/validator/run-validation.js` reads the dependencies from `sushi-config.yaml` (it pinned
  EU Base 0.1.0, IPS 1.1.0 and MPD 0.1.0-ballot) and validates all examples in one validator run.
- SNOMED CT Irish edition ValueSets now use `system` http://snomed.info/sct with the edition as
  `version`. Previously the edition URI was used as the system, so nothing could match.
- `$NMPC` example codes live in an explicit placeholder CodeSystem (`IECoreNMPCPlaceholder`), clearly not the NMPC.
- IHI invariant `ie-pat-1` accepts **18 or 10 digits** (EP/PS 1.3.1). It previously rejected valid 10-digit IHIs.
- Sex assigned at birth (EP 1.4.3 / PS 1.4.4, Mandatory) is modelled with `individual-recordedSexOrGender`
  (type LOINC 76689-9) and is separate from administrative gender and gender identity.
- EU Base patient extension slices (`gender-identity`, `pronouns`, `patient-nationality`,
  `birthPlace`) are reused instead of being re-declared. The previous duplicate slices overlapped.

#### Added

- `IECoreBundlePatientSummary` (parent EPS Bundle; identifier 1..1 for HIQA PS 19.1.2; IE Coverage
  entries for PS 1.3.4). Invariants `ie-ps-1` (entries or emptyReason in every section HIQA gives
  an empty reason to) and `ie-ps-attester-1`.
- HIQA PS Required elements marked MustSupport on the IE clinical profiles (AllergyIntolerance,
  MedicationStatement, Condition, Procedure, Immunization, CarePlan); `ie-cond-1` (condition status
  required unless entered-in-error).
- `IECoreBundleEPrescription` (+ `IECoreBundleEPrescriptionCrossBorder`, claimed in `meta.profile`
  to flag a cross-border prescription), `IECoreListAllergiesAtPrescribing` (the allergy statement
  sent with every prescription, EP 1.6.1/1.6.2) and `IECoreProvenanceEPrescriptionSignature`
  (EP 2.13).
- Invariants: group identifier (`ie-bnd-rx-1`), allergy statement (`ie-bnd-rx-2`,
  `ie-list-allergy-1`), under-12 age (`ie-bnd-rx-3`), prescriber phone (`ie-bnd-rx-4`),
  cross-border email and signature (`ie-bnd-xb-1/2`), status reason (`ie-rx-status-1`),
  structured dosage with text (`ie-rx-dosage-1`), Do Not Substitute reason (`ie-rx-subst-1`),
  controlled drugs (`ie-rx-cd-1/2`), non-dispensation reason (`ie-md-status-1`), hand-over date
  (`ie-md-handover-1`), GLN check digit (`ie-loc-gln-1`).
- Registration identifier slices (IMC, PSI, NMBI, Dental Council), PSI Retail Pharmacy Business
  number, GMS Panel ID, and GLN (GS1, `http://www.gs1.org/gln`).
- Extensions for HIQA EP elements not covered by HL7/EU/IHE: quantity in words and figures, number
  of instalments, do-not-extend, interchangeable, exempt medication item, receiver (related person).
- Placeholder code systems for the MDA schedule and supply legal status (Requires Clarification).
- SearchParameter `ie-core-medicationrequest-group-identifier`. The server CapabilityStatement adds
  `MedicationDispense?prescription` (repeats dispensed are derived, not stored), Bundle and List.
- HIQA logical models `HIQAEPrescriptionLM` and `HIQAPatientSummaryLM` with mappings to IE Core,
  and the [HIQA Traceability](hiqa-traceability.html) page (ADR-001).
- Extensions: `IECorePatientAgeAtPrescribing` (EP 1.4.2; invariant `ie-rx-age-1`: age required on
  prescriptions for children under 12), `IECoreMothersFormerSurname` (PS 1.4.6),
  `IECoreCountryOfAffiliation` (PS 1.4.8).
- PPSN identifier slice (EP/PS 1.3.2), deliberately not MustSupport (legal basis Requires Clarification).
- NamingSystems that openly mark every IG-minted identifier URI as a placeholder.
- Dependency `hl7.fhir.eu.eps` 1.0.0-ballot (ADR-004).
- Eight synthetic HIQA scenarios, each as a Bundle: acute adult prescription; paediatric (under 12,
  age and weight); repeat with a part fill, balance and repeat; Schedule 2 controlled drug with
  instalments; non-dispensation (declined because of a recorded penicillin allergy); cross-border
  IE→EU with a prescriber signature; full Patient Summary; Patient Summary with empty sections.
- Tests: `hiqa-eprescription.feature`, `hiqa-patient-summary.feature` and `data-minimisation.feature`
  evaluate the IG's own invariants with fhirpath.js, including a broken copy for every rule; the
  traceability check runs as a test; `scripts/qa/check_ep_data_minimisation.py` fails the build if
  ePrescription content mentions ethnicity, maiden name, nationality, citizenship, religion or marital status.

### Version 0.1.1 (May 2026) — XT-EHR 1.0.0 Alignment

This release aligns IE Core with the XT-EHR logical model **v1.0.0** (released 2025). The XT-EHR 1.0.0 release introduced a formal Obligations Framework, new base models (`EHDSDocument`, `EHDSDataSet`), mandatory section updates to the Patient Summary and Hospital Discharge Report, and additional ePrescription elements.

#### Profile Updates

**IE Core Patient Summary (`IECoreCompositionPatientSummary`)**
- `procedures` section changed from optional (0..1) to **mandatory (1..1)** per EHDSPatientSummary v1.0.0
- `medicalDevices` section changed from optional (0..1) to **mandatory (1..1)** per EHDSPatientSummary v1.0.0
- `results` section renamed to `observationResults` (LOINC `30954-2`); entry types expanded to include `IECoreObservationClinicalResult`
- `planOfCare` section renamed to `carePlans`; entry references `IECoreCarePlan`
- `medications.entry` updated to reference `IECoreMedicationStatement` as primary type, reflecting EHDSMedicationUse → MedicationStatement mapping
- Added `emptyReason MS` on all mandatory sections (medications, allergies, problems, procedures, medicalDevices)
- Added `text MS` (narrative) on all sections
- Added 8 new optional sections aligned with EHDSPatientSummary v1.0.0:
  - `alerts` (LOINC `104605-1`) — references `IECoreFlag or IECoreAllergyIntolerance`
  - `functionalStatus` (LOINC `47420-5`)
  - `socialHistory` (LOINC `29762-2`)
  - `pregnancyHistory` (LOINC `10162-6`)
  - `travelHistory` (LOINC `10182-4`)
  - `advanceDirectives` (LOINC `42348-3`) — references `IECoreADIDocumentReference`
  - `carePlans` (LOINC `18776-5`) — references `IECoreCarePlan`
  - `patientStory` (LOINC `81338-6`) — narrative only

**IE Core Hospital Discharge Report (`IECoreCompositionDischargeReport`)**
- Complete restructure to match EHDSDischargeReport v1.0.0 section model:
  - New mandatory `encounterInformation` (1..1) section — references `IECoreEncounter`
  - New mandatory `courseOfEncounter` (1..1) section with four sub-sections: diagnoses, procedures, pharmacotherapy, testResults
  - `admissionDetails` replaced by `encounterInformation`
  - `diagnoses`, `procedures`, `medications` flat sections replaced by sub-sections within `courseOfEncounter`
  - Added `admissionEvaluation` (0..1) — functional status and objective findings on admission
  - Added `patientHistory` (0..1) — anamnesis, past problems, prior procedures, devices
  - Added `dischargeDetails` (0..1) — objective findings and discharge summary
  - Added `alerts` (0..1) — references `IECoreFlag or IECoreAllergyIntolerance`
  - `medicationSummary` section (LOINC `75311-1`) references `IECoreMedicationStatement`

**IE Core ePrescription (`IECoreMedicationRequestEPrescription`)** — aligned with EHDSMedicationPrescription v1.0.0:
- Added `statusReason MS` — reason for current prescription status
- Added `dispenseRequest.dispenseInterval MS` — minimum interval between dispensations (minimumDispenseInterval)
- Updated `category` description to include `intendedUseType`
- Added `IECoreOffLabelUse` extension for off-label use indicator (offLabel boolean + reason)

#### New Profiles

- **`IECoreMedicationStatement`** — maps to `EHDSMedicationUse` (XT-EHR 1.0.0 Release). Uses FHIR R4 `MedicationStatement`; note that FHIR R5 uses `MedicationUsage`. Added to MedicationProfiles group in sushi-config.yaml.
- **`IECoreFlag`** — maps to `EHDSAlert` (XT-EHR 1.0.0 Release). Uses FHIR R4 `Flag`. Added to ClinicalProfiles group in sushi-config.yaml.

#### New Extensions

- **`IECoreOffLabelUse`** — Extension for off-label use on `MedicationRequest`. Contains `isOffLabelUse` (boolean) and `reason` (CodeableConcept or string) sub-extensions. Added to EPrescriptionProfiles group.

#### Documentation Updates

- `ehds-conformance.md`: Alignment matrix updated from v0.3.0 to v1.0.0; added new model rows (`EHDSDocument`, `EHDSDataSet`, `EHDSBodyStructure`, `EHDSAttachment`); added Obligations Framework section; added FHIR R4/R5 Compatibility section; updated Future EU Alignment list
- `future-of-ie-core.md`: Revised roadmap to reflect XT-EHR 1.0.0 release; added new short-term priorities
- `crossborder-eprescription.md`: Updated with XT-EHR 1.0.0 ePrescription model additions
- `general-guidance.md`: Added Obligations Framework guidance note
- `index.md`: Updated profile tables to include new profiles; updated PS/HDR section descriptions

#### Breaking Changes

- Patient Summary `results` section code changed from `30954-2` (previously used) — both map to LOINC `30954-2` (Relevant diagnostic tests/laboratory data). No breaking change.
- Patient Summary `planOfCare` → `carePlans`: section code `18776-5` (Plan of care note) unchanged. The FHIR section `id` has changed from `planOfCare` to `carePlans` — consumers using hardcoded section IDs will need to update.
- Hospital Discharge Report: flat section structure replaced with nested `courseOfEncounter` structure. Consumers using hardcoded section LOINC codes should verify against the updated profile.

---

### Version 0.1.0 (March 2025)

Initial draft of the IE Core Implementation Guide. This is a development snapshot and has not yet been submitted for formal HL7 ballot.

#### New Profiles

- IE Core Patient Profile
- IE Core Practitioner Profile
- IE Core PractitionerRole Profile
- IE Core Organization Profile
- IE Core Location Profile
- IE Core Encounter Profile
- IE Core Condition Encounter Diagnosis Profile
- IE Core Condition Problems and Health Concerns Profile
- IE Core AllergyIntolerance Profile
- IE Core Procedure Profile
- IE Core CarePlan Profile
- IE Core CareTeam Profile
- IE Core Goal Profile
- IE Core ServiceRequest Profile
- IE Core RelatedPerson Profile
- IE Core Medication Profile
- IE Core MedicationRequest Profile
- IE Core MedicationDispense Profile
- IE Core Immunization Profile
- IE Core DiagnosticReport for Laboratory Results
- IE Core DiagnosticReport for Report and Note Exchange
- IE Core DocumentReference Profile
- IE Core ADI DocumentReference Profile
- IE Core Observation Clinical Result Profile
- IE Core Laboratory Result Observation Profile
- IE Core Simple Observation Profile
- IE Core Smoking Status Observation Profile
- IE Core Vital Signs Profile (and all sub-profiles)
- IE Core Coverage Profile
- IE Core Implantable Device Profile
- IE Core Provenance Profile
- IE Core QuestionnaireResponse Profile
- IE Core Specimen Profile
- IE Core Average Blood Pressure Profile

#### New Extensions

- IE Core Ethnicity
- IE Core Patient Mother's Maiden Name
- IE Core Gender Identity
- IE Core Interpreter Required
- IE Core IHI Status
- IE Core IHI Record Status
- IE Core IHI Verification Date
- IE Core Medication Adherence
- IE Core Authentication Time
- IE Core Extension Questionnaire URI
- IE Core Direct Email

#### New Identifier Profiles

- Individual Healthcare Identifier (IHI)
- Health Service Provider Identifier (HPI)
- Irish Medical Council (IMC)
- Medical Record Number (MRN)
- General Medical Service (GMS)
- Drugs Payment Scheme (DPS)
- Long Term Illness (LTI)
- Health Amendment Act (HAA)
- Insurance Member Number (IMN)
- Company Registration Number (CRN)

#### Terminology

- 10 new CodeSystems
- 49 new ValueSets

#### Capability Statements

- IE Core Server CapabilityStatement
- IE Core Client CapabilityStatement

#### Search Parameters

- 20 IE Core-specific search parameters
