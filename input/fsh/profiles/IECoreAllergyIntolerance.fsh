Profile: IECoreAllergyIntolerance
Parent: AllergyIntolerance
Id: ie-core-allergyintolerance
Title: "IE Core AllergyIntolerance"
Description: "The IE Core AllergyIntolerance profile sets minimum expectations for the AllergyIntolerance resource to record, search, and fetch allergy and intolerance data associated with a patient, based on Irish requirements."

* ^url = "https://hl7-ie.github.io/fhir/ie/core/StructureDefinition/ie-core-allergyintolerance"
* ^version = "0.1.0"
* ^status = #draft

* clinicalStatus 1..1 MS
* verificationStatus MS
* category MS
* code 1..1 MS
* code from IECoreAllergyIntoleranceSet (extensible)
* patient 1..1 MS
* patient only Reference(IECorePatient)
* onset[x] MS
* reaction MS
* reaction.manifestation MS
* reaction.severity MS
