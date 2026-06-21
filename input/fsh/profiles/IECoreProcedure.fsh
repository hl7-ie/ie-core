Profile: IECoreProcedure
Parent: Procedure
Id: ie-core-procedure
Title: "IE Core Procedure"
Description: "The IE Core Procedure profile sets minimum expectations for the Procedure resource to record, search, and fetch procedure data associated with a patient, based on Irish requirements."

* ^url = "https://hl7-ie.github.io/hl7-ie-fhir-draft-ig/fhir/ie/core/StructureDefinition/ie-core-procedure"
* ^version = "0.1.0"
* ^status = #draft

* status 1..1 MS
* code 1..1 MS
* code from IECoreProcedureCode (extensible)
* subject 1..1 MS
* subject only Reference(IECorePatient)
* performed[x] 1..1 MS
* encounter MS
