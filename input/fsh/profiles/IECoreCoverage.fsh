Profile: IECoreCoverage
Parent: Coverage
Id: ie-core-coverage
Title: "IE Core Coverage"
Description: "The IE Core Coverage profile sets minimum expectations for the Coverage resource to record, search, and fetch insurance or medical scheme coverage associated with a patient, based on Irish requirements."

* ^url = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-coverage"
* ^version = "0.1.0"
* ^status = #draft

* status 1..1 MS
* type 1..1 MS
* type from IECorePayerType (extensible)
* subscriberId 1..1 MS
* beneficiary 1..1 MS
* beneficiary only Reference(IECorePatient)
* relationship 1..1 MS
* period MS
* payor 1..* MS
* class MS
