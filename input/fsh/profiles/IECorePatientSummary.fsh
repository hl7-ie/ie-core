// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Patient Summary Profile                                   │
// │  Aligned with: IPS, HL7 Europe PS, Xt-EHR EHDSPatientSummary 1.0.0│
// ╰──────────────────────────────────────────────────────────────────────╯

Profile: IECoreCompositionPatientSummary
Parent: Composition
Id: ie-core-composition-patient-summary
Title: "IE Core Composition (Patient Summary)"
Description: "Profile for the Irish Patient Summary document, aligned with the International Patient Summary (IPS), the HL7 Europe Patient Summary IG, and the Xt-EHR EHDSPatientSummary logical model v1.0.0. The Patient Summary provides a snapshot of essential clinical information for unplanned cross-border care and continuity of care within Ireland."

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

// ── Section slicing ─────────────────────────────────────────────────────────
// Sections marked 1..1 are mandatory per Xt-EHR EHDSPatientSummary v1.0.0.
// All mandatory sections SHALL carry an emptyReason when no entries are present.
* section ^slicing.discriminator.type = #pattern
* section ^slicing.discriminator.path = "code"
* section ^slicing.rules = #open
* section contains
    medications 1..1 MS and
    allergies 1..1 MS and
    problems 1..1 MS and
    procedures 1..1 MS and
    medicalDevices 1..1 MS and
    immunizations 0..1 MS and
    observationResults 0..1 MS and
    vitalSigns 0..1 MS and
    pastIllnesses 0..1 MS and
    alerts 0..1 MS and
    functionalStatus 0..1 MS and
    socialHistory 0..1 MS and
    pregnancyHistory 0..1 MS and
    travelHistory 0..1 MS and
    advanceDirectives 0..1 MS and
    carePlans 0..1 MS and
    patientStory 0..1 MS

// ── Medication summary (mandatory, EHDSMedicationUse) ──────────────────────
// NOTE: FHIR R4 uses MedicationStatement for EHDSMedicationUse.
// When the IE Core MedicationStatement profile (IECoreMedicationStatement) is
// published, the entry reference below should be updated to include it.
* section[medications].code = $LOINC#10160-0 "History of Medication use Narrative"
* section[medications].text MS
* section[medications].entry MS
* section[medications].entry only Reference(IECoreMedicationStatement or IECoreMedicationRequest or IECoreMedicationDispense)
* section[medications].emptyReason MS
* section[medications].emptyReason ^short = "Why no medication entries are present (e.g. no-known-medications, not-asked)"
* section[medications] ^short = "Medication summary — current and relevant past medications"
* section[medications] ^definition = "Current and relevant past medicines. Per Xt-EHR EHDSPatientSummary v1.0.0 this section is mandatory; an emptyReason SHALL be provided when no entries are present."

// ── Allergies and intolerances (mandatory) ─────────────────────────────────
* section[allergies].code = $LOINC#48765-2 "Allergies and adverse reactions Document"
* section[allergies].text MS
* section[allergies].entry MS
* section[allergies].entry only Reference(IECoreAllergyIntolerance)
* section[allergies].emptyReason MS
* section[allergies].emptyReason ^short = "Why no allergy entries are present (e.g. no-known-allergies, not-asked)"
* section[allergies] ^short = "Allergies and intolerances"

// ── Medical problems (mandatory) ───────────────────────────────────────────
* section[problems].code = $LOINC#11450-4 "Problem list - Reported"
* section[problems].text MS
* section[problems].entry MS
* section[problems].entry only Reference(IECoreConditionProblemsHealthConcerns)
* section[problems].emptyReason MS
* section[problems] ^short = "Active problems and conditions"

// ── Procedures (mandatory per EHDSPatientSummary v1.0.0) ──────────────────
* section[procedures].code = $LOINC#47519-4 "History of Procedures Document"
* section[procedures].text MS
* section[procedures].entry MS
* section[procedures].entry only Reference(IECoreProcedure)
* section[procedures].emptyReason MS
* section[procedures] ^short = "History of significant procedures"
* section[procedures] ^definition = "Significant procedures performed on the patient. Per Xt-EHR EHDSPatientSummary v1.0.0 this section is mandatory; an emptyReason SHALL be provided when no entries are present."

// ── Medical devices and implants (mandatory per EHDSPatientSummary v1.0.0) ─
// NOTE: EHDSDeviceUse maps to DeviceUseStatement in FHIR R4.
// When an IE Core DeviceUseStatement profile is published, update this entry.
* section[medicalDevices].code = $LOINC#46264-8 "History of medical device use"
* section[medicalDevices].text MS
* section[medicalDevices].entry MS
* section[medicalDevices].entry only Reference(IECoreImplantableDevice)
* section[medicalDevices].emptyReason MS
* section[medicalDevices] ^short = "Implanted and relevant medical devices (mandatory)"
* section[medicalDevices] ^definition = "Devices that are implanted in the patient and external medical devices the patient's health depends on. Per Xt-EHR EHDSPatientSummary v1.0.0 this section is mandatory; an emptyReason SHALL be provided when no device entries are present."

// ── Immunizations (optional) ───────────────────────────────────────────────
* section[immunizations].code = $LOINC#11369-6 "History of Immunization Narrative"
* section[immunizations].text MS
* section[immunizations].entry MS
* section[immunizations].entry only Reference(IECoreImmunization)
* section[immunizations] ^short = "Immunization history"

