// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Flag (Alert) Profile                                      │
// │  Aligned with: Xt-EHR EHDSAlert v1.0.0                            │
// │                                                                    │
// │  STATUS: DRAFT — added in XT-EHR 1.0.0 alignment pass             │
// │                                                                    │
// │  EHDSAlert maps to the FHIR R4 Flag resource.                     │
// │  Used in the alerts sections of the Patient Summary and           │
// │  Hospital Discharge Report.                                       │
// │                                                                    │
// │  PLANNED: Re-parent to EU Core Flag once                          │
// │  hl7.fhir.eu.base v2.0.0 includes a Flag profile.                │
// ╰──────────────────────────────────────────────────────────────────────╯

Profile: IECoreFlag
Parent: Flag
Id: ie-core-flag
Title: "IE Core Flag (Alert)"
Description: "Profile for substantial medical alerts or warnings in the Irish healthcare system, aligned with the Xt-EHR EHDSAlert logical model v1.0.0. Used in the alerts sections of the Patient Summary (EHDSPatientSummary.alerts) and Hospital Discharge Report (EHDSDischargeReport.body.alerts). Covers any clinical information that health professionals must be aware of to prevent immediate threat to the patient's life or health."

* ^status = #draft

// ── Status ─────────────────────────────────────────────────────────────────
* status 1..1 MS
* status ^short = "active | inactive | entered-in-error"

// ── Category ───────────────────────────────────────────────────────────────
* category MS
* category ^short = "Clinical focus of the alert (e.g. drug, allergy, safety, clinical)"

// ── Code ───────────────────────────────────────────────────────────────────
// EHDSAlert: description of the alert in textual/coded format
* code 1..1 MS
* code ^short = "Coded or textual description of the alert (SNOMED CT preferred)"
* code from http://hl7.org/fhir/ValueSet/clinical-findings (preferred)

// ── Subject ────────────────────────────────────────────────────────────────
* subject 1..1 MS
* subject only Reference(IECorePatient)

// ── Period ─────────────────────────────────────────────────────────────────
* period MS
* period ^short = "Time period during which the alert is relevant"

// ── Author ─────────────────────────────────────────────────────────────────
* author MS
* author only Reference(IECorePractitioner or IECorePractitionerRole or IECoreOrganization)
* author ^short = "Author or recorder of the alert"
