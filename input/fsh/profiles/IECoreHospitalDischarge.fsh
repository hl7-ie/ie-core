// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Hospital Discharge Report Profile                         │
// │  Aligned with: HL7 Europe HDR IG, Xt-EHR EHDSDischargeReport 1.0.0│
// ╰──────────────────────────────────────────────────────────────────────╯

Profile: IECoreCompositionDischargeReport
Parent: Composition
Id: ie-core-composition-discharge-report
Title: "IE Core Composition (Hospital Discharge Report)"
Description: "Profile for hospital discharge reports in the Irish healthcare system, aligned with the HL7 Europe Hospital Discharge Report IG (hl7.fhir.eu.hdr) and the Xt-EHR EHDSDischargeReport logical model v1.0.0. Structures the essential clinical information communicated at the point of hospital discharge. The 1.0.0 model significantly expands the structure to include admission evaluation, patient history (anamnesis), course of encounter, discharge details, and attachments."

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

// ── Section slicing ─────────────────────────────────────────────────────────
// Sections marked 1..1 are mandatory per Xt-EHR EHDSDischargeReport v1.0.0.
* section ^slicing.discriminator.type = #pattern
* section ^slicing.discriminator.path = "code"
* section ^slicing.rules = #open
* section contains
    encounterInformation 1..1 MS and
    courseOfEncounter 1..1 MS and
    admissionEvaluation 0..1 MS and
    patientHistory 0..1 MS and
    dischargeDetails 0..1 MS and
    alerts 0..1 MS and
    medicationSummary 0..1 MS and
    carePlan 0..1 MS

// ── Encounter information (mandatory, EHDSEncounter) ──────────────────────
* section[encounterInformation].code = $LOINC#46241-6 "Hospital admission diagnosis Narrative - Reported"
* section[encounterInformation].text MS
* section[encounterInformation].entry MS
* section[encounterInformation].entry only Reference(IECoreEncounter)
* section[encounterInformation] ^short = "Encounter information — admission and discharge dates, reason for admission (mandatory)"
* section[encounterInformation] ^definition = "Mandatory section covering the hospital encounter: dates, reason for admission, and type. Corresponds to EHDSDischargeReport.body.encounterInformation in Xt-EHR v1.0.0."

// ── Course of encounter (mandatory, diagnoses + procedures + pharmacotherapy + test results)
// Per Xt-EHR v1.0.0 this section is the primary clinical narrative of the admission.
* section[courseOfEncounter].code = $LOINC#11535-2 "Hospital discharge Dx Narrative"
* section[courseOfEncounter].text MS
* section[courseOfEncounter].entry MS
* section[courseOfEncounter] ^short = "Course of encounter — diagnoses, procedures, medications, and key results (mandatory)"
* section[courseOfEncounter] ^definition = "Problems treated during the encounter, significant procedures, pharmacotherapy, and key test results. Corresponds to EHDSDischargeReport.body.courseOfEncounter in Xt-EHR v1.0.0."
* section[courseOfEncounter].section ^slicing.discriminator.type = #pattern
* section[courseOfEncounter].section ^slicing.discriminator.path = "code"
* section[courseOfEncounter].section ^slicing.rules = #open
* section[courseOfEncounter].section contains
    diagnoses 0..1 MS and
    procedures 0..1 MS and
    pharmacotherapy 0..1 MS and
    testResults 0..1 MS

* section[courseOfEncounter].section[diagnoses].code = $LOINC#11535-2 "Hospital discharge Dx Narrative"
* section[courseOfEncounter].section[diagnoses].entry MS
* section[courseOfEncounter].section[diagnoses].entry only Reference(IECoreConditionEncounterDiagnosis)
* section[courseOfEncounter].section[diagnoses] ^short = "Discharge diagnoses (EHDSCondition)"

* section[courseOfEncounter].section[procedures].code = $LOINC#47519-4 "History of Procedures Document"
* section[courseOfEncounter].section[procedures].entry MS
* section[courseOfEncounter].section[procedures].entry only Reference(IECoreProcedure)
* section[courseOfEncounter].section[procedures] ^short = "Procedures performed during encounter"

// NOTE: EHDSMedicationUse maps to MedicationStatement in FHIR R4.
// When IECoreMedicationStatement is published, update the reference below.
* section[courseOfEncounter].section[pharmacotherapy].code = $LOINC#10160-0 "History of Medication use Narrative"
* section[courseOfEncounter].section[pharmacotherapy].entry MS
* section[courseOfEncounter].section[pharmacotherapy].entry only Reference(IECoreMedicationStatement or IECoreMedicationRequestEPrescription or IECoreMedicationRequest)
* section[courseOfEncounter].section[pharmacotherapy] ^short = "Significant pharmacotherapy during encounter (EHDSMedicationUse)"

