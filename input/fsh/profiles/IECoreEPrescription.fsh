// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core ePrescription Profiles                                    │
// │  Aligned with: HL7 Europe MPD IG, Xt-EHR EHDSMedicationPrescription│
// │  Updated to Xt-EHR v1.0.0: offLabel, statusReason,                │
// │  minimumDispenseInterval, intendedUseType                          │
// ╰──────────────────────────────────────────────────────────────────────╯

Profile: IECoreMedicationRequestEPrescription
Parent: IECoreMedicationRequest
Id: ie-core-medicationrequest-eprescription
Title: "IE Core MedicationRequest (ePrescription)"
Description: "Profile for electronic prescriptions in the Irish healthcare system, aligned with the HL7 Europe Medication Prescription and Dispense (MPD) IG and the Xt-EHR EHDSMedicationPrescription logical model v1.0.0. This profile extends the base IE Core MedicationRequest with constraints required for cross-border ePrescription exchange via MyHealth@EU. Additions in v1.0.0 alignment: offLabel block, statusReason, dispenseRequest.dispenseInterval (minimumDispenseInterval), and category for intendedUseType."

* ^status = #draft

* identifier 1..* MS
* identifier ^short = "Prescription line identifier"
* identifier ^definition = "Unique identifier for this prescription item. In Ireland, this maps to the PCRS claim reference or the ePrescription reference number."

* status MS
* intent MS
* intent = #order

// statusReason — added in Xt-EHR EHDSMedicationPrescription v1.0.0
// Reason why the prescription has the current status (e.g. why it was cancelled or put on hold)
* statusReason MS
* statusReason ^short = "Reason for the current prescription status (EHDSMedicationPrescription.header.statusReason)"

* category 0..* MS
* category ^short = "Prescription category — includes intendedUseType (e.g. prophylaxis, treatment, anaesthesia)"
* category ^definition = "Categorisation of the prescription intent per Xt-EHR EHDSMedicationPrescription.prescriptionItem.intendedUseType (v1.0.0)."

* priority MS

* medication[x] 1..1 MS
* subject 1..1 MS

* requester 1..1 MS
* requester only Reference(IECorePractitioner or IECorePractitionerRole or IECoreOrganization)
* requester ^short = "Prescriber — the health professional who authored the prescription"

* authoredOn 1..1 MS
* authoredOn ^short = "Date the prescription was written"

* reasonCode MS
* reasonCode ^short = "Clinical reason/indication for the prescription (ICD-10, SNOMED CT, Orphacode)"

* dosageInstruction 1..* MS
* dosageInstruction.text 1..1 MS
* dosageInstruction.text ^short = "Human-readable dosage instructions"
* dosageInstruction.timing MS
* dosageInstruction.route MS
* dosageInstruction.doseAndRate MS

* dispenseRequest MS
* dispenseRequest.validityPeriod MS
* dispenseRequest.validityPeriod ^short = "Period during which the prescription can be dispensed (EHDSMedicationPrescription.prescriptionItem.validityPeriod)"
* dispenseRequest.numberOfRepeatsAllowed MS
* dispenseRequest.numberOfRepeatsAllowed ^short = "Number of refills allowed beyond the initial dispense (EHDSMedicationPrescription.prescriptionItem.numberOfRepeats)"
* dispenseRequest.quantity MS
* dispenseRequest.expectedSupplyDuration MS
// dispenseRequest.dispenseInterval maps to EHDSMedicationPrescription.prescriptionItem.minimumDispenseInterval (v1.0.0)
* dispenseRequest.dispenseInterval MS
* dispenseRequest.dispenseInterval ^short = "Minimum interval between dispensations for a repeating prescription (EHDSMedicationPrescription.prescriptionItem.minimumDispenseInterval)"

* substitution MS
* substitution.allowed[x] MS
* substitution.allowed[x] ^short = "Whether substitution is allowed under Irish pharmacy regulations"
* substitution.reason MS
* substitution.reason ^short = "Reason for the substitution requirement (e.g. biological product, patient allergy to excipient)"

* groupIdentifier MS
* groupIdentifier ^short = "Links multiple prescription items on the same prescription"

// ── Off-label use (new in Xt-EHR EHDSMedicationPrescription v1.0.0) ───────
// EHDSMedicationPrescription.prescriptionItem.offLabel is modelled here using
// the FHIR R4 extension mechanism as there is no native R4 element.
// When the EU MPD IG is published as STU, this should derive from
// MedicationRequest-eu-mpd which may carry a formal offLabel extension.
* extension contains IECoreOffLabelUse named offLabelUse 0..1 MS
* extension[offLabelUse] ^short = "Off-label use indicator — prescriber has knowingly prescribed outside approved indications (EHDSMedicationPrescription.prescriptionItem.offLabel)"

// ── Note ───────────────────────────────────────────────────────────────────
* note MS
* note ^short = "Additional information or message to the dispenser"


Profile: IECoreMedicationDispenseEDispensation
Parent: IECoreMedicationDispense
Id: ie-core-medicationdispense-edispensation
Title: "IE Core MedicationDispense (eDispensation)"
Description: "Profile for electronic dispensation records in the Irish healthcare system, aligned with the HL7 Europe MPD IG and the Xt-EHR EHDSMedicationDispense logical model v1.0.0. This profile extends the base IE Core MedicationDispense with constraints for cross-border eDispensation exchange."

* ^status = #draft

* identifier 1..* MS
* identifier ^short = "Dispensation record identifier"

* status MS

// statusReason — added in Xt-EHR v1.0.0 alignment
* statusReasonCodeableConcept MS
* statusReasonCodeableConcept ^short = "Reason for the current dispense status"

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
Description: "Medication profile for use in ePrescription and eDispensation, aligned with the HL7 Europe MPD Medication profile and the Xt-EHR EHDSMedication logical model v1.0.0. Supports both generic/virtual products and branded/packaged products as required by Irish pharmacy practice and EU cross-border exchange."

* ^status = #draft

* code 1..1 MS
* code ^short = "Medication code. Use NMPC as the primary coding where available, with SNOMED CT Irish Edition as a secondary coding where available. ATC may be carried for cross-border classification."

* form MS
* form ^short = "Dose form (e.g. tablet, capsule, solution) — EDQM Standard Terms preferred"

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


// ── Off-label extension definition ────────────────────────────────────────
Extension: IECoreOffLabelUse
Id: ie-core-off-label-use
Title: "IE Core Off-Label Use"
Description: "Indicates that the prescriber has knowingly prescribed the medication for an indication, age group, dosage, or route of administration that is not approved by the regulatory agencies. Corresponds to EHDSMedicationPrescription.prescriptionItem.offLabel in Xt-EHR v1.0.0."

* ^status = #draft
* ^context[+].type = #element
* ^context[=].expression = "MedicationRequest"

* extension contains
    isOffLabelUse 1..1 and
    reason 0..*

* extension[isOffLabelUse].value[x] only boolean
* extension[isOffLabelUse] ^short = "True when the prescriber knowingly uses the medication off-label"

* extension[reason].value[x] only CodeableConcept or string
* extension[reason] ^short = "Reason or clarification for the off-label use"
