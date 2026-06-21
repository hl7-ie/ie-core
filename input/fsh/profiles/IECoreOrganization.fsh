// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Organization Profile                                        │
// ╰──────────────────────────────────────────────────────────────────────╯

Profile: IECoreOrganization
Parent: $EUOrganizationCore
Id: ie-core-organization
Title: "IE Core Organization"
Description: "The IE Core Organization Profile is based upon the core FHIR Organization Resource and defines the minimum set of data required to query and retrieve organization information within the Irish healthcare system. It includes identifier slicing for the Company Registration Number (CRN) and Health Provider Index (HPI)."

// ── Identifier Slicing ──────────────────────────────────────────────────
* identifier MS
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier ^short = "Identifies this organization across multiple systems"
* identifier contains
    CRN 0..1 MS and
    HPI 0..1 MS

// CRN – Company Registration Number (CRO)
* identifier[CRN] ^short = "Company Registration Number (CRN)"
* identifier[CRN] ^definition = "The Company Registration Number assigned by the Companies Registration Office (CRO) in Ireland."
* identifier[CRN].system 1..1 MS
* identifier[CRN].system = $CRN
* identifier[CRN].type = $V2-0203#TAX "Tax ID number"
* identifier[CRN].value 1..1 MS
* identifier[CRN].value ^short = "CRN value"

// HPI – Health Provider Index
* identifier[HPI] ^short = "Health Provider Index (HPI) Number"
* identifier[HPI] ^definition = "The Health Provider Index number assigned to the organization. The HPI is the national identifier for healthcare organizations in Ireland."
* identifier[HPI].system 1..1 MS
* identifier[HPI].system = $HPI
* identifier[HPI].type = $V2-0203#NPI "National provider identifier"
* identifier[HPI].value 1..1 MS
* identifier[HPI].value ^short = "HPI number"

// ── Active ──────────────────────────────────────────────────────────────
* active MS
* active ^short = "Whether the organization's record is still in active use"

// ── Type ────────────────────────────────────────────────────────────────
* type MS
* type ^short = "Kind of organization"
* type from https://hl7-ie.github.io/fhir/ie/core/ValueSet/ie-core-organization-type (extensible)

// ── Name ────────────────────────────────────────────────────────────────
* name 1..1 MS
* name ^short = "Name used for the organization"

// ── Alias ───────────────────────────────────────────────────────────────
* alias MS

// ── Telecom ─────────────────────────────────────────────────────────────
* telecom MS
* telecom ^short = "A contact detail for the organization"
* telecom.system MS
* telecom.value MS
* telecom.use MS

// ── Address ─────────────────────────────────────────────────────────────
* address MS
* address ^short = "An address for the organization"
* address.line MS
* address.city MS
* address.state MS
* address.state from https://hl7-ie.github.io/fhir/ie/core/ValueSet/ie-core-county (extensible)
* address.postalCode MS
* address.country MS

// ── Contact ─────────────────────────────────────────────────────────────
* contact MS
* contact.purpose MS
* contact.name MS
* contact.telecom MS

// ── Part Of ─────────────────────────────────────────────────────────────
* partOf MS
* partOf only Reference(IECoreOrganization)

// ── Endpoint ────────────────────────────────────────────────────────────
* endpoint MS
