Profile: IECoreImmunization
Parent: Immunization
Id: ie-core-immunization
Title: "IE Core Immunization"
Description: "The IE Core Immunization profile sets minimum expectations for the Immunization resource to record, search, and fetch immunization history associated with a patient, based on Irish requirements."

* ^url = "http://hl7.hse.ie/fhir/ie/core/StructureDefinition/ie-core-immunization"
* ^version = "0.1.0"
* ^status = #draft

* status 1..1 MS
* statusReason MS
* vaccineCode 1..1 MS
* vaccineCode from $IEBase/ValueSet/ie-core-vaccines (extensible)
* patient 1..1 MS
* patient only Reference(IECorePatient)
* occurrence[x] 1..1 MS
* primarySource MS
