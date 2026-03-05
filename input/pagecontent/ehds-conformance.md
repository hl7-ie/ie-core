### EHDS & EU Conformance

The IE Core Implementation Guide is designed to ensure conformance with the European Health Data Space (EHDS) and enable cross-border interoperability across EU Member States. IE Core provides dedicated profiles for all five EHDS priority data categories.

### Layered Architecture

IE Core follows the layered FHIR profile architecture established by HL7 Europe:

```
┌──────────────────────────────────────────────────────────┐
│         IE Core Profiles (Irish)                         │  ← This IG
│  Irish identifiers, HSE schemes, Eircodes, PCRS         │
├──────────────────────────────────────────────────────────┤
│  HL7 Europe Scoped IGs                                   │
│  MPD, Laboratory, Patient Summary, HDR, Imaging          │
├──────────────────────────────────────────────────────────┤
│  HL7 Europe Core Profiles (EU)            hl7.fhir.eu.base│
│  EHDS-aligned, cross-border constraints                  │
├──────────────────────────────────────────────────────────┤
│  HL7 Europe Base Profiles (EU)            hl7.fhir.eu.base│
│  Loosely constrained European concepts                   │
├──────────────────────────────────────────────────────────┤
│  International Patient Summary (IPS)      hl7.fhir.uv.ips │
│  Universal cross-border patient summary                  │
├──────────────────────────────────────────────────────────┤
│  FHIR R4 Base Resources                                  │
│  HL7 FHIR standard resource definitions                 │
└──────────────────────────────────────────────────────────┘
```

### EU Dependencies

| Package | Version | Status | Purpose |
|---------|---------|--------|---------|
| `hl7.fhir.eu.base` | 0.1.0 | STU 1.0 | EU Base and Core profiles |
| `hl7.fhir.eu.laboratory` | 0.1.1 | STU 1.1 | EU Laboratory Report |
| `hl7.fhir.uv.ips` | 1.1.0 | STU 1 | International Patient Summary |
| `hl7.fhir.uv.extensions.r4` | 5.1.0 | Published | FHIR R4 extensions |

The following EU IGs are tracked for future formal dependency once published:

| Package | Current Version | Status | Purpose |
|---------|----------------|--------|---------|
| `hl7.fhir.eu.mpd` | 0.1.0-ci-build | CI Build | Medication Prescription & Dispense |
| `hl7.fhir.eu.eps` | 0.0.1-ci | CI Build | European Patient Summary |
| `hl7.fhir.eu.hdr` | 0.1.0-ballot | Ballot | Hospital Discharge Report |

---

### EHDS Five Priority Categories

The EHDS regulation identifies five priority categories for the European Electronic Health Record Exchange Format (EEHRxF). IE Core provides dedicated profiles for each:

#### 1. Patient Summary

| IE Core Profile | Xt-EHR Logical Model | HL7 Europe IG |
|----------------|---------------------|---------------|
| [IE Core Patient Summary](StructureDefinition-ie-core-composition-patient-summary.html) | EHDSPatientSummary | `hl7.fhir.eu.eps` (tracked) |
| [IE Core Patient](StructureDefinition-ie-core-patient.html) | EHDSPatient | EU Core Patient |
| [IE Core Condition](StructureDefinition-ie-core-condition-problems-health-concerns.html) | EHDSCondition | EU Core Condition (v2.0) |
| [IE Core AllergyIntolerance](StructureDefinition-ie-core-allergyintolerance.html) | EHDSAllergyIntolerance | EU Core AllergyIntolerance (v2.0) |
| [IE Core Medication](StructureDefinition-ie-core-medication.html) | EHDSMedication | EU Core Medication (v2.0) |
| [IE Core Immunization](StructureDefinition-ie-core-immunization.html) | EHDSImmunisation | EU Core Immunization (v2.0) |
| [IE Core Procedure](StructureDefinition-ie-core-procedure.html) | EHDSProcedure | EU Core Procedure (v2.0) |

The IE Core Patient Summary profile structures essential clinical information using the IPS section model (medications, allergies, problems, procedures, immunizations, results, vital signs) for both domestic continuity of care and cross-border exchange via MyHealth@EU.

#### 2. ePrescription & eDispensation

| IE Core Profile | Xt-EHR Logical Model | HL7 Europe IG |
|----------------|---------------------|---------------|
| [IE Core MedicationRequest (ePrescription)](StructureDefinition-ie-core-medicationrequest-eprescription.html) | EHDSMedicationPrescription | `hl7.fhir.eu.mpd` (tracked) |
| [IE Core MedicationDispense (eDispensation)](StructureDefinition-ie-core-medicationdispense-edispensation.html) | EHDSMedicationDispense | `hl7.fhir.eu.mpd` (tracked) |
| [IE Core Medication (ePrescription)](StructureDefinition-ie-core-medication-eprescription.html) | EHDSMedication | `hl7.fhir.eu.mpd` (tracked) |

