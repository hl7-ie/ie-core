### Introduction

**⚠️ Important Notice:** This Implementation Guide is built as a Proof of Concept by Nithin Mohan. It has no support from the HSE, HSE Standards team, or the Department of Health. In future, this may be handed over to a governing body within Ireland for maintaining this implementation guide. This IG is the author's proof of concept to demonstrate how FHIR adoption should be implemented at the national level. It is built with the author's experiences working in HL7 V2, V3 CDA, and FHIR, and a curiosity to solve problems for EHDS cross-border healthcare from the context of Ireland's healthcare landscape.

The IE Core Implementation Guide, based on [FHIR Version R4](http://hl7.org/fhir/R4/), defines the minimum constraints on FHIR resources to create the IE Core Profiles. It identifies necessary elements, extensions, vocabularies, and value sets, and details their usage. It also documents the minimum FHIR RESTful interactions required for each IE Core Profile to access patient data. Establishing this "floor" of standards promotes interoperability and adoption through common implementation, allowing for further standards development for specific use cases.

### EU EHDS Alignment

IE Core profiles are built on top of the [HL7 Europe Base and Core FHIR profiles](https://hl7.eu/fhir/base), ensuring conformance with the [European Health Data Space (EHDS)](https://health.ec.europa.eu/ehealth-digital-health-and-care/european-health-data-space_en) regulation. This layered approach means that every IE Core resource instance automatically satisfies EU Core constraints and is interoperable with other EU Member State implementations. The profiles also align with the [International Patient Summary (IPS)](https://hl7.org/fhir/uv/ips/) standard for cross-border care scenarios via [MyHealth@EU](https://health.ec.europa.eu/ehealth-digital-health-and-care/electronic-cross-border-health-services_en).

IE Core v0.1.1 is aligned with the **XT-EHR logical model v1.0.0**, which introduced a formal Obligations Framework, new base models (`EHDSDocument`, `EHDSDataSet`), mandatory section updates to the Patient Summary and Hospital Discharge Report, and additional ePrescription elements. See the [EHDS & EU Conformance](ehds-conformance.html) page for the full alignment matrix and FHIR R4/R5 compatibility analysis.

There are two ways to implement IE Core:

1. **Profile Only Support**: Systems may support *only* the IE Core Profiles to represent clinical information.
2. **Profile Support + Interaction Support**: Systems may support *both* the IE Core Profile content structure *and* the RESTful interactions defined for a resource.

For a detailed description of these different usages of IE Core, see the [Conformance Requirements](conformance.html) page.

### IE Core Actors

The following actors are part of the IE Core IG:

#### IE Core Requestor

An IE Core Requestor is an application that initiates a data access request to retrieve patient data. The IE Core Requestor is the client in a client-server interaction. The terms "IE Core Requestor" and "Client" are used interchangeably throughout this guide and are not meant to limit this actor to only patient and provider apps. For example, payers and other users can use the same technology.

#### IE Core Responder

An IE Core Responder is a system that responds to the data access request providing patient data. The IE Core Responder is the server in a client-server interaction. The terms "IE Core Responder", "Server", and "EHR" are used interchangeably throughout this guide and are not meant to limit this actor to electronic health record systems. For example, HIEs, care coordination platforms, population health systems, etc., can use the same technology.

### IE Core Profiles

Below is the list of IE Core Profiles. Each profile identifies which core elements, extensions, vocabularies, and ValueSets **SHALL** be present in the resource when using this profile. Together, they promote interoperability and adoption through common implementation and provide the floor for standards development for specific use cases.

#### Patient Demographics

| Profile | Description |
|---------|-------------|
| [IE Core Patient](StructureDefinition-ie-core-patient.html) | Demographics and identifiers for patients in the Irish health system |
| [IE Core RelatedPerson](StructureDefinition-ie-core-relatedperson.html) | Related persons (family, carers) associated with a patient |

#### Provider & Organization

| Profile | Description |
|---------|-------------|
| [IE Core Practitioner](StructureDefinition-ie-core-practitioner.html) | Healthcare practitioners with Irish identifiers (IMC, HPI) |
| [IE Core PractitionerRole](StructureDefinition-ie-core-practitionerrole.html) | Roles practitioners perform at organizations |
| [IE Core Organization](StructureDefinition-ie-core-organization.html) | Healthcare organizations in Ireland |
| [IE Core Location](StructureDefinition-ie-core-location.html) | Physical locations where care is delivered |

#### Clinical

| Profile | Description |
|---------|-------------|
| [IE Core AllergyIntolerance](StructureDefinition-ie-core-allergyintolerance.html) | Allergy and intolerance records |
| [IE Core Condition Encounter Diagnosis](StructureDefinition-ie-core-condition-encounter-diagnosis.html) | Diagnoses made during encounters |
| [IE Core Condition Problems and Health Concerns](StructureDefinition-ie-core-condition-problems-health-concerns.html) | Problem list and health concerns |
| [IE Core Procedure](StructureDefinition-ie-core-procedure.html) | Clinical procedures performed |
| [IE Core CarePlan](StructureDefinition-ie-core-careplan.html) | Care plans for patient management |
| [IE Core CareTeam](StructureDefinition-ie-core-careteam.html) | Care teams involved in patient care |
| [IE Core Goal](StructureDefinition-ie-core-goal.html) | Clinical goals for patients |
| [IE Core ServiceRequest](StructureDefinition-ie-core-servicerequest.html) | Requests for clinical services |
| [IE Core Encounter](StructureDefinition-ie-core-encounter.html) | Healthcare encounters and visits |
| [IE Core Flag (Alert)](StructureDefinition-ie-core-flag.html) | Substantial medical alerts — maps to EHDSAlert (XT-EHR 1.0.0) *(Draft)* |

#### Medication

| Profile | Description |
|---------|-------------|
| [IE Core Medication](StructureDefinition-ie-core-medication.html) | Medication definitions |
| [IE Core MedicationRequest](StructureDefinition-ie-core-medicationrequest.html) | Prescriptions and medication orders |
| [IE Core MedicationDispense](StructureDefinition-ie-core-medicationdispense.html) | Medication dispensing records |
| [IE Core MedicationStatement](StructureDefinition-ie-core-medicationstatement.html) | Medication use statements — maps to EHDSMedicationUse (XT-EHR 1.0.0) *(Draft)* |
| [IE Core Immunization](StructureDefinition-ie-core-immunization.html) | Immunization administration records |

#### Diagnostics & Observations

| Profile | Description |
|---------|-------------|
| [IE Core DiagnosticReport for Lab](StructureDefinition-ie-core-diagnosticreport-lab.html) | Laboratory diagnostic reports |
| [IE Core DiagnosticReport for Notes](StructureDefinition-ie-core-diagnosticreport-note.html) | Clinical report and note exchange |
| [IE Core Observation Clinical Result](StructureDefinition-ie-core-observation-clinical-result.html) | General clinical result observations |
| [IE Core Laboratory Result Observation](StructureDefinition-ie-core-observation-lab.html) | Laboratory test results |
| [IE Core Simple Observation](StructureDefinition-ie-core-simple-observation.html) | Simple clinical observations |
| [IE Core Specimen](StructureDefinition-ie-core-specimen.html) | Specimen information for lab testing |

#### Vital Signs

| Profile | Description |
|---------|-------------|
| [IE Core Vital Signs](StructureDefinition-ie-core-vital-signs.html) | Base vital signs profile |
| [IE Core Blood Pressure](StructureDefinition-ie-core-blood-pressure.html) | Blood pressure measurements |
| [IE Core BMI](StructureDefinition-ie-core-bmi.html) | Body Mass Index |
| [IE Core Body Height](StructureDefinition-ie-core-body-height.html) | Body height measurements |
| [IE Core Body Weight](StructureDefinition-ie-core-body-weight.html) | Body weight measurements |
| [IE Core Body Temperature](StructureDefinition-ie-core-body-temperature.html) | Body temperature measurements |
| [IE Core Head Circumference](StructureDefinition-ie-core-head-circumference.html) | Head circumference measurements |
| [IE Core Heart Rate](StructureDefinition-ie-core-heart-rate.html) | Heart rate measurements |
| [IE Core Respiratory Rate](StructureDefinition-ie-core-respiratory-rate.html) | Respiratory rate measurements |
| [IE Core Pulse Oximetry](StructureDefinition-ie-core-pulse-oximetry.html) | Pulse oximetry readings |

#### Documents & Provenance

| Profile | Description |
|---------|-------------|
| [IE Core DocumentReference](StructureDefinition-ie-core-documentreference.html) | Clinical document references |
| [IE Core ADI DocumentReference](StructureDefinition-ie-core-adi-documentreference.html) | Advance Directive documents |
| [IE Core Provenance](StructureDefinition-ie-core-provenance.html) | Data provenance tracking |
| [IE Core QuestionnaireResponse](StructureDefinition-ie-core-questionnaireresponse.html) | Questionnaire response data |

#### Financial & Device

| Profile | Description |
|---------|-------------|
| [IE Core Coverage](StructureDefinition-ie-core-coverage.html) | Insurance and coverage information |
| [IE Core Implantable Device](StructureDefinition-ie-core-implantable-device.html) | Implantable medical devices |

### IE Core Identifier Profiles

The following identifier profiles define the structure for Irish healthcare identifiers:

| Identifier | Description |
|------------|-------------|
| [Individual Healthcare Identifier (IHI)](StructureDefinition-ie-core-individual-healthcare-identifier.html) | National patient identifier |
| [Health Service Provider Identifier (HPI)](StructureDefinition-ie-core-health-service-provider-identifier.html) | Provider identifier |
| [Irish Medical Council (IMC)](StructureDefinition-ie-core-irish-medical-council.html) | Medical council registration |
| [Medical Record Number (MRN)](StructureDefinition-ie-core-medical-record-number.html) | Local medical record number |
| [General Medical Service (GMS)](StructureDefinition-ie-core-general-medical-service.html) | GMS scheme number |
| [Drugs Payment Scheme (DPS)](StructureDefinition-ie-core-drugs-payment-scheme.html) | DPS scheme number |
| [Long Term Illness (LTI)](StructureDefinition-ie-core-long-term-illness.html) | LTI scheme number |
| [Health Amendment Act (HAA)](StructureDefinition-ie-core-health-amendment-act.html) | HAA scheme number |
| [Insurance Member Number (IMN)](StructureDefinition-ie-core-insurance-member-number.html) | Private insurance member number |
| [Company Registration Number (CRN)](StructureDefinition-ie-core-company-registration-number.html) | Organization CRO number |

### IE Core FHIR RESTful Interactions

For systems that support the IE Core Profile content structure and the RESTful interactions defined for a resource, the requirements are formally defined in the [IE Core Server CapabilityStatement](CapabilityStatement-ie-core-server.html) and [IE Core Client CapabilityStatement](CapabilityStatement-ie-core-client.html).

Each profile page has a *Quick Start* section that documents the required FHIR RESTful search and read operations. See the [FHIR specification](http://hl7.org/fhir/R4/http.html) for details on FHIR RESTful Search API and the [SMART App Launch](http://hl7.org/fhir/smart-app-launch/) for how an application gets access to a patient record.

### License

HL7&reg; is a registered trademark of Health Level Seven (HL7), Inc.

FHIR&reg; is a registered trademark of HL7.

SNOMED&reg; is a registered trademark of the International Health Terminology Standards Development Organisation.

LOINC&reg; is a registered trademark of Regenstrief Institute, Inc.

This Implementation Guide is licensed under [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/).
