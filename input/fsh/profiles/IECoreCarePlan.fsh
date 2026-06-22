Profile: IECoreCarePlan
Parent: CarePlan
Id: ie-core-careplan
Title: "IE Core CarePlan"
Description: "The IE Core CarePlan profile sets minimum expectations for the CarePlan resource to record, search, and fetch care plan data associated with a patient, based on Irish requirements."

* ^url = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-careplan"
* ^version = "0.1.0"
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
* category[AssessPlan] = https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/CodeSystem/ie-core-codesystem#assess-plan "Assessment and Plan of Treatment"
* subject 1..1 MS
* subject only Reference(IECorePatient)
