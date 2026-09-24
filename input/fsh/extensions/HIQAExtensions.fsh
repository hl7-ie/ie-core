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
