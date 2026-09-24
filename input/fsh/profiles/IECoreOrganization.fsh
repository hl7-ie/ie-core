// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Organization Profile                                        │
// ╰──────────────────────────────────────────────────────────────────────╯

Profile: IECoreOrganization
Parent: $EUOrganizationCore
Id: ie-core-organization
Title: "IE Core Organization"
Description: "The IE Core Organization Profile is based upon the core FHIR Organization Resource and defines the minimum set of data required to query and retrieve organization information within the Irish healthcare system. Identifier slicing for HIQA-sourced facility identifiers is defined in the use-case context (HIQA EP/PS 2.8, 2.12)."

// ── Identifier Slicing ──────────────────────────────────────────────────
* identifier MS
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier ^short = "Identifies this organization across multiple systems"
// ── Active ──────────────────────────────────────────────────────────────
* active MS
* active ^short = "Whether the organization's record is still in active use"

// ── Type ────────────────────────────────────────────────────────────────
* type MS
* type ^short = "Kind of organization"
* type from https://hl7-ie.github.io/ie-core/fhir/ie/core/ValueSet/ie-core-organization-type (extensible)

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
* address.state from https://hl7-ie.github.io/ie-core/fhir/ie/core/ValueSet/ie-core-county (extensible)
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
