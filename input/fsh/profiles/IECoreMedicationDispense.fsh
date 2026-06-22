Profile: IECoreMedicationDispense
Parent: MedicationDispense
Id: ie-core-medicationdispense
Title: "IE Core MedicationDispense"
Description: "The IE Core MedicationDispense profile sets minimum expectations for the MedicationDispense resource to record, search, and fetch medication dispensing events associated with a patient, based on Irish requirements."

* ^url = "https://hl7-ie.github.io/ie-core-fhir-ig-draft/fhir/ie/core/StructureDefinition/ie-core-medicationdispense"
* ^version = "0.1.0"
* ^status = #draft

* status 1..1 MS
* medication[x] 1..1 MS
* medication[x] ^short = "Medication dispensed. Use NMPC as the primary coding where available, with SNOMED CT Irish Edition as a secondary coding where available."
* medication[x] from IECoreMedicationCodes (extensible)
* subject 1..1 MS
* subject only Reference(IECorePatient)
* context MS
* performer MS
* authorizingPrescription MS
* type MS
* quantity MS
* daysSupply MS
* whenHandedOver MS
* dosageInstruction MS
