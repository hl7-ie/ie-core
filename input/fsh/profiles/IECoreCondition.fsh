Profile: IECoreConditionEncounterDiagnosis
Parent: Condition
Id: ie-core-condition-encounter-diagnosis
Title: "IE Core Condition Encounter Diagnosis"
Description: "The IE Core Condition Encounter Diagnosis profile sets minimum expectations for the Condition resource to record, search, and fetch encounter diagnosis data associated with a patient, based on Irish requirements."

* ^url = "https://hl7-ie.github.io/ie-core/fhir/ie/core/StructureDefinition/ie-core-condition-encounter-diagnosis"
* ^version = "0.1.0"
* ^status = #draft

* clinicalStatus MS
* verificationStatus MS
* category 1..* MS
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains EncounterDiagnosis 1..1 MS
* category[EncounterDiagnosis] = $CondCat#encounter-diagnosis "Encounter Diagnosis"
* code 1..1 MS
* code from IECoreConditionCode (extensible)
* subject 1..1 MS
* subject only Reference(IECorePatient)
* onset[x] MS
* abatement[x] MS
* recordedDate MS


Profile: IECoreConditionProblemsHealthConcerns
Parent: Condition
Id: ie-core-condition-problems-health-concerns
Title: "IE Core Condition Problems and Health Concerns"
Description: "The IE Core Condition Problems and Health Concerns profile sets minimum expectations for the Condition resource to record, search, and fetch problems and health concerns associated with a patient, based on Irish requirements."

* ^url = "https://hl7-ie.github.io/ie-core/fhir/ie/core/StructureDefinition/ie-core-condition-problems-health-concerns"
* ^version = "0.1.0"
* ^status = #draft

* clinicalStatus MS
* verificationStatus MS
* category 1..* MS
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains
    ProblemListItem 0..1 MS and
    HealthConcern 0..1 MS
* category[ProblemListItem] = $CondCat#problem-list-item "Problem List Item"
* category[HealthConcern] = $CondCat#health-concern "Health Concern"
* code 1..1 MS
* code from IECoreConditionCode (extensible)
* subject 1..1 MS
* subject only Reference(IECorePatient)
* onset[x] MS
* abatement[x] MS
* recordedDate MS

// ── HIQA PS Section 7 Health Conditions (IECoreConditionProblemsHealthConcerns) ─
* obeys ie-cond-1
* severity MS
* severity ^comment = "HIQA PS 7.3.7 Severity (Required)."
* bodySite MS
* bodySite ^comment = "HIQA PS 7.3.8 Anatomical location (Required)."
* stage.summary MS
* stage.summary ^comment = "HIQA PS 7.3.9 Clinical stage/grade (Required)."
* evidence.detail MS
* evidence.detail ^comment = "HIQA PS 7.3.13 Attachment (Required), e.g. a DocumentReference."
* note ^comment = "HIQA PS 7.4 Note (Optional)."

Invariant: ie-cond-1
Description: "A health condition SHALL have a clinical status unless it was entered in error (HIQA PS 7.3.2 Health condition status, Mandatory; FHIR con-5 forbids clinicalStatus when entered-in-error)"
Expression: "verificationStatus.coding.where(code = 'entered-in-error').exists() or clinicalStatus.exists()"
Severity: #error
