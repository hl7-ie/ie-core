// ╭──────────────────────────────────────────────────────────────────────╮
// │  Extensions for HIQA draft national standards (Sept 2026)           │
// │  Only where no HL7 / HL7 Europe / IHE extension exists.             │
// ╰──────────────────────────────────────────────────────────────────────╯

Extension: IECoreMothersFormerSurname
Id: ie-core-mothers-former-surname
Title: "IE Core Mother's Former Surname"
Description: "One former surname of the patient's mother (repeat for each). HIQA PS 1.4.6 'Mother's former surnames' (Required 0..*): all former surnames of the patient's mother that may help identify the patient. The HL7 patient-mothersMaidenName extension holds only one name. Whether HIQA means the mother's birth surname only is Requires Clarification (OI-011). Patient Summary only; prohibited in ePrescription (ADR-002)."
Context: Patient
* ^status = #draft
* value[x] only string
* value[x] 1..1

Extension: IECoreCountryOfAffiliation
Id: ie-core-country-of-affiliation
Title: "IE Core Country of Affiliation"
Description: "HIQA PS 1.4.8 Country of affiliation (Required 0..1): the designated source country where the patient and their health information are based. Typically, but not always, the country of residence, and it may differ from nationality. No HL7 extension exists. Patient Summary only; prohibited in ePrescription (ADR-002)."
Context: Patient
* ^status = #draft
* value[x] only CodeableConcept
* value[x] 1..1
* valueCodeableConcept from http://hl7.org/fhir/ValueSet/iso3166-1-2 (required)

Extension: IECorePatientAgeAtPrescribing
Id: ie-core-patient-age-at-prescribing
Title: "IE Core Patient Age at Prescribing"
Description: "HIQA EP 1.4.2 Age (cluster): the patient's age recorded on the prescription. HIQA: if the date of birth shows the patient is under 12 years, recording the age on the prescription record is a legal requirement in Ireland. Age should be entered in years, and to the nearest three months (or less) for children under two. 1.4.2.1 value and 1.4.2.2 type are Mandatory within the cluster."
Context: MedicationRequest
* ^status = #draft
* value[x] only Age
* value[x] 1..1
* valueAge.value 1..1
* valueAge.value ^comment = "HIQA EP 1.4.2.1 Age if less than 12 years – value (Mandatory 1..1)."
* valueAge.system 1..1
* valueAge.system = $UCUM
* valueAge.code 1..1
* valueAge.code from IECoreAgeUnits (required)
* valueAge.code ^comment = "HIQA EP 1.4.2.2 Age if less than 12 years – type (Mandatory 1..1): years, months or days."

ValueSet: IECoreAgeUnits
Id: ie-core-age-units
Title: "IE Core Age Units"
Description: "UCUM units for recording a patient's age: years, months or days (HIQA EP 1.4.2.2)."
* ^experimental = false
* $UCUM#a "year"
* $UCUM#mo "month"
* $UCUM#d "day"

// ── HIQA EP Section 3: Medication prescription ─────────────────────────

Extension: IECoreQuantityInWordsAndFigures
Id: ie-core-quantity-in-words-and-figures
Title: "IE Core Quantity Prescribed (Words and Figures)"
Description: "HIQA EP 3.5.7.2 Quantity prescribed (free text): the overall quantity in words and figures, e.g. 'twenty-eight (28) tablets'. HIQA: a legal requirement if the item is a controlled drug under the Misuse of Drugs Act 1977 (as amended) and the Misuse of Drugs Regulations 2017 (S.I. No. 173/2017). Enforced for MDA Schedules 2, 3 and 4 Part 1 by invariant ie-rx-cd-1."
Context: MedicationRequest
* ^status = #draft
* value[x] only string
* value[x] 1..1

Extension: IECoreNumberOfInstalments
Id: ie-core-number-of-instalments
Title: "IE Core Number of Instalments"
Description: "HIQA EP 3.5.12 Number of instalments (Required 0..1): whether the total quantity can be dispensed in smaller, specified amounts at specified intervals (phased dispensing). This differs from repeats (numberOfRepeatsAllowed, EP 3.5.11). HIQA: a legal requirement for Schedule 2, 3 and 4 Part 1 controlled drugs; the interval is dispenseRequest.dispenseInterval (EP 3.5.13)."
Context: MedicationRequest.dispenseRequest
* ^status = #draft
* value[x] only positiveInt
* value[x] 1..1

Extension: IECoreDoNotExtend
Id: ie-core-do-not-extend
Title: "IE Core Do Not Extend"
Description: "HIQA EP 3.5.9.2 'Do Not Extend' (Optional 0..1): true when the prescriber does not want the pharmacist to extend the prescription beyond its validity period. HIQA: pharmacists can extend a six-month prescription for up to a further six months."
Context: MedicationRequest.dispenseRequest
* ^status = #draft
* value[x] only boolean
* value[x] 1..1

// ── HIQA EP Section 4: Medication ──────────────────────────────────────

Extension: IECoreMedicationInterchangeable
Id: ie-core-medication-interchangeable
Title: "IE Core Medicinal Product Is Interchangeable"
Description: "HIQA EP 3.5.10.1 (Required 0..1, expected auto-populated from the NMPC): whether the medicinal product is on the HPRA List of Interchangeable Medicines. If true, substitution is allowed by default unless the prescriber invokes 'Do Not Substitute' (MedicationRequest.substitution.allowedBoolean = false)."
Context: Medication
* ^status = #draft
* value[x] only boolean
* value[x] 1..1

Extension: IECoreExemptMedicationItem
Id: ie-core-exempt-medication-item
Title: "IE Core Exempt Medication Item (Requires Clarification)"
Description: "HIQA EP 4.11 Exempt medication item (Required 0..1, Boolean, expected auto-populated). REQUIRES CLARIFICATION: the draft does not say what the item is exempt from (e.g. an exempt medicinal product without a marketing authorisation). Modelled as a boolean flag so that the dataset element can be carried; see the open issues."
Context: Medication
* ^status = #draft
* ^experimental = true
* value[x] only boolean
* value[x] 1..1

// ── HIQA EP Section 6: Medication dispense ─────────────────────────────

Extension: IECoreDispenseReceiverRelatedPerson
Id: ie-core-dispense-receiver-related-person
Title: "IE Core Dispense Receiver (Related Person)"
Description: "HIQA EP 6.4.3 Related person is the receiver (Optional): the person (e.g. carer or family member) who collected the dispensed medication on the patient's behalf. R4 MedicationDispense.receiver allows only Patient or Practitioner."
Context: MedicationDispense
* ^status = #draft
* value[x] only Reference(IECoreRelatedPerson)
* value[x] 1..1
