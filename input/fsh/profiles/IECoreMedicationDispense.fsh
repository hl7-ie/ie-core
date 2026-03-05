Profile: IECoreMedicationDispense
Parent: MedicationDispense
Id: ie-core-medicationdispense
Title: "IE Core MedicationDispense"
Description: "The IE Core MedicationDispense profile sets minimum expectations for the MedicationDispense resource to record, search, and fetch medication dispensing events associated with a patient, based on Irish requirements."

* ^url = "http://hl7.hse.ie/fhir/ie/core/StructureDefinition/ie-core-medicationdispense"
* ^version = "0.1.0"
* ^status = #draft

* status 1..1 MS
* medication[x] 1..1 MS
* medication[x] from $IEBase/ValueSet/ie-core-medication-codes (extensible)
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
