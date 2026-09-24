// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Patient (Patient Summary)                                  │
// │  HIQA Draft National Standard for a Patient Summary, Section 1      │
// │  Patient Details and Section 3 Nominated Contact Person (Sept 2026) │
// │  ADR-002 + ADR-004: parent HL7 Europe EPS patient; imposes          │
// │  IECorePatient (IE identifier and address rules).                   │
// ╰──────────────────────────────────────────────────────────────────────╯

Profile: IECorePatientSummaryPatient
Parent: $EUPatientEPS
Id: ie-core-patient-summary-patient
Title: "IE Core Patient (Patient Summary)"
Description: "The patient as the subject of an Irish Patient Summary. It carries the HIQA Patient Summary demographic dataset (Section 1), including the Required demographics that are NOT part of the ePrescription dataset (ethnicity, nationality, mother's former surnames, place of birth, country of affiliation), and the nominated contact person (Section 3). Marital status, religion and pronouns are in neither HIQA dataset and are prohibited. Derived from the HL7 Europe Patient Summary patient (which imposes the IPS patient) and imposes IECorePatient."
* ^status = #draft
* ^extension[+].url = $ImposeProfile
* ^extension[=].valueCanonical = Canonical(IECorePatient)

// ── 1.4 Additional demographic details ─────────────────────────────────
// Slices inherited from EU Base / EPS are reused: gender-identity, patient-nationality, birthPlace, pronouns.
* extension contains
    $RecordedSexOrGender named sexAssignedAtBirth 1..1 MS and
    IECoreEthnicity named ethnicity 0..* MS and
    IECoreMothersFormerSurname named mothersFormerSurname 0..* MS and
    IECoreCountryOfAffiliation named countryOfAffiliation 0..1 MS and
    $PatientReligion named religion 0..0
* extension[gender-identity] 0..1 MS
* extension[patient-nationality] MS
* extension[birthPlace] MS
* extension[pronouns] 0..0

* extension[sexAssignedAtBirth].extension[type] 1..1
* extension[sexAssignedAtBirth].extension[type].value[x] = $LOINC#76689-9 "Sex assigned at birth"
* extension[sexAssignedAtBirth] ^comment = "HIQA PS 1.4.4 Sex (Mandatory 1..1): sex assigned at birth, e.g. male or female."
* extension[gender-identity] ^comment = "HIQA PS 1.4.5 Gender cluster (Required 0..1): 1.4.5.1 Gender (coded) and 1.4.5.2 Other gender identity (valueCodeableConcept.text)."
* extension[ethnicity] ^comment = "HIQA PS 1.4.10 Ethnicity (Required 0..*, coded). GDPR Art. 9 special-category data: send only when recorded with appropriate safeguards and consent. HIQA says it is not used for patient identification."
* extension[mothersFormerSurname] ^comment = "HIQA PS 1.4.6 Mother's former surnames (Required 0..*). OI-011."
* extension[patient-nationality] ^comment = "HIQA PS 1.4.7 Nationality (Required 0..*, coded): country of legal citizenship."
* extension[birthPlace] ^comment = "HIQA PS 1.4.3 Place of birth (Required 0..1): the county (in Ireland) or city (elsewhere) of birth, carried in valueAddress.state or valueAddress.city."
* extension[countryOfAffiliation] ^comment = "HIQA PS 1.4.8 Country of affiliation (Required 0..1)."
* extension[religion] ^comment = "Prohibited: not in the HIQA PS dataset; GDPR Art. 9 special-category data."
* extension[pronouns] ^comment = "Prohibited: not in the HIQA PS dataset."
* maritalStatus 0..0
* maritalStatus ^comment = "Prohibited: not in the HIQA PS dataset."

// ── 1.1 Name details ───────────────────────────────────────────────────
* name 1..* MS
* name.use MS
* name.use ^comment = "HIQA PS 1.1.6 Former names (Required 0..*) use 'old'; 1.1.7 Preferred name (Required 0..1) uses 'usual'."
* name.given 1..* MS
* name.given ^comment = "HIQA PS 1.1.2 Forename (Mandatory 1..1); PS 1.1.3 Middle name(s) (Required 0..1) as further given names."
* name.family 1..1 MS
* name.family ^comment = "HIQA PS 1.1.4 Surname (Mandatory 1..1)."
* name.prefix MS
* name.suffix MS