// ── Observation results (optional, replaces 'results') ────────────────────
* section[observationResults].code = $LOINC#30954-2 "Relevant diagnostic tests/laboratory data Narrative"
* section[observationResults].text MS
* section[observationResults].entry MS
* section[observationResults].entry only Reference(IECoreDiagnosticReportLab or IECoreLaboratoryResultObservation or IECoreObservationClinicalResult)
* section[observationResults] ^short = "Relevant observation and diagnostic results"

// ── Vital signs (optional) ─────────────────────────────────────────────────
* section[vitalSigns].code = $LOINC#8716-3 "Vital signs"
* section[vitalSigns].text MS
* section[vitalSigns].entry MS
* section[vitalSigns] ^short = "Vital signs"

// ── Past illnesses (optional) ──────────────────────────────────────────────
* section[pastIllnesses].code = $LOINC#11348-0 "History of Past illness Narrative"
* section[pastIllnesses].text MS
* section[pastIllnesses].entry MS
* section[pastIllnesses].entry only Reference(IECoreConditionProblemsHealthConcerns)
* section[pastIllnesses] ^short = "Past medical history"

// ── Alerts (optional, EHDSAlert → IECoreFlag) ─────────────────────────────
* section[alerts].code = $LOINC#104605-1 "Alerts"
* section[alerts].text MS
* section[alerts].entry MS
* section[alerts].entry only Reference(IECoreFlag)
* section[alerts] ^short = "Alerts — substantial medical alerts or warnings (EHDSAlert)"
* section[alerts] ^definition = "Substantial alerts or warnings that health professionals should be aware of. Added in Xt-EHR EHDSPatientSummary v1.0.0. Maps to the FHIR Flag resource via IECoreFlag."

// ── Functional status (optional, EHDSCondition + EHDSObservation) ─────────
* section[functionalStatus].code = $LOINC#47420-5 "Functional status assessment note"
* section[functionalStatus].text MS
* section[functionalStatus].entry MS
* section[functionalStatus].entry only Reference(IECoreConditionProblemsHealthConcerns or IECoreSimpleObservation)
* section[functionalStatus] ^short = "Functional status — ability to perform normal daily activities"
* section[functionalStatus] ^definition = "An individual's ability to perform normal daily activities. Added in Xt-EHR EHDSPatientSummary v1.0.0. Represented as conditions and/or observations."

// ── Social history (optional, EHDSObservation) ────────────────────────────
* section[socialHistory].code = $LOINC#29762-2 "Social history Narrative"
* section[socialHistory].text MS
* section[socialHistory].entry MS
* section[socialHistory].entry only Reference(IECoreSimpleObservation or IECoreObservationClinicalResult)
* section[socialHistory] ^short = "Social history — lifestyle factors relevant to health (EHDSObservation)"
* section[socialHistory] ^definition = "Health-related lifestyle factors such as tobacco use, alcohol consumption, or social determinants of health. Added in Xt-EHR EHDSPatientSummary v1.0.0."

// ── Pregnancy history (optional, EHDSCurrentPregnancy + EHDSPregnancyHistory)
* section[pregnancyHistory].code = $LOINC#10162-6 "History of pregnancies Narrative"
* section[pregnancyHistory].text MS
* section[pregnancyHistory].entry MS
* section[pregnancyHistory].entry only Reference(IECoreObservationPregnancyStatus or IECoreSimpleObservation)
* section[pregnancyHistory] ^short = "Pregnancy history (current status and past pregnancies)"

// ── Travel history (optional, EHDSTravelHistory) ──────────────────────────
* section[travelHistory].code = $LOINC#10182-4 "History of Travel"
* section[travelHistory].text MS
* section[travelHistory].entry MS
* section[travelHistory].entry only Reference(IECoreSimpleObservation)
* section[travelHistory] ^short = "Recent travel history relevant to clinical care (EHDSTravelHistory)"
* section[travelHistory] ^definition = "Clinically relevant travel history, e.g. exposure to infectious diseases. Added in Xt-EHR EHDSPatientSummary v1.0.0."

// ── Advance directives (optional, EHDSAdvanceDirective) ───────────────────
// NOTE: EHDSAdvanceDirective maps to Consent or DocumentReference in FHIR R4.
* section[advanceDirectives].code = $LOINC#42348-3 "Advance directives"
* section[advanceDirectives].text MS
* section[advanceDirectives].entry MS
* section[advanceDirectives].entry only Reference(IECoreADIDocumentReference)
* section[advanceDirectives] ^short = "Advance directives (EHDSAdvanceDirective)"
* section[advanceDirectives] ^definition = "Provisions for healthcare decisions if the patient is unable to make those decisions. Added in Xt-EHR EHDSPatientSummary v1.0.0."

// ── Care plans (optional, EHDSCarePlan) ───────────────────────────────────
* section[carePlans].code = $LOINC#18776-5 "Plan of care note"
* section[carePlans].text MS
* section[carePlans].entry MS
* section[carePlans].entry only Reference(IECoreCarePlan)
* section[carePlans] ^short = "Care plans and therapeutic recommendations (EHDSCarePlan)"

// ── Patient story (optional, narrative only) ──────────────────────────────
* section[patientStory].code = $LOINC#81338-6 "Patient story"
* section[patientStory].text MS
* section[patientStory] ^short = "Patient story — the patient's own perspective on their health (narrative only)"
* section[patientStory] ^definition = "A concise narrative from the patient's perspective. Added in Xt-EHR EHDSPatientSummary v1.0.0 (ISO IPS source)."
