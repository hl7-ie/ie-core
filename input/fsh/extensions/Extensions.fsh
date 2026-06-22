// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Extensions                                                 │
// ╰──────────────────────────────────────────────────────────────────────╯

// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Ethnicity                                                  │
// ╰──────────────────────────────────────────────────────────────────────╯

Extension: IECoreEthnicity
Id: ie-core-ethnicity
Title: "IE Core Ethnicity"
Description: "Records a patient's ethnicity as categorised within the Irish healthcare system, aligned with the Central Statistics Office (CSO) classifications."
Context: Patient
* value[x] only code
* value[x] 1..1
* valueCode from https://hl7-ie.github.io/ie-core-fhir-ig-draft/fhir/ie/core/ValueSet/ie-core-ethnicity (required)

// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Patient Mother Maiden Name                                 │
// ╰──────────────────────────────────────────────────────────────────────╯

Extension: IECorePatientMotherMaidenName
Id: ie-core-patient-mother-maiden-name
Title: "IE Core Patient Mother Maiden Name"
Description: "Records the mother's maiden (birth family) name for the patient."
Context: Patient
* value[x] only string
* value[x] 1..1

// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Gender Identity                                            │
// ╰──────────────────────────────────────────────────────────────────────╯

Extension: IECoreGenderIdentity
Id: ie-core-genderIdentity
Title: "IE Core Gender Identity"
Description: "Records the patient's gender identity as understood within the Irish healthcare system."
Context: Patient
* value[x] only CodeableConcept
* value[x] 1..1
* valueCodeableConcept from https://hl7-ie.github.io/ie-core-fhir-ig-draft/fhir/ie/core/ValueSet/ie-core-gender-identity (extensible)

// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Interpreter Required                                       │
// ╰──────────────────────────────────────────────────────────────────────╯

Extension: IECoreInterpreterRequired
Id: ie-core-interpreter-required
Title: "IE Core Interpreter Required"
Description: "Indicates whether the patient requires an interpreter for communication within the Irish healthcare system."
Context: Patient, Encounter
* value[x] only Coding
* value[x] 1..1
* valueCoding from https://hl7-ie.github.io/ie-core-fhir-ig-draft/fhir/ie/core/ValueSet/ie-core-yes-no-unknown (required)

// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core IHI Status                                                 │
// ╰──────────────────────────────────────────────────────────────────────╯

Extension: IECoreIHIStatus
Id: ie-core-ihi-status
Title: "IE Core IHI Status"
Description: "Records the current status of an Individual Health Identifier (IHI), such as active, deceased, or retired."
Context: Identifier
* value[x] only code
* value[x] 1..1
* valueCode from https://hl7-ie.github.io/ie-core-fhir-ig-draft/fhir/ie/core/ValueSet/ie-core-ihi-status (required)

// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core IHI Record Status                                          │
// ╰──────────────────────────────────────────────────────────────────────╯

Extension: IECoreIHIRecordStatus
Id: ie-core-ihi-record-status
Title: "IE Core IHI Record Status"
Description: "Records the record-level status of an Individual Health Identifier (IHI), such as verified, unverified, or provisional."
Context: Identifier
* value[x] only code
* value[x] 1..1
* valueCode from https://hl7-ie.github.io/ie-core-fhir-ig-draft/fhir/ie/core/ValueSet/ie-core-ihi-record-status (required)

// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core IHI Verification Date                                      │
// ╰──────────────────────────────────────────────────────────────────────╯

Extension: IECoreIHIVerifiedDate
Id: ie-core-ihi-verified-date
Title: "IE Core IHI Verification Date"
Description: "Records the date on which the Individual Health Identifier (IHI) was last verified."
Context: Identifier
* value[x] only date
* value[x] 1..1

// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Medication Adherence                                       │
// ╰──────────────────────────────────────────────────────────────────────╯

Extension: IECoreMedicationAdherence
Id: ie-core-medication-adherence
Title: "IE Core Medication Adherence"
Description: "Records medication adherence information including the adherence status and the source of that information."
Context: MedicationRequest
* extension contains
    adherence 1..1 and
    informationSource 0..1
* extension[adherence] ^short = "Adherence status"
* extension[adherence].value[x] only CodeableConcept
* extension[adherence].value[x] 1..1
* extension[adherence].valueCodeableConcept from https://hl7-ie.github.io/ie-core-fhir-ig-draft/fhir/ie/core/ValueSet/ie-core-medication-adherence (extensible)
* extension[informationSource] ^short = "Source of adherence information"
* extension[informationSource].value[x] only CodeableConcept
* extension[informationSource].value[x] 1..1
* extension[informationSource].valueCodeableConcept from https://hl7-ie.github.io/ie-core-fhir-ig-draft/fhir/ie/core/ValueSet/ie-core-information-source (extensible)
* value[x] 0..0

// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Authentication Time                                        │
// ╰──────────────────────────────────────────────────────────────────────╯

Extension: IECoreAuthenticationTime
Id: ie-core-authentication-time
Title: "IE Core Authentication Time"
Description: "Records the time at which a Provenance event was authenticated."
Context: Provenance
* value[x] only instant
* value[x] 1..1

// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Extension Questionnaire URI                                │
// ╰──────────────────────────────────────────────────────────────────────╯

Extension: IECoreExtensionQuestionnaireUri
Id: ie-core-extension-questionnaire-uri
Title: "IE Core Extension Questionnaire URI"
Description: "Records the canonical URI of the Questionnaire associated with a QuestionnaireResponse."
Context: QuestionnaireResponse
* value[x] only uri
* value[x] 1..1

// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Direct Email                                               │
// ╰──────────────────────────────────────────────────────────────────────╯

Extension: IECoreDirect
Id: ie-core-direct
Title: "IE Core Direct Email"
Description: "Records a Direct secure messaging address for the individual or organisation."
Context: Patient, Practitioner, PractitionerRole, Organization
* value[x] only string
* value[x] 1..1

// ╭──────────────────────────────────────────────────────────────────────╮
// │  IECDI Requirement                                                  │
// ╰──────────────────────────────────────────────────────────────────────╯

Extension: IECDIRequirement
Id: iecdi-requirement
Title: "IECDI Requirement"
Description: "Marks an element as a requirement for the Irish Clinical Data Integration (IECDI) programme."
Context: ElementDefinition
* value[x] only boolean
* value[x] 1..1
