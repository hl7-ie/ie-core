// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Patient Summary Profile                                   │
// │  Aligned with: IPS, HL7 Europe PS, Xt-EHR EHDSPatientSummary      │
// ╰──────────────────────────────────────────────────────────────────────╯

Profile: IECoreCompositionPatientSummary
Parent: Composition
Id: ie-core-composition-patient-summary
Title: "IE Core Composition (Patient Summary)"
Description: "Profile for the Irish Patient Summary document, aligned with the International Patient Summary (IPS), the HL7 Europe Patient Summary IG, and the Xt-EHR EHDSPatientSummary logical model. The Patient Summary provides a snapshot of essential clinical information for unplanned cross-border care and continuity of care within Ireland."

* ^status = #draft

* status MS
* type 1..1 MS
* type = $LOINC#60591-5 "Patient summary Document"

* subject 1..1 MS
* subject only Reference(IECorePatient)

* date 1..1 MS
* author 1..* MS
* author only Reference(IECorePractitioner or IECorePractitionerRole or IECoreOrganization)

* title 1..1 MS
* title ^short = "Patient Summary"

* custodian MS
* custodian only Reference(IECoreOrganization)

* section ^slicing.discriminator.type = #pattern
* section ^slicing.discriminator.path = "code"
* section ^slicing.rules = #open
* section contains
    medications 1..1 MS and
    allergies 1..1 MS and
    problems 1..1 MS and
    procedures 0..1 MS and
    immunizations 0..1 MS and
    medicalDevices 0..1 MS and
    results 0..1 MS and
    vitalSigns 0..1 MS and
    pastIllnesses 0..1 MS and
    planOfCare 0..1 MS

* section[medications].code = $LOINC#10160-0 "History of Medication use Narrative"
* section[medications].entry MS
* section[medications].entry only Reference(IECoreMedicationRequest or IECoreMedicationDispense)
* section[medications] ^short = "Medication summary"

* section[allergies].code = $LOINC#48765-2 "Allergies and adverse reactions Document"
* section[allergies].entry MS
* section[allergies].entry only Reference(IECoreAllergyIntolerance)
* section[allergies] ^short = "Allergies and intolerances"

* section[problems].code = $LOINC#11450-4 "Problem list - Reported"
* section[problems].entry MS
* section[problems].entry only Reference(IECoreConditionProblemsHealthConcerns)
* section[problems] ^short = "Active problems and conditions"

* section[procedures].code = $LOINC#47519-4 "History of Procedures Document"
* section[procedures].entry MS
* section[procedures].entry only Reference(IECoreProcedure)
* section[procedures] ^short = "History of procedures"

* section[immunizations].code = $LOINC#11369-6 "History of Immunization Narrative"
* section[immunizations].entry MS
* section[immunizations].entry only Reference(IECoreImmunization)
* section[immunizations] ^short = "Immunization history"

* section[medicalDevices].code = $LOINC#46264-8 "History of medical device use"
* section[medicalDevices].entry MS
* section[medicalDevices] ^short = "Implanted or relevant medical devices"

* section[results].code = $LOINC#30954-2 "Relevant diagnostic tests/laboratory data Narrative"
* section[results].entry MS
* section[results].entry only Reference(IECoreDiagnosticReportLab or IECoreLaboratoryResultObservation)
* section[results] ^short = "Key diagnostic results"

* section[vitalSigns].code = $LOINC#8716-3 "Vital signs"
* section[vitalSigns].entry MS
* section[vitalSigns] ^short = "Vital signs"

* section[pastIllnesses].code = $LOINC#11348-0 "History of Past illness Narrative"
* section[pastIllnesses].entry MS
* section[pastIllnesses].entry only Reference(IECoreConditionProblemsHealthConcerns)
* section[pastIllnesses] ^short = "Past medical history"

* section[planOfCare].code = $LOINC#18776-5 "Plan of care note"
* section[planOfCare].text MS
* section[planOfCare] ^short = "Plan of care and follow-up"
