Profile: IECoreMedicationRequest
Parent: MedicationRequest
Id: ie-core-medicationrequest
Title: "IE Core MedicationRequest"
Description: "The IE Core MedicationRequest profile sets minimum expectations for the MedicationRequest resource to record, search, and fetch prescriptions associated with a patient, based on Irish requirements."

* ^url = "http://hl7.hse.ie/fhir/ie/core/StructureDefinition/ie-core-medicationrequest"
* ^version = "0.1.0"
* ^status = #draft

* status 1..1 MS
* intent 1..1 MS
* reported[x] MS
* medication[x] 1..1 MS
* medication[x] from IECoreMedicationCodes (extensible)
* subject 1..1 MS
* subject only Reference(IECorePatient)
* encounter MS
* authoredOn MS
* requester MS
* dosageInstruction MS
* dosageInstruction.text MS
* dispenseRequest MS
