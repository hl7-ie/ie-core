// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Patient Profile                                            │
// ╰──────────────────────────────────────────────────────────────────────╯

Profile: IECorePatient
Parent: $EUPatientCore
Id: ie-core-patient
Title: "IE Core Patient"
Description: "The IE Core Patient Profile is based upon the core FHIR Patient Resource and defines the minimum set of data required to query and retrieve patient demographic information within the Irish healthcare system (HSE). It establishes constraints and extensions relevant to Ireland including identifier slicing for Irish health scheme numbers."

// ── Extensions ──────────────────────────────────────────────────────────
* extension contains
    IECoreEthnicity named ethnicity 0..1 MS and
    http://hl7.org/fhir/StructureDefinition/patient-mothersMaidenName named mothersMaidenName 0..1 MS and
    http://hl7.org/fhir/StructureDefinition/individual-genderIdentity named genderIdentity 0..* MS and
    $IndividualPronouns named personalPronouns 0..* MS and
    http://hl7.org/fhir/StructureDefinition/patient-interpreterRequired named interpreterRequired 0..1 MS

* extension[ethnicity] ^short = "Ethnicity of the patient"
* extension[ethnicity] ^definition = "The patient's ethnicity as categorised within the Irish healthcare system."
* extension[mothersMaidenName] ^short = "Mother's maiden (birth family) name"
* extension[genderIdentity] ^short = "The patient's gender identity"
* extension[personalPronouns] ^short = "The patient's personal pronouns"
* extension[interpreterRequired] ^short = "Whether the patient requires an interpreter"

// ── Identifier Slicing ──────────────────────────────────────────────────
* identifier MS
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier ^short = "An identifier for this patient"
* identifier contains
    IHI 0..1 MS and
    GMS 0..1 MS and
    DPS 0..1 MS and
    LTI 0..1 MS and
    HAA 0..1 MS and
    MRN 0..* MS and
    IMN 0..1 MS

// IHI – Individual Health Identifier
* identifier[IHI] ^short = "Individual Health Identifier (IHI)"
* identifier[IHI] ^definition = "The Individual Health Identifier assigned to the patient by the HSE. The IHI is a unique 18-digit numeric identifier."
* identifier[IHI].system 1..1 MS
* identifier[IHI].system = $IHI
* identifier[IHI].type = $V2-0203#NI "National unique individual identifier"
* identifier[IHI].value 1..1 MS
* identifier[IHI].value ^short = "IHI number (18 digits)"
* identifier[IHI] obeys ie-pat-1

// GMS – General Medical Services (Medical Card)
* identifier[GMS] ^short = "General Medical Services (GMS) Number"
* identifier[GMS] ^definition = "The General Medical Services (Medical Card) number. Format is 7 digits followed by 1 alphabetic character."
* identifier[GMS].system 1..1 MS
* identifier[GMS].system = $GMS
* identifier[GMS].type = $V2-0203#MC "Patient's Medicare number"
* identifier[GMS].value 1..1 MS
* identifier[GMS].value ^short = "GMS number (e.g. 1234567A)"
* identifier[GMS] obeys ie-pat-2

// DPS – Drugs Payment Scheme
* identifier[DPS] ^short = "Drugs Payment Scheme (DPS) Number"
* identifier[DPS] ^definition = "The Drugs Payment Scheme number. Format follows the PPS Number pattern: 7 digits followed by 1-2 alphabetic characters."
* identifier[DPS].system 1..1 MS
* identifier[DPS].system = $DPS
* identifier[DPS].type = $V2-0203#JHN "Jurisdictional health number (Canada)"
* identifier[DPS].value 1..1 MS
* identifier[DPS].value ^short = "DPS number"
* identifier[DPS] obeys ie-pat-3

// LTI – Long Term Illness Scheme
* identifier[LTI] ^short = "Long Term Illness (LTI) Scheme Number"
* identifier[LTI] ^definition = "The Long Term Illness scheme number. Format follows the PPS Number pattern: 7 digits followed by 1-2 alphabetic characters."
* identifier[LTI].system 1..1 MS
* identifier[LTI].system = $LTI
* identifier[LTI].type = $V2-0203#JHN "Jurisdictional health number (Canada)"
* identifier[LTI].value 1..1 MS
* identifier[LTI].value ^short = "LTI number"
* identifier[LTI] obeys ie-pat-4

