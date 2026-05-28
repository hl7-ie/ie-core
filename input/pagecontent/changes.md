### Change Log

This page documents changes to the IE Core Implementation Guide.

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

- **`IECoreMedicationStatement`** (Draft) — maps to `EHDSMedicationUse` (XT-EHR 1.0.0). Uses FHIR R4 `MedicationStatement`; note that FHIR R5 uses `MedicationUsage`. Added to MedicationProfiles group in sushi-config.yaml.
- **`IECoreFlag`** (Draft) — maps to `EHDSAlert` (XT-EHR 1.0.0). Uses FHIR R4 `Flag`. Added to ClinicalProfiles group in sushi-config.yaml.

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