These profiles support the full ePrescription and eDispensation lifecycle:

- **Prescription creation** by an Irish GP or hospital prescriber, with PCRS claim reference and GMS scheme identifiers
- **Cross-border prescription exchange** via MyHealth@EU ePharmacy services
- **Dispensation recording** by an Irish community or hospital pharmacist
- **Substitution tracking** under Irish pharmacy regulations
- **Multi-item prescriptions** via `groupIdentifier` linking

The profiles are structurally aligned with the HL7 Europe MPD IG (`MedicationRequest-eu-mpd`, `MedicationDispense-eu-mpd`, `Medication-eu-mpd`) and will formally derive from these profiles once the MPD IG is published as STU.

#### 3. Laboratory Results

| IE Core Profile | Xt-EHR Logical Model | HL7 Europe IG |
|----------------|---------------------|---------------|
| [IE Core Laboratory Report](StructureDefinition-ie-core-laboratory-report.html) | EHDSLaboratoryReport | `hl7.fhir.eu.laboratory` (v0.1.1) |
| [IE Core Lab Observation](StructureDefinition-ie-core-laboratory-result-observation.html) | EHDSLaboratoryObservation | EU Lab Observation |
| [IE Core Specimen](StructureDefinition-ie-core-specimen.html) | EHDSSpecimen | EU Lab Specimen |
| [IE Core DiagnosticReport (Lab)](StructureDefinition-ie-core-diagnosticreport-lab.html) | EHDSLaboratoryReport | EU Core DiagnosticReport (v2.0) |

The IE Core Laboratory Report profile is aligned with the published HL7 Europe Laboratory Report IG (STU 1.1). It supports laboratory reporting workflows for clinical biochemistry, haematology, microbiology, immunology, and other in-vitro diagnostic disciplines.

#### 4. Hospital Discharge Report

| IE Core Profile | Xt-EHR Logical Model | HL7 Europe IG |
|----------------|---------------------|---------------|
| [IE Core Discharge Report](StructureDefinition-ie-core-composition-discharge-report.html) | EHDSDischargeReport | `hl7.fhir.eu.hdr` (tracked) |
| [IE Core Encounter](StructureDefinition-ie-core-encounter.html) | EHDSEncounter | — |
| [IE Core Condition (Encounter Dx)](StructureDefinition-ie-core-condition-encounter-diagnosis.html) | EHDSCondition | EU Core Condition (v2.0) |

The IE Core Hospital Discharge Report provides a structured Composition with sections for admission details, discharge diagnoses, procedures, medications, allergies, and post-discharge care plans.

#### 5. Medical Images & Reports

| IE Core Profile | Xt-EHR Logical Model | HL7 Europe IG |
|----------------|---------------------|---------------|
| [IE Core DiagnosticReport (Note)](StructureDefinition-ie-core-diagnosticreport-note.html) | EHDSImagingReport | In development |

Full imaging report profiles (ImagingStudy, ImagingReport) will be added when the HL7 Europe Imaging IG is published. The existing IE Core DiagnosticReport (Note) profile provides baseline support.

---

### Xt-EHR Logical Model Alignment Matrix

The following table maps Xt-EHR EHDS logical information models (v0.3.0) to IE Core FHIR profiles:

