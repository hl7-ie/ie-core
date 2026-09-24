Profile: IECoreCarePlan
Parent: CarePlan
Id: ie-core-careplan
Title: "IE Core CarePlan"
Description: "The IE Core CarePlan profile sets minimum expectations for the CarePlan resource to record, search, and fetch care plan data associated with a patient, based on Irish requirements."

* ^url = "https://hl7-ie.github.io/ie-core/fhir/ie/core/StructureDefinition/ie-core-careplan"
* ^status = #draft

* text MS
* text.status MS
* text.status from IECoreNarrativeStatus (required)
* status 1..1 MS
* intent 1..1 MS
* category 1..* MS
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains AssessPlan 1..1 MS
* category[AssessPlan] = https://hl7-ie.github.io/ie-core/fhir/ie/core/CodeSystem/ie-core-codesystem#assess-plan "Assessment and Plan of Treatment"
* subject 1..1 MS
* subject only Reference(IECorePatient)

// ── HIQA PS Section 18 Care Plan ───────────────────────────────────────
* title MS
* title ^comment = "HIQA PS 18.2.1 Name of care plan (Required)."
* description MS
* description ^comment = "HIQA PS 18.2.2 Description of the care plan (Required)."
* period ^comment = "HIQA PS 18.2.3 Care plan period (Optional)."
* addresses ^comment = "HIQA PS 18.2.4 Condition related to the care plan (Optional)."
* goal ^comment = "HIQA PS 18.2.6 Care plan goal (Optional)."
