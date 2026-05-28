// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core MedicationStatement Profile                               │
// │  Aligned with: Xt-EHR EHDSMedicationUse v1.0.0                    │
// │                                                                    │
// │  STATUS: DRAFT — added in XT-EHR 1.0.0 alignment pass             │
// │                                                                    │
// │  EHDSMedicationUse maps to the FHIR R4 MedicationStatement        │
// │  resource. In FHIR R5, the equivalent is MedicationUsage.         │
// │  This profile is required for the mandatory medication summary     │
// │  sections of the Patient Summary and Hospital Discharge Report.   │
// │                                                                    │
// │  PLANNED: Re-parent to EU Core MedicationStatement once           │
// │  hl7.fhir.eu.base v2.0.0 includes a medication-statement profile. │
// ╰──────────────────────────────────────────────────────────────────────╯

Profile: IECoreMedicationStatement
Parent: MedicationStatement
Id: ie-core-medicationstatement
Title: "IE Core MedicationStatement"
Description: "Profile for medication use statements in the Irish healthcare system, aligned with the Xt-EHR EHDSMedicationUse logical model v1.0.0. Used in the mandatory medication summary sections of the Patient Summary and Hospital Discharge Report. In FHIR R4, MedicationStatement is the direct mapping for EHDSMedicationUse; in FHIR R5, the equivalent resource is MedicationUsage."

* ^status = #draft

// ── Status ─────────────────────────────────────────────────────────────────
// EHDSMedicationUse.header.status
* status 1..1 MS
* status ^short = "Status of the medication use statement (active | completed | entered-in-error | intended | stopped | on-hold | unknown | not-taken)"

// ── Medication ─────────────────────────────────────────────────────────────
// EHDSMedicationUse.medication
* medication[x] 1..1 MS
* medicationCodeableConcept from http://hl7.org/fhir/ValueSet/medication-codes (extensible)
* medication[x] ^short = "Medication (NMPC preferred; SNOMED CT Irish Edition and ATC as secondary codes)"

// ── Subject ────────────────────────────────────────────────────────────────
* subject 1..1 MS
* subject only Reference(IECorePatient)

// ── Effective period ───────────────────────────────────────────────────────
// EHDSMedicationUse.periodOfUse
* effective[x] MS
* effective[x] ^short = "Period when the patient took or is taking the medication (EHDSMedicationUse.periodOfUse)"

// ── Information source / author ────────────────────────────────────────────
// EHDSMedicationUse.header.author
* informationSource MS
* informationSource only Reference(IECorePatient or IECorePractitioner or IECorePractitionerRole or IECoreRelatedPerson or IECoreOrganization)
* informationSource ^short = "Author of the medication statement"

// ── Reason ─────────────────────────────────────────────────────────────────
// EHDSMedicationUse.reason
* reasonCode MS
* reasonCode ^short = "Reason for taking the medication — diagnosis or procedure (ICD-10, SNOMED CT)"
* reasonReference MS

// ── Dosage ─────────────────────────────────────────────────────────────────
// EHDSMedicationUse.dosageInstructions
* dosage 1..* MS
* dosage.text 1..1 MS
* dosage.text ^short = "Human-readable dosage instructions"
* dosage.timing MS
* dosage.route MS
* dosage.doseAndRate MS

// ── Derived from ───────────────────────────────────────────────────────────
// EHDSMedicationUse.derivedFrom — prescriptions, dispenses, or administrations
* derivedFrom MS
* derivedFrom ^short = "Prescription, dispense, or administration that is the basis for this statement (EHDSMedicationUse.derivedFrom)"

// ── Note ───────────────────────────────────────────────────────────────────
// EHDSMedicationUse.note
* note MS
* note ^short = "Additional information about the medication use statement"