* section[courseOfEncounter].section[testResults].code = $LOINC#30954-2 "Relevant diagnostic tests/laboratory data Narrative"
* section[courseOfEncounter].section[testResults].entry MS
* section[courseOfEncounter].section[testResults].entry only Reference(IECoreLaboratoryResultObservation or IECoreObservationClinicalResult or IECoreDiagnosticReportLab)
* section[courseOfEncounter].section[testResults] ^short = "Significant test results during encounter"

// ── Admission evaluation (optional) ───────────────────────────────────────
* section[admissionEvaluation].code = $LOINC#57852-6 "Problem list Reported.admit"
* section[admissionEvaluation].text MS
* section[admissionEvaluation].entry MS
* section[admissionEvaluation].entry only Reference(IECoreObservationClinicalResult or IECoreSimpleObservation or IECoreConditionProblemsHealthConcerns)
* section[admissionEvaluation] ^short = "Admission evaluation — objective findings and functional status at admission"
* section[admissionEvaluation] ^definition = "Objective findings (vital signs, physical examination) and functional status assessed at admission. Corresponds to EHDSDischargeReport.body.admissionEvaluation in Xt-EHR v1.0.0."

// ── Patient history / anamnesis (optional) ────────────────────────────────
* section[patientHistory].code = $LOINC#11329-0 "History general Narrative - Reported"
* section[patientHistory].text MS
* section[patientHistory].entry MS
* section[patientHistory].entry only Reference(IECoreConditionProblemsHealthConcerns or IECoreConditionEncounterDiagnosis or IECoreProcedure or IECoreImplantableDevice)
* section[patientHistory] ^short = "Patient health history (anamnesis) relevant to this episode of care"
* section[patientHistory] ^definition = "Past problems, relevant prior procedures, and devices/implants from the patient's history that are important for continuity of care. Corresponds to EHDSDischargeReport.body.patientHistory in Xt-EHR v1.0.0."

// ── Discharge details (optional) ──────────────────────────────────────────
* section[dischargeDetails].code = $LOINC#8648-8 "Hospital discharge note"
* section[dischargeDetails].text MS
* section[dischargeDetails].entry MS
* section[dischargeDetails].entry only Reference(IECoreObservationClinicalResult or IECoreSimpleObservation)
* section[dischargeDetails] ^short = "Discharge details — objective findings and functional status at discharge"
* section[dischargeDetails] ^definition = "Objective findings and functional status at the time of discharge. Corresponds to EHDSDischargeReport.body.dischargeDetails in Xt-EHR v1.0.0."

// ── Alerts (optional, EHDSAlert → IECoreFlag) ─────────────────────────────
* section[alerts].code = $LOINC#104605-1 "Alerts"
* section[alerts].text MS
* section[alerts].entry MS
* section[alerts].entry only Reference(IECoreFlag or IECoreAllergyIntolerance)
* section[alerts] ^short = "Alerts — substantial medical alerts or warnings (EHDSAlert)"
* section[alerts] ^definition = "Substantial alerts or warnings that health professionals should be aware of, including allergies. Added in Xt-EHR EHDSDischargeReport v1.0.0."

// ── Medication summary at discharge (optional, EHDSMedicationUse) ─────────
// NOTE: EHDSMedicationUse maps to MedicationStatement in FHIR R4.
// When IECoreMedicationStatement is published, update the reference below.
* section[medicationSummary].code = $LOINC#75311-1 "Discharge medications"
* section[medicationSummary].text MS
* section[medicationSummary].entry MS
* section[medicationSummary].entry only Reference(IECoreMedicationStatement or IECoreMedicationRequestEPrescription or IECoreMedicationRequest)
* section[medicationSummary] ^short = "Discharge medications (EHDSMedicationUse)"
* section[medicationSummary] ^definition = "Medications recommended for the post-discharge period, including newly started, changed, and discontinued medications."

// ── Care plan and recommendations post-discharge (optional) ───────────────
* section[carePlan].code = $LOINC#18776-5 "Plan of care note"
* section[carePlan].text MS
* section[carePlan].entry MS
* section[carePlan].entry only Reference(IECoreCarePlan or IECoreServiceRequest)
* section[carePlan] ^short = "Post-discharge care plan and follow-up recommendations"
