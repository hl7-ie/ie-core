Profile: IECoreRelatedPerson
Parent: RelatedPerson
Id: ie-core-relatedperson
Title: "IE Core RelatedPerson"
Description: "The IE Core RelatedPerson profile sets minimum expectations for the RelatedPerson resource to record, search, and fetch related person data associated with a patient, based on Irish requirements."

* ^url = "https://hl7-ie.github.io/fhir/ie/core/StructureDefinition/ie-core-relatedperson"
* ^version = "0.1.0"
* ^status = #draft

* active MS
* patient 1..1 MS
* patient only Reference(IECorePatient)
* relationship MS
* name 1..* MS
