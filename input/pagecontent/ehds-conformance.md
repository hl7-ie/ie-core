### EHDS & EU Conformance

The IE Core Implementation Guide is designed to ensure conformance with the European Health Data Space (EHDS) and enable cross-border interoperability across EU Member States.

### Layered Architecture

IE Core follows the layered FHIR profile architecture established by HL7 Europe:

```
┌─────────────────────────────────────────────┐
│         IE Core Profiles (Irish)            │  ← This IG
│  Irish identifiers, HSE schemes, Eircodes   │
├─────────────────────────────────────────────┤
│     HL7 Europe Core Profiles (EU)           │  ← hl7.fhir.eu.base
│  EHDS-aligned, cross-border constraints     │
├─────────────────────────────────────────────┤
│     HL7 Europe Base Profiles (EU)           │  ← hl7.fhir.eu.base
│  Loosely constrained European concepts      │
├─────────────────────────────────────────────┤
│  International Patient Summary (IPS)        │  ← hl7.fhir.uv.ips
│  Universal cross-border patient summary     │
├─────────────────────────────────────────────┤
│         FHIR R4 Base Resources              │
│  HL7 FHIR standard resource definitions    │
└─────────────────────────────────────────────┘
```

By deriving IE Core profiles from the HL7 Europe Core profiles, every IE Core resource instance is automatically:

1. **Conformant with EU Core** — meeting EHDS requirements
2. **Interoperable across borders** — compatible with other EU Member State IGs built on the same foundation
3. **IPS-compatible** — capable of contributing to International Patient Summary documents

### EU Dependencies

IE Core declares dependencies on the following EU/international packages:

| Package | Version | Purpose |
|---------|---------|---------|
| `hl7.fhir.eu.base` | 0.1.0 (STU 1.0) | HL7 Europe Base and Core profiles for EHDS |
| `hl7.fhir.uv.ips` | 1.1.0 (STU 1) | International Patient Summary |
| `hl7.fhir.uv.extensions.r4` | 5.1.0 | FHIR R4 extensions |

### Profile Derivation Map

#### Currently Derived from EU Core (v0.1.0)

The following IE Core profiles derive from HL7 Europe Core profiles available in `hl7.fhir.eu.base` version 0.1.0 (STU 1.0):

| IE Core Profile | Derives From (EU Core) | EU Profile ID |
|----------------|------------------------|---------------|
| [IE Core Patient](StructureDefinition-ie-core-patient.html) | Patient (EU core) | `patient-eu-core` |
| [IE Core Practitioner](StructureDefinition-ie-core-practitioner.html) | Practitioner (EU core) | `practitioner-eu-core` |
| [IE Core PractitionerRole](StructureDefinition-ie-core-practitionerrole.html) | PractitionerRole (EU core) | `practitionerRole-eu-core` |
| [IE Core Organization](StructureDefinition-ie-core-organization.html) | Organization (EU core) | `organization-eu-core` |
| [IE Core Location](StructureDefinition-ie-core-location.html) | Location (EU core) | `location-eu-core` |

#### Planned Migration to EU Core (v2.0.0)

The following IE Core profiles currently derive from base FHIR resources but will be re-parented to EU Core profiles once `hl7.fhir.eu.base` version 2.0.0 is published. The EU Core 2.0.0 is currently in development (reconciliation phase) and will introduce core profiles for these resource types:

| IE Core Profile | Current Parent | Planned EU Core Parent (v2.0.0) |
|----------------|---------------|-------------------------------|
| [IE Core AllergyIntolerance](StructureDefinition-ie-core-allergyintolerance.html) | FHIR AllergyIntolerance | `allergyIntolerance-eu-core` |
| [IE Core Condition (Encounter Dx)](StructureDefinition-ie-core-condition-encounter-diagnosis.html) | FHIR Condition | `condition-eu-core` |
| [IE Core Condition (Problems)](StructureDefinition-ie-core-condition-problems-health-concerns.html) | FHIR Condition | `condition-eu-core` |
| [IE Core Procedure](StructureDefinition-ie-core-procedure.html) | FHIR Procedure | `procedure-eu-core` |
| [IE Core Immunization](StructureDefinition-ie-core-immunization.html) | FHIR Immunization | `immunization-eu-core` |
| [IE Core Medication](StructureDefinition-ie-core-medication.html) | FHIR Medication | `medication-eu-core` |
| [IE Core MedicationRequest](StructureDefinition-ie-core-medicationrequest.html) | FHIR MedicationRequest | `medicationRequest-eu-core` |
| [IE Core DiagnosticReport (Lab)](StructureDefinition-ie-core-diagnosticreport-lab.html) | FHIR DiagnosticReport | `diagnosticReport-eu-core` |
| [IE Core DiagnosticReport (Note)](StructureDefinition-ie-core-diagnosticreport-note.html) | FHIR DiagnosticReport | `diagnosticReport-eu-core` |

