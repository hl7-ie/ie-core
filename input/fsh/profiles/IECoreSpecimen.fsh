Profile: IECoreSpecimen
Parent: Specimen
Id: ie-core-specimen
Title: "IE Core Specimen"
Description: "The IE Core Specimen profile sets minimum expectations for the Specimen resource to record, search, and fetch specimens associated with a patient, based on Irish requirements."

* ^url = "https://hl7-ie.github.io/ie-core-fhir-ig-draft/fhir/ie/core/StructureDefinition/ie-core-specimen"
* ^version = "0.1.0"
* ^status = #draft

* identifier MS
* type MS
* type from IECoreSpecimenType (extensible)
* subject MS
* subject only Reference(IECorePatient)
* collection MS
* condition MS
