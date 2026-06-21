Profile: IECoreMedication
Parent: Medication
Id: ie-core-medication
Title: "IE Core Medication"
Description: "The IE Core Medication profile sets minimum expectations for the Medication resource to record, search, and fetch medications associated with a patient, based on Irish requirements."

* ^url = "https://hl7-ie.github.io/fhir/ie/core/StructureDefinition/ie-core-medication"
* ^version = "0.1.0"
* ^status = #draft

* code MS
* code ^short = "Medication code. Use NMPC as the primary coding where available, with SNOMED CT Irish Edition as a secondary coding where available."
* code from IECoreMedicationCodes (extensible)
* form MS
* ingredient MS
