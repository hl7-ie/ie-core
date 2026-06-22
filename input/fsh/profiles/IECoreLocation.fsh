// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Location Profile                                            │
// ╰──────────────────────────────────────────────────────────────────────╯

Profile: IECoreLocation
Parent: $EULocationCore
Id: ie-core-location
Title: "IE Core Location"
Description: "The IE Core Location Profile is based upon the core FHIR Location Resource and defines the minimum set of data required to query and retrieve location information within the Irish healthcare system. It covers details such as the location name, type, address, and managing organization."

// ── Identifier ──────────────────────────────────────────────────────────
* identifier MS
* identifier ^short = "Unique code or number identifying the location to its users"

// ── Status ──────────────────────────────────────────────────────────────
* status MS
* status ^short = "active | suspended | inactive"

// ── Operational Status ──────────────────────────────────────────────────
* operationalStatus MS

// ── Name ────────────────────────────────────────────────────────────────
* name MS
* name ^short = "Name of the location as used by humans"

// ── Alias ───────────────────────────────────────────────────────────────
* alias MS

// ── Description ─────────────────────────────────────────────────────────
* description MS
* description ^short = "Additional details about the location"

// ── Mode ────────────────────────────────────────────────────────────────
* mode MS

// ── Type ────────────────────────────────────────────────────────────────
* type MS
* type ^short = "Type of function performed at the location"
* type from http://terminology.hl7.org/ValueSet/v3-ServiceDeliveryLocationRoleType (extensible)

// ── Telecom ─────────────────────────────────────────────────────────────
* telecom MS
* telecom ^short = "Contact details of the location"
* telecom.system MS
* telecom.value MS
* telecom.use MS

// ── Address ─────────────────────────────────────────────────────────────
* address MS
* address ^short = "Physical location address"
* address.line MS
* address.city MS
* address.state MS
* address.state ^short = "County"
* address.state from https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/ValueSet/ie-core-county (extensible)
* address.postalCode MS
* address.postalCode ^short = "Eircode or postal code"
* address.country MS

// ── Physical Type ───────────────────────────────────────────────────────
* physicalType MS

// ── Position ────────────────────────────────────────────────────────────
* position MS
* position.longitude MS
* position.latitude MS

// ── Managing Organization ───────────────────────────────────────────────
* managingOrganization MS
* managingOrganization only Reference(IECoreOrganization)
* managingOrganization ^short = "Organization responsible for provisioning and upkeep"

// ── Part Of ─────────────────────────────────────────────────────────────
* partOf MS
* partOf only Reference(IECoreLocation)

// ── Endpoint ────────────────────────────────────────────────────────────
* endpoint MS
