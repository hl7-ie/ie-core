// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core ePrescription Profiles                                    │
// │  Aligned with: HL7 Europe MPD IG, Xt-EHR EHDSMedicationPrescription│
// ╰──────────────────────────────────────────────────────────────────────╯

Profile: IECoreMedicationRequestEPrescription
Parent: IECoreMedicationRequest
Id: ie-core-medicationrequest-eprescription
Title: "IE Core MedicationRequest (ePrescription)"
Description: "Profile for electronic prescriptions in the Irish healthcare system, aligned with the HL7 Europe Medication Prescription and Dispense (MPD) IG and the Xt-EHR EHDSMedicationPrescription logical model. This profile extends the base IE Core MedicationRequest with constraints required for cross-border ePrescription exchange via MyHealth@EU."

* ^status = #draft

* identifier 1..* MS
* identifier ^short = "Prescription line identifier"
* identifier ^definition = "Unique identifier for this prescription item. In Ireland, this maps to the PCRS claim reference or the ePrescription reference number."

* status MS
* intent MS
* intent = #order

* category 0..* MS
* category ^short = "Prescription category (e.g. community, hospital, controlled drug)"

* priority MS

* medication[x] 1..1 MS
* subject 1..1 MS

* requester 1..1 MS
* requester only Reference(IECorePractitioner or IECorePractitionerRole or IECoreOrganization)
* requester ^short = "Prescriber — the health professional who authored the prescription"

* authoredOn 1..1 MS
* authoredOn ^short = "Date the prescription was written"

* reasonCode MS
* reasonCode ^short = "Clinical reason for the prescription"

* dosageInstruction 1..* MS
* dosageInstruction.text 1..1 MS
* dosageInstruction.text ^short = "Human-readable dosage instructions"
* dosageInstruction.timing MS
* dosageInstruction.route MS
* dosageInstruction.doseAndRate MS

* dispenseRequest MS
* dispenseRequest.validityPeriod MS
* dispenseRequest.validityPeriod ^short = "Period during which the prescription can be dispensed"
* dispenseRequest.numberOfRepeatsAllowed MS
* dispenseRequest.numberOfRepeatsAllowed ^short = "Number of refills allowed"
* dispenseRequest.quantity MS
* dispenseRequest.expectedSupplyDuration MS

* substitution MS
* substitution.allowed[x] MS
* substitution.allowed[x] ^short = "Whether substitution is allowed under Irish pharmacy regulations"

* groupIdentifier MS
* groupIdentifier ^short = "Links multiple prescription items on the same prescription"


Profile: IECoreMedicationDispenseEDispensation
Parent: IECoreMedicationDispense
Id: ie-core-medicationdispense-edispensation
Title: "IE Core MedicationDispense (eDispensation)"
Description: "Profile for electronic dispensation records in the Irish healthcare system, aligned with the HL7 Europe MPD IG and the Xt-EHR EHDSMedicationDispense logical model. This profile extends the base IE Core MedicationDispense with constraints for cross-border eDispensation exchange."

* ^status = #draft

* identifier 1..* MS
* identifier ^short = "Dispensation record identifier"

* status MS

* medication[x] 1..1 MS
* subject 1..1 MS

* performer 1..* MS
* performer.actor MS
* performer.actor only Reference(IECorePractitioner or IECorePractitionerRole or IECoreOrganization)
* performer ^short = "Dispensing pharmacist and pharmacy"

* authorizingPrescription 1..* MS
* authorizingPrescription only Reference(IECoreMedicationRequest or IECoreMedicationRequestEPrescription)
* authorizingPrescription ^short = "Reference to the original prescription being dispensed"

* quantity 1..1 MS
* quantity ^short = "Quantity dispensed"

* daysSupply MS
* whenPrepared MS
* whenHandedOver MS
* whenHandedOver ^short = "Date/time the medication was handed to the patient"

* substitution MS
* substitution.wasSubstituted MS
* substitution.wasSubstituted ^short = "Whether a substitution was made during dispensing"
* substitution.type MS
* substitution.reason MS

* dosageInstruction MS
* dosageInstruction.text MS


Profile: IECoreMedicationEPrescription
Parent: IECoreMedication
Id: ie-core-medication-eprescription
Title: "IE Core Medication (ePrescription/eDispensation)"
Description: "Medication profile for use in ePrescription and eDispensation, aligned with the HL7 Europe MPD Medication profile and the Xt-EHR EHDSMedication logical model. Supports both generic/virtual products and branded/packaged products as required by Irish pharmacy practice and EU cross-border exchange."

* ^status = #draft

* code 1..1 MS
* code ^short = "Medication code — SNOMED CT, ATC, or Irish product code"

* form MS
* form ^short = "Dose form (e.g. tablet, capsule, solution)"

* amount MS
* amount ^short = "Package size / amount of drug in package"

* ingredient MS
* ingredient.item[x] MS
* ingredient.strength MS
* ingredient.strength ^short = "Strength of the active ingredient"
* ingredient.isActive MS

* batch MS
* batch.lotNumber MS
* batch.expirationDate MS
