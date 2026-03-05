// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Encounter Profile                                           │
// ╰──────────────────────────────────────────────────────────────────────╯

Profile: IECoreEncounter
Parent: Encounter
Id: ie-core-encounter
Title: "IE Core Encounter"
Description: "The IE Core Encounter Profile is based upon the core FHIR Encounter Resource and defines the minimum set of data required to query and retrieve encounter information within the Irish healthcare system. It establishes constraints on encounter type, subject, and hospitalization discharge disposition."

// ── Identifier ──────────────────────────────────────────────────────────
* identifier MS
* identifier ^short = "Identifier(s) by which this encounter is known"

// ── Status ──────────────────────────────────────────────────────────────
* status MS
* status ^short = "planned | arrived | triaged | in-progress | onleave | finished | cancelled +"

// ── Status History ──────────────────────────────────────────────────────
* statusHistory MS
* statusHistory.status MS
* statusHistory.period MS

// ── Class ───────────────────────────────────────────────────────────────
* class MS
* class ^short = "Classification of patient encounter (e.g. ambulatory, inpatient, emergency)"
* class from http://terminology.hl7.org/ValueSet/v3-ActEncounterCode (extensible)

// ── Type ────────────────────────────────────────────────────────────────
* type 1..* MS
* type ^short = "Specific type of encounter"
* type from http://hl7.hse.ie/fhir/ie/core/ValueSet/ie-core-encounter-type (extensible)

// ── Service Type ────────────────────────────────────────────────────────
* serviceType MS
* serviceType ^short = "Specific type of service"

// ── Priority ────────────────────────────────────────────────────────────
* priority MS

// ── Subject ─────────────────────────────────────────────────────────────
* subject 1..1 MS
* subject only Reference(IECorePatient)
* subject ^short = "The patient present at the encounter"

// ── Participant ─────────────────────────────────────────────────────────
* participant MS
* participant ^short = "List of participants involved in the encounter"
* participant.type MS
* participant.type ^short = "Role of participant in encounter"
* participant.period MS
* participant.individual MS
* participant.individual only Reference(IECorePractitioner or IECorePractitionerRole or RelatedPerson)

// ── Period ──────────────────────────────────────────────────────────────
* period MS
* period ^short = "The start and end time of the encounter"

// ── Length ───────────────────────────────────────────────────────────────
* length MS

// ── Reason Code ─────────────────────────────────────────────────────────
* reasonCode MS
* reasonCode ^short = "Coded reason the encounter takes place"
* reasonCode from http://hl7.org/fhir/ValueSet/encounter-reason (extensible)

// ── Reason Reference ────────────────────────────────────────────────────
* reasonReference MS
* reasonReference ^short = "Reason the encounter takes place (reference)"
* reasonReference only Reference(Condition or Procedure or Observation or ImmunizationRecommendation)

// ── Diagnosis ───────────────────────────────────────────────────────────
* diagnosis MS
* diagnosis.condition MS
* diagnosis.use MS
* diagnosis.rank MS

// ── Hospitalization ─────────────────────────────────────────────────────
* hospitalization MS
* hospitalization ^short = "Details about the admission to a healthcare service"
* hospitalization.origin MS
* hospitalization.admitSource MS
* hospitalization.admitSource from http://hl7.hse.ie/fhir/ie/core/ValueSet/ie-core-admit-source (extensible)
* hospitalization.reAdmission MS
* hospitalization.dietPreference MS
* hospitalization.destination MS
* hospitalization.dischargeDisposition MS
* hospitalization.dischargeDisposition ^short = "Category or kind of location after discharge"
* hospitalization.dischargeDisposition from http://hl7.hse.ie/fhir/ie/core/ValueSet/ie-core-discharge-disposition (extensible)

// ── Location ────────────────────────────────────────────────────────────
* location MS
* location ^short = "List of locations where the patient has been"
* location.location MS
* location.location only Reference(IECoreLocation)
* location.status MS
* location.period MS

// ── Service Provider ────────────────────────────────────────────────────
* serviceProvider MS
* serviceProvider only Reference(IECoreOrganization)
