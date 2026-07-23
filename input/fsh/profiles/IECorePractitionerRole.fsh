// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core PractitionerRole Profile                                    │
// ╰──────────────────────────────────────────────────────────────────────╯

Profile: IECorePractitionerRole
Parent: $EUPractitionerRoleCore
Id: ie-core-practitionerrole
Title: "IE Core PractitionerRole"
Description: "The IE Core PractitionerRole Profile is based upon the core FHIR PractitionerRole Resource and defines the minimum set of data required to query and retrieve practitioner role information within the Irish healthcare system. It constrains references to IE Core profiles and binds the role code to the IE Core Healthcare Provider Taxonomy."

// ── Identifier ──────────────────────────────────────────────────────────
* identifier MS

// ── Active ──────────────────────────────────────────────────────────────
* active MS

// ── Period ──────────────────────────────────────────────────────────────
* period MS

// ── Practitioner ────────────────────────────────────────────────────────
* practitioner MS
* practitioner only Reference(IECorePractitioner)
* practitioner ^short = "Practitioner that is able to provide the defined services for the organization"

// ── Organization ────────────────────────────────────────────────────────
* organization MS
* organization only Reference(IECoreOrganization)
* organization ^short = "Organization where the roles are available"

// ── Code (Role) ─────────────────────────────────────────────────────────
* code MS
* code ^short = "Roles which this practitioner may perform"
* code from https://hl7-ie.github.io/ie-core/fhir/ie/core/ValueSet/ie-core-provider-taxonomy (extensible)

// ── Specialty ───────────────────────────────────────────────────────────
* specialty MS
* specialty ^short = "Specific specialty of the practitioner"
* specialty from https://hl7-ie.github.io/ie-core/fhir/ie/core/ValueSet/ie-core-provider-specialty (extensible)

// ── Location ────────────────────────────────────────────────────────────
* location MS
* location only Reference(IECoreLocation)
* location ^short = "The location(s) at which this practitioner provides care"

// ── Telecom ─────────────────────────────────────────────────────────────
* telecom MS
* telecom ^short = "Contact details that are specific to the role/location/service"
* telecom.system MS
* telecom.value MS
* telecom.use MS

// ── Healthcare Service ──────────────────────────────────────────────────
* healthcareService MS

// ── Endpoint ────────────────────────────────────────────────────────────
* endpoint MS
* endpoint ^short = "Technical endpoints providing access to services operated for the practitioner with this role"