| Xt-EHR Model | FHIR Resource | IE Core Profile | Status |
|--------------|---------------|-----------------|--------|
| EHDSPatient | Patient | IECorePatient | Implemented (EU Core) |
| EHDSHealthProfessional | Practitioner / PractitionerRole | IECorePractitioner, IECorePractitionerRole | Implemented (EU Core) |
| EHDSOrganisation | Organization | IECoreOrganization | Implemented (EU Core) |
| EHDSLocation | Location | IECoreLocation | Implemented (EU Core) |
| EHDSCondition | Condition | IECoreCondition | Implemented |
| EHDSAllergyIntolerance | AllergyIntolerance | IECoreAllergyIntolerance | Implemented |
| EHDSProcedure | Procedure | IECoreProcedure | Implemented |
| EHDSImmunisation | Immunization | IECoreImmunization | Implemented |
| EHDSMedication | Medication | IECoreMedication, IECoreMedicationEPrescription | Implemented |
| EHDSMedicationPrescription | MedicationRequest | IECoreMedicationRequestEPrescription | Implemented |
| EHDSMedicationDispense | MedicationDispense | IECoreMedicationDispenseEDispensation | Implemented |
| EHDSMedicationUse | MedicationStatement | — | Planned |
| EHDSMedicationAdministration | MedicationAdministration | — | Planned |
| EHDSDosage | Dosage | (used within medication profiles) | Implemented |
| EHDSObservation | Observation | IECoreObservation variants | Implemented |
| EHDSLaboratoryObservation | Observation | IECoreLaboratoryResultObservation | Implemented |
| EHDSLaboratoryReport | DiagnosticReport | IECoreLaboratoryReport | Implemented |
| EHDSImagingReport | DiagnosticReport | IECoreDiagnosticReportNote | Partial |
| EHDSImagingStudy | ImagingStudy | — | Planned |
| EHDSDischargeReport | Composition | IECoreCompositionDischargeReport | Implemented |
| EHDSPatientSummary | Composition | IECoreCompositionPatientSummary | Implemented |
| EHDSCarePlan | CarePlan | IECoreCarePlan | Implemented |
| EHDSDevice | Device | IECoreImplantableDevice | Implemented |
| EHDSDeviceUse | DeviceUseStatement | — | Planned |
| EHDSServiceRequest | ServiceRequest | IECoreServiceRequest | Implemented |
| EHDSSpecimen | Specimen | IECoreSpecimen | Implemented |
| EHDSRelatedPerson | RelatedPerson | IECoreRelatedPerson | Implemented |
| EHDSEncounter | Encounter | IECoreEncounter | Implemented |
| EHDSAddress | Address | (Irish address within Patient/Organization) | Implemented |
| EHDSHumanName | HumanName | (within Patient/Practitioner) | Implemented |
| EHDSTelecom | ContactPoint | (within Patient/Practitioner/Organization) | Implemented |
| EHDSAlert | Flag | — | Planned (EU Core v2.0) |
| EHDSAdvanceDirective | Consent | — | Planned |
| EHDSCurrentPregnancy | Observation | IECoreObservation (pregnancy status) | Implemented |
| EHDSPregnancyHistory | Observation | IECoreObservation (pregnancy history) | Implemented |
| EHDSTravelHistory | Observation | — | Planned |
| EHDSEndpoint | Endpoint | — | Planned |

---

### Profile Derivation Map

#### Currently Derived from EU Core (v0.1.0)

| IE Core Profile | EU Core Parent | EU Profile ID |
|----------------|---------------|---------------|
| [IE Core Patient](StructureDefinition-ie-core-patient.html) | Patient (EU core) | `patient-eu-core` |
| [IE Core Practitioner](StructureDefinition-ie-core-practitioner.html) | Practitioner (EU core) | `practitioner-eu-core` |
| [IE Core PractitionerRole](StructureDefinition-ie-core-practitionerrole.html) | PractitionerRole (EU core) | `practitionerRole-eu-core` |
| [IE Core Organization](StructureDefinition-ie-core-organization.html) | Organization (EU core) | `organization-eu-core` |
| [IE Core Location](StructureDefinition-ie-core-location.html) | Location (EU core) | `location-eu-core` |

#### Planned Migration to EU Core (v2.0.0)

| IE Core Profile | Current Parent | Planned EU Core Parent |
|----------------|---------------|----------------------|
| IE Core AllergyIntolerance | FHIR AllergyIntolerance | `allergyIntolerance-eu-core` |
| IE Core Condition (x2) | FHIR Condition | `condition-eu-core` |
| IE Core Procedure | FHIR Procedure | `procedure-eu-core` |
| IE Core Immunization | FHIR Immunization | `immunization-eu-core` |
| IE Core Medication | FHIR Medication | `medication-eu-core` |
| IE Core MedicationRequest | FHIR MedicationRequest | `medicationRequest-eu-core` |
| IE Core DiagnosticReport (x2) | FHIR DiagnosticReport | `diagnosticReport-eu-core` |

#### Planned Migration to EU Scoped IGs

| IE Core Profile | Planned EU Parent | Pending Publication |
|----------------|------------------|-------------------|
| IE Core MedicationRequest (ePrescription) | `MedicationRequest-eu-mpd` | MPD STU |
| IE Core MedicationDispense (eDispensation) | `MedicationDispense-eu-mpd` | MPD STU |
| IE Core Medication (ePrescription) | `Medication-eu-mpd` | MPD STU |

---

### Cross-Border Interoperability (MyHealth@EU)

