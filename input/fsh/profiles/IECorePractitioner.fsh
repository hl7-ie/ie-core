// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Practitioner Profile                                        │
// ╰──────────────────────────────────────────────────────────────────────╯

Profile: IECorePractitioner
Parent: $EUPractitionerCore
Id: ie-core-practitioner
Title: "IE Core Practitioner"
Description: "The IE Core Practitioner Profile is based upon the core FHIR Practitioner Resource and defines the minimum set of data required to query and retrieve practitioner demographic information within the Irish healthcare system. It includes identifier slicing for professional registration numbers (HIQA EP/PS 2.6)."

// ── Identifier Slicing ──────────────────────────────────────────────────
* identifier MS
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier ^short = "An identifier for the practitioner"
* identifier contains
    IMC 0..1 MS

// IMC – Irish Medical Council Registration
* identifier[IMC] ^short = "Irish Medical Council (IMC) Registration Number"
* identifier[IMC] ^definition = "The Irish Medical Council registration number. All practising doctors in Ireland must be registered with the IMC."
* identifier[IMC].system 1..1 MS
* identifier[IMC].system = $IMC
* identifier[IMC].type = $V2-0203#MD "Medical License number"
* identifier[IMC].value 1..1 MS
* identifier[IMC].value ^short = "IMC registration number"

// ── Name ────────────────────────────────────────────────────────────────
* name 1..* MS
* name ^short = "The name(s) associated with the practitioner"
* name.family 1..1 MS
* name.family ^short = "Family name (surname)"
* name.given MS
* name.given ^short = "Given names"
* name.prefix MS
* name.suffix MS

// ── Telecom ─────────────────────────────────────────────────────────────
* telecom MS
* telecom ^short = "A contact detail for the practitioner"
* telecom.system MS
* telecom.value MS
* telecom.use MS

// ── Address ─────────────────────────────────────────────────────────────
* address MS
* address ^short = "Address(es) of the practitioner"
* address.line MS
* address.city MS
* address.state MS
* address.state from https://hl7-ie.github.io/ie-core/fhir/ie/core/ValueSet/ie-core-county (extensible)
* address.postalCode MS
* address.country MS

// ── Qualification ───────────────────────────────────────────────────────
* qualification MS
* qualification ^short = "Certification, licenses, or training pertaining to the provision of care"
* qualification.identifier MS
* qualification.code MS
* qualification.code ^short = "Coded representation of the qualification"
* qualification.code from https://hl7-ie.github.io/ie-core/fhir/ie/core/ValueSet/ie-core-practitioner-qualification (extensible)
* qualification.period MS
* qualification.issuer MS

// ── Gender ──────────────────────────────────────────────────────────────
* gender MS

// ── Communication ───────────────────────────────────────────────────────
* communication MS
