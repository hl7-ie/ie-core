Profile: IECoreServiceRequest
Parent: ServiceRequest
Id: ie-core-servicerequest
Title: "IE Core ServiceRequest"
Description: "The IE Core ServiceRequest profile sets minimum expectations for the ServiceRequest resource to record, search, and fetch service request data associated with a patient, based on Irish requirements."

* ^url = "https://hl7-ie.github.io/ie-core/fhir/ie/core/StructureDefinition/ie-core-servicerequest"
* ^version = "0.1.0"
* ^status = #draft

* status 1..1 MS
* intent 1..1 MS
* category MS
* code 1..1 MS
* code from IECoreProcedureCode (extensible)
* subject 1..1 MS
* subject only Reference(IECorePatient)
* occurrence[x] MS
* authoredOn MS
* requester MS
* requester only Reference(IECorePractitioner or IECorePractitionerRole or IECoreOrganization or IECorePatient or IECoreRelatedPerson or Device)