Ireland participates in the [MyHealth@EU](https://health.ec.europa.eu/ehealth-digital-health-and-care/electronic-cross-border-health-services_en) infrastructure. IE Core supports the following MyHealth@EU services:

| MyHealth@EU Service | IE Core Profiles | Status |
|--------------------|-----------------|--------|
| Patient Summary (Country A → Country B) | IECoreCompositionPatientSummary | Ready |
| ePrescription (Country A → Country B) | IECoreMedicationRequestEPrescription | Ready |
| eDispensation (Country B → Country A) | IECoreMedicationDispenseEDispensation | Ready |
| Laboratory Results | IECoreLaboratoryReport | Ready |
| Hospital Discharge Report | IECoreCompositionDischargeReport | Ready |
| Medical Images & Reports | IECoreDiagnosticReportNote | Partial |

**Cross-border ePrescription/eDispensation flow:**

```
  Ireland (Country A)                    EU Member State (Country B)
  ┌─────────────────┐                    ┌─────────────────────────┐
  │ Irish Prescriber │                    │ Foreign Pharmacy         │
  │ creates Rx using │──── MyHealth@EU ──→│ receives Rx via          │
  │ IE Core ePrescr. │    ePrescription   │ EU MPD / NCP-B           │
  └─────────────────┘                    └────────┬────────────────┘
                                                  │ Dispenses
  ┌─────────────────┐                    ┌────────▼────────────────┐
  │ Irish system     │                    │ Foreign Pharmacy         │
  │ receives eDisp.  │◄── MyHealth@EU ───│ sends eDispensation via  │
  │ via IE Core      │    eDispensation  │ EU MPD / NCP-A           │
  └─────────────────┘                    └─────────────────────────┘
```

For detailed worked examples covering 9 outbound destinations (Germany, Spain, France, Netherlands, Latvia, Portugal, Denmark, Sweden, Austria) and 2 inbound NePS scenarios (Finland → Ireland, Belgium → Ireland), see the [Cross-Border ePrescription](crossborder-eprescription.html) section. All FHIR bundles, CDA documents, and IPS samples are available on the [Sample Payloads & Downloads](crossborder-sample-payloads.html) page.

### EHDS Regulation Alignment

#### Primary Use (Care Delivery)

- **Patient Summary**: Structured IPS-compatible composition for unplanned and planned care
- **ePrescription/eDispensation**: Full lifecycle from prescription to dispensation with substitution tracking
- **Laboratory Results**: Structured lab reports with EU Lab IG alignment
- **Hospital Discharge**: Composition-based discharge summaries
- **Imaging**: Baseline support via DiagnosticReport; full ImagingStudy planned

#### Secondary Use (Research & Policy)

- **Standardized Coding**: SNOMED CT, LOINC, ATC, ICD-10 enable aggregation and research
- **Structured Data**: Machine-readable FHIR representation for health data reuse
- **Provenance**: IE Core Provenance profile tracks data origin and transformations

### Irish-Specific Extensions for Cross-Border

IE Core adds the following Ireland-specific elements on top of the EU profiles:

| Extension / Constraint | Applicable Profiles | Purpose |
|----------------------|-------------------|---------|
| IHI (Individual Health Identifier) | Patient | National patient identifier (18-digit) |
| HPI (Health Practitioner ID) | Practitioner | National practitioner identifier |
| GMS / DPS / LTI scheme numbers | Patient, MedicationRequest | Irish health scheme eligibility |
| PCRS claim reference | MedicationRequest (ePrescription) | Primary Care Reimbursement Service |
| Eircode | Patient, Organization, Location | Irish postal code system |
| Irish county ValueSet | Patient address | 26 Irish counties |
| Irish ethnicity CodeSystem | Patient | HSE ethnicity categories |
| IMC registration number | Practitioner | Irish Medical Council number |

These extensions ensure that cross-border systems can distinguish Irish-origin data and map identifiers appropriately.

### Future EU Alignment

As the EHDS ecosystem evolves towards the March 2027 implementing acts deadline, IE Core will:

1. **Re-parent to EU MPD** when `hl7.fhir.eu.mpd` is published as STU
2. **Re-parent to EU Core v2.0** for AllergyIntolerance, Condition, Procedure, Immunization, Medication, MedicationRequest, DiagnosticReport
3. **Adopt EU Patient Summary IG** when `hl7.fhir.eu.eps` matures
4. **Adopt EU Hospital Discharge IG** when `hl7.fhir.eu.hdr` is published
5. **Add Imaging profiles** when the EU Imaging IG is developed
6. **Support FHIR R5** following HL7 Europe's R5 timeline (R5 edition already in development)
7. **Implement EU Digital Identity Wallet** for cross-border patient authentication