// HAA – Hospital Appointment Access
* identifier[HAA] ^short = "Hospital Appointment Access (HAA) Number"
* identifier[HAA] ^definition = "The Hospital Appointment Access number assigned to the patient. Format is 8-10 alphanumeric characters."
* identifier[HAA].system 1..1 MS
* identifier[HAA].system = $HAA
* identifier[HAA].type = $V2-0203#AN "Account number"
* identifier[HAA].value 1..1 MS
* identifier[HAA].value ^short = "HAA number"
* identifier[HAA] obeys ie-pat-5

// MRN – Medical Record Number
* identifier[MRN] ^short = "Medical Record Number (MRN)"
* identifier[MRN] ^definition = "A local Medical Record Number assigned by a healthcare facility."
* identifier[MRN].system 1..1 MS
* identifier[MRN].system = $MRN
* identifier[MRN].type = $V2-0203#MR "Medical record number"
* identifier[MRN].value 1..1 MS
* identifier[MRN].value ^short = "MRN value"

// IMN – Immunisation Number
* identifier[IMN] ^short = "Immunisation Number (IMN)"
* identifier[IMN] ^definition = "The national immunisation number assigned to the patient."
* identifier[IMN].system 1..1 MS
* identifier[IMN].system = $IMN
* identifier[IMN].type = $V2-0203#NI "National unique individual identifier"
* identifier[IMN].value 1..1 MS
* identifier[IMN].value ^short = "IMN value"

// ── Name ────────────────────────────────────────────────────────────────
* name 1..* MS
* name ^short = "A name associated with the patient"
* name.family MS
* name.family ^short = "Family name (surname)"
* name.given MS
* name.given ^short = "Given names (first and middle names)"
* name.prefix MS
* name.suffix MS
* name.use MS

// ── Gender ──────────────────────────────────────────────────────────────
* gender 1..1 MS
* gender ^short = "male | female | other | unknown"

// ── Birth Date ──────────────────────────────────────────────────────────
* birthDate MS
* birthDate ^short = "The date of birth for the patient"

// ── Address ─────────────────────────────────────────────────────────────
* address MS
* address ^short = "An address for the patient (Irish address)"
* address.line MS
* address.line ^short = "Street name, number, direction & P.O. Box etc."
* address.city MS
* address.city ^short = "Name of city, town, or locality"
* address.state MS
* address.state ^short = "County"
* address.state ^definition = "The Irish county. Bound to the IE Core County ValueSet."
* address.state from https://hl7-ie.github.io/hl7-ie-fhir-draft-ig/fhir/ie/core/ValueSet/ie-core-county (extensible)
* address.postalCode MS
* address.postalCode ^short = "Eircode or postal code"
* address.country MS
* address.country ^short = "Country (ISO 3166-1 alpha-2)"

// ── Telecom ─────────────────────────────────────────────────────────────
* telecom MS
* telecom ^short = "A contact detail for the patient"
* telecom.system 1..1 MS
* telecom.system ^short = "phone | fax | email | pager | url | sms | other"
* telecom.value 1..1 MS
* telecom.value ^short = "The actual contact point details"
* telecom.use MS
* telecom.use ^short = "home | work | temp | old | mobile"

// ── Communication ───────────────────────────────────────────────────────
* communication MS
* communication.language MS

// ── Deceased ────────────────────────────────────────────────────────────
* deceased[x] MS

// ── Managing Organization ───────────────────────────────────────────────
* managingOrganization MS
* managingOrganization only Reference(IECoreOrganization)

// ── General Practitioner ────────────────────────────────────────────────
* generalPractitioner MS
* generalPractitioner only Reference(IECoreOrganization or IECorePractitioner or IECorePractitionerRole)

// ╭──────────────────────────────────────────────────────────────────────╮
// │  Invariants                                                          │
// ╰──────────────────────────────────────────────────────────────────────╯

Invariant: ie-pat-1
Description: "IHI SHALL be exactly 18 digits"
Expression: "value.matches('^[0-9]{18}$')"
Severity: #error

Invariant: ie-pat-2
Description: "GMS number SHALL be 7 digits followed by 1 alphabetic check character"
Expression: "value.matches('^[0-9]{7}[A-Za-z]$')"
Severity: #error

Invariant: ie-pat-3
Description: "DPS number SHALL be 7 digits followed by 1-2 alphabetic characters"
Expression: "value.matches('^[0-9]{7}[A-Za-z]{1,2}$')"
Severity: #error

Invariant: ie-pat-4
Description: "LTI number SHALL be 7 digits followed by 1-2 alphabetic characters"
Expression: "value.matches('^[0-9]{7}[A-Za-z]{1,2}$')"
Severity: #error

Invariant: ie-pat-5
Description: "HAA number SHALL be 8-10 alphanumeric characters"
Expression: "value.matches('^[A-Za-z0-9]{8,10}$')"
Severity: #error