#### No EU Core Equivalent

The following IE Core profiles do not have direct EU Core equivalents in any current or planned version and derive from base FHIR resources:

| IE Core Profile | Derives From | Notes |
|----------------|-------------|-------|
| IE Core CarePlan | FHIR CarePlan | No EU Core profile planned |
| IE Core CareTeam | FHIR CareTeam | No EU Core profile planned |
| IE Core Coverage | FHIR Coverage | No EU Core profile planned |
| IE Core Goal | FHIR Goal | No EU Core profile planned |
| IE Core ServiceRequest | FHIR ServiceRequest | No EU Core profile planned |
| IE Core Provenance | FHIR Provenance | No EU Core profile planned |
| IE Core Specimen | FHIR Specimen | No EU Core profile planned |
| IE Core RelatedPerson | FHIR RelatedPerson | No EU Core profile planned |
| IE Core Vital Signs | FHIR vitalsigns | Derives from FHIR vital signs base profile |
| IE Core DocumentReference | FHIR DocumentReference | No EU Core profile planned |
| IE Core QuestionnaireResponse | FHIR QuestionnaireResponse | No EU Core profile planned |
| IE Core MedicationDispense | FHIR MedicationDispense | `medicationStatement-eu-core` may apply in future |
| IE Core Implantable Device | FHIR Device | No EU Core profile planned |

As HL7 Europe publishes additional Core profiles, IE Core will update its derivation hierarchy to maintain alignment.

### EHDS Regulation Alignment

The [EHDS Regulation](https://health.ec.europa.eu/ehealth-digital-health-and-care/european-health-data-space_en) establishes a framework for the primary and secondary use of health data across the EU. IE Core supports EHDS through:

#### Primary Use (Care Delivery)

- **Patient Summary**: IE Core Patient, Condition, AllergyIntolerance, Medication, and Immunization profiles align with the European Patient Summary requirements
- **ePrescription/eDispensation**: IE Core MedicationRequest and MedicationDispense profiles support electronic prescribing and dispensing
- **Laboratory Results**: IE Core DiagnosticReport and Observation Lab profiles support laboratory result exchange
- **Hospital Discharge Reports**: IE Core Encounter, Condition, and Procedure profiles capture discharge information

#### Secondary Use (Research & Policy)

- **Standardized Coding**: Use of SNOMED CT, LOINC, ATC, and ICD-10 enables data aggregation
- **Structured Data**: FHIR-based representation enables machine-readable health data for research
- **Provenance**: IE Core Provenance profile tracks data origin and transformations

### Cross-Border Interoperability (MyHealth@EU)

Ireland participates in the [MyHealth@EU](https://health.ec.europa.eu/ehealth-digital-health-and-care/electronic-cross-border-health-services_en) infrastructure for cross-border health data exchange. IE Core supports this through:

1. **IPS Generation**: IE Core profiles can generate valid International Patient Summary documents
2. **EU Core Conformance**: All EU Core constraints are inherited, ensuring compatibility
3. **Standard Terminologies**: SNOMED CT, LOINC, and ATC are used as required by MyHealth@EU
4. **Identifier Mapping**: Irish identifiers (IHI, HPI) can be mapped to EU-wide identifier systems

### Xt-EHR Alignment

The IE Core profiles are aligned with the [Xt-EHR](https://xt-ehr.eu/) common logical model, which provides the conceptual foundation for EHDS implementing acts. The HL7 Europe Core profiles that IE Core derives from realize the Xt-EHR logical models in FHIR.

### Future EU Alignment

As the EU EHDS ecosystem evolves, IE Core will:

1. **Track EU Core updates**: Re-base on newer versions of `hl7.fhir.eu.base` as they are published
2. **Adopt new EU scoped IGs**: Align with EU-level IGs for Patient Summary, Laboratory, Hospital Discharge, and ePrescription as they mature
3. **Support FHIR R5 migration**: Follow HL7 Europe's timeline for R5 adoption
4. **Implement EU Digital Identity Wallet**: Support the EU Digital Identity framework for patient authentication in cross-border scenarios
