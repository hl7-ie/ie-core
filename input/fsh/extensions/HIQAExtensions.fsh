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