// ── 1.2 Address ────────────────────────────────────────────────────────
* address 1..* MS
* address.use 1..1 MS
* address.use ^comment = "HIQA PS 1.2.6 Address type (Mandatory 1..1)."
* address.line 1..* MS
* address.line ^comment = "HIQA PS 1.2.2 Address line(s) (Mandatory 1..1)."
* address.city MS
* address.state 1..1 MS
* address.state ^comment = "HIQA PS 1.2.4 District/County (Mandatory 1..1)."
* address.postalCode MS
* address.country MS

// ── 1.3 Identifiers ────────────────────────────────────────────────────
* identifier MS
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier.type MS
* identifier.value MS
* identifier.period MS
* identifier.assigner MS
* identifier ^comment = "HIQA PS 1.3.1 IHI (slice imposed by IECorePatient), 1.3.2 PPSN, 1.3.3 other identifiers (type, value, period, issuing organisation; all Required)."
* identifier contains PPSN 0..1
* identifier[PPSN] ^short = "Personal Public Service Number (PPSN): Requires Clarification"
* identifier[PPSN] ^comment = "HIQA PS 1.3.2 (Required 0..1). Deliberately NOT MustSupport: the legal basis for using the PPSN as a health identifier is Requires Clarification (OI-008). The IHI (PS 1.3.1) slice is imposed by IECorePatient."
* identifier[PPSN].system 1..1
* identifier[PPSN].system = $PPS
* identifier[PPSN].value 1..1
* identifier[PPSN] obeys ie-pat-ppsn-1

// ── 1.4.1 DOB, 1.4.4 administrative gender, 1.4.11 date of death ───────
* birthDate 1..1 MS
* birthDate ^comment = "HIQA PS 1.4.1 Date of birth (Mandatory 1..1). HIQA: if unknown, record 1900-01-01 (estimated age, PS 1.4.2, is Optional and not modelled)."
* gender 1..1 MS
* deceased[x] MS
* deceased[x] ^comment = "HIQA PS 1.4.11 Date of death (Required 0..1) as deceasedDateTime. PS 1.4.12 Cause of death (Required) has no Patient element: Requires Clarification."

// ── 1.4.9 Preferred language, 1.5 communication ────────────────────────
* communication MS
* communication.language MS
* communication ^comment = "HIQA PS 1.4.9 Preferred language (Optional 0..*), including sign language."
* telecom MS
* telecom.system MS
* telecom.value MS
* telecom.use MS
* telecom.rank MS
* telecom ^comment = "HIQA PS 1.5.1 Mobile phone, 1.5.2 Email (Required); 1.5.3 Other communication details (Optional); 1.5.4 Preferred communication method (Required), expressed by rank = 1."

// ── Section 3. Nominated contact person ────────────────────────────────
* contact MS
* contact ^short = "Nominated contact person (HIQA PS Section 3)"
* contact.name MS
* contact.name.given MS
* contact.name.given ^comment = "HIQA PS 3.1 Forename of nominated contact person (Required 0..1)."
* contact.name.family MS
* contact.name.family ^comment = "HIQA PS 3.2 Surname of nominated contact person (Required 0..1)."
* contact.relationship MS
* contact.relationship ^comment = "HIQA PS 3.3 Role (Required 0..*) and 3.4 Relationship (Required 0..1)."
* contact.telecom MS
* contact.telecom ^comment = "HIQA PS 3.5 Communication details (Required): 3.5.1 mobile, 3.5.2 landline, 3.5.3 email."
* contact.address ^comment = "HIQA PS 3.6 Address of nominated contact person (Optional 0..1)."
* contact.address.line 1..*
* contact.address.line ^comment = "HIQA PS 3.6.2 Address line(s): Mandatory when the contact address is given."
* contact.address.state 1..1
* contact.address.state ^comment = "HIQA PS 3.6.4 District/County/City: Mandatory when the contact address is given."
* contact.address.postalCode MS
* contact.address.city MS
* contact.address.country MS
* contact.telecom.rank MS
* contact.telecom.rank ^comment = "HIQA PS 3.7 Preferred communication type for the nominated contact person (Required): rank = 1."

* generalPractitioner MS
* generalPractitioner ^comment = "HIQA PS Section 2: General Practitioner details must be captured in all cases."
