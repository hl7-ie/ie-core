// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Hospital Discharge Report Profile                         │
// │  Aligned with: HL7 Europe HDR IG, Xt-EHR EHDSDischargeReport      │
// ╰──────────────────────────────────────────────────────────────────────╯

Profile: IECoreCompositionDischargeReport
Parent: Composition
Id: ie-core-composition-discharge-report
Title: "IE Core Composition (Hospital Discharge Report)"
Description: "Profile for hospital discharge reports in the Irish healthcare system, aligned with the HL7 Europe Hospital Discharge Report IG (hl7.fhir.eu.hdr) and the Xt-EHR EHDSDischargeReport logical model. Structures the essential clinical information communicated at the point of hospital discharge."

* ^status = #draft

* status MS
* type 1..1 MS
* type = $LOINC#18842-5 "Discharge summary"

* subject 1..1 MS
* subject only Reference(IECorePatient)

* encounter 1..1 MS
* encounter only Reference(IECoreEncounter)
* encounter ^short = "The hospital encounter being discharged from"

* date 1..1 MS
* author 1..* MS
* author only Reference(IECorePractitioner or IECorePractitionerRole or IECoreOrganization)

* title 1..1 MS
* title ^short = "Hospital Discharge Report"

* custodian MS
* custodian only Reference(IECoreOrganization)

* section ^slicing.discriminator.type = #pattern
* section ^slicing.discriminator.path = "code"
* section ^slicing.rules = #open
* section contains
    admissionDetails 0..1 MS and
    diagnoses 0..1 MS and
    procedures 0..1 MS and
    medications 0..1 MS and
    allergies 0..1 MS and
    carePlan 0..1 MS

* section[admissionDetails].code = $LOINC#46241-6 "Hospital admission diagnosis Narrative - Reported"
* section[admissionDetails].text MS
* section[admissionDetails] ^short = "Admission details and reason for hospitalisation"

* section[diagnoses].code = $LOINC#11535-2 "Hospital discharge Dx Narrative"
* section[diagnoses].entry MS
* section[diagnoses].entry only Reference(IECoreConditionEncounterDiagnosis)
* section[diagnoses] ^short = "Discharge diagnoses"

* section[procedures].code = $LOINC#47519-4 "History of Procedures Document"
* section[procedures].entry MS
* section[procedures].entry only Reference(IECoreProcedure)
* section[procedures] ^short = "Procedures performed during hospitalisation"

* section[medications].code = $LOINC#10160-0 "History of Medication use Narrative"
* section[medications].entry MS
* section[medications].entry only Reference(IECoreMedicationRequest or IECoreMedicationRequestEPrescription)
* section[medications] ^short = "Discharge medications"

* section[allergies].code = $LOINC#48765-2 "Allergies and adverse reactions Document"
* section[allergies].entry MS
* section[allergies].entry only Reference(IECoreAllergyIntolerance)
* section[allergies] ^short = "Allergies and intolerances"

* section[carePlan].code = $LOINC#18776-5 "Plan of care note"
* section[carePlan].text MS
* section[carePlan] ^short = "Post-discharge care plan and follow-up"
