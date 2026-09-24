// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Patient Summary: Composition and Bundle                    │
// │  HIQA Draft National Standard for a Patient Summary (Sept 2026)     │
// │  ADR-004: parent HL7 Europe Patient Summary (EPS 1.0.0-ballot),     │
// │  which imposes the IPS profiles. Section slices and LOINC codes     │
// │  are inherited from EPS; none are invented here.                    │
// ╰──────────────────────────────────────────────────────────────────────╯

Profile: IECoreCompositionPatientSummary
Parent: $EUCompositionEPS
Id: ie-core-composition-patient-summary
Title: "IE Core Composition (Patient Summary)"
Description: "The Irish Patient Summary document (HIQA PS Groups 1–3, Sections 1–19), derived from the HL7 Europe Patient Summary Composition, which imposes the IPS Composition. Section slices and section codes are inherited from EPS. IE Core adds the HIQA constraints: the subject is IECorePatientSummaryPatient; every section HIQA gives an empty reason to must carry entries or an emptyReason; document provenance per HIQA PS 19.1."
* ^status = #draft

// ── 19.1 Document provenance ───────────────────────────────────────────
* subject MS
* subject only Reference(IECorePatientSummaryPatient)
* subject ^comment = "HIQA PS 19.1.1 Document subject (Mandatory 1..1); PS Section 1 Patient Details."
* identifier MS
* identifier ^comment = "HIQA PS 19.1.2 Document identifier (Mandatory 1..*). R4 Composition.identifier is 0..1; the Bundle identifier (IECoreBundlePatientSummary, 1..1) carries the stable document identifier."
* status MS
* status ^comment = "HIQA PS 19.1.5 Document status (Mandatory 1..1): e.g. preliminary, final, amended."
* type MS
* type ^comment = "HIQA PS 19.1.7 Document type (Mandatory 1..1): LOINC 60591-5 Patient summary (inherited)."
* date MS
* date ^comment = "HIQA PS 19.1.4 Document date (Mandatory 1..1)."
* author MS
* author ^comment = "HIQA PS 19.1.3 Document author (Mandatory 1..*): person, organisation or device."
* title MS
* title ^comment = "HIQA PS 19.1.8 Document title (Mandatory 1..1). HIQA: a high-level title, without detailed clinical information."
* language ^comment = "HIQA PS 19.1.6 Document language (Optional)."
* event.period ^comment = "HIQA PS 19.1.9 Document period (Optional)."
* event.code ^comment = "HIQA PS 19.1.13 Event type (Optional)."
* attester MS
* attester ^comment = "HIQA PS 19.1.11 Attestation (Optional; mode = professional) and 19.1.12 Legal authentication (Optional; mode = legal)."
* attester.party MS
* attester.party ^comment = "HIQA PS 19.1.11.1 Attester / 19.1.12.1 Legal authenticator: Mandatory within each cluster (invariant ie-ps-attester-1)."
* attester.time MS
* attester.time ^comment = "HIQA PS 19.1.11.2 / 19.1.12.2 date and time: Mandatory within each cluster (invariant ie-ps-attester-1)."
* obeys ie-ps-attester-1
* custodian MS
* custodian only Reference(IECoreOrganization)
* custodian ^comment = "HIQA PS 19.1.15 Custodian (Optional)."

// ── Group 2 sections (slices inherited from EPS) ───────────────────────
* section[sectionAlert] MS
* section[sectionAlert] ^comment = "HIQA PS Section 4 Alerts: 4.1 narrative, 4.2 empty reason (Required), 4.3 alerts (Required 0..*; Flag). Entries SHOULD also conform to IECoreFlag."
* section[sectionAlert].text MS
* section[sectionAlert].entry MS
* section[sectionAlert].emptyReason MS
* section[sectionAllergies] MS
* section[sectionAllergies] ^comment = "HIQA PS Section 5 Allergies and Intolerances: 5.2 empty reason (Required), 5.3 record entry (Required 0..*). Entries SHOULD also conform to IECoreAllergyIntolerance."
* section[sectionAllergies].text MS
* section[sectionAllergies].entry MS
* section[sectionAllergies].emptyReason MS
* section[sectionMedications] MS
* section[sectionMedications] ^comment = "HIQA PS Section 6 Medication Information: 6.2 empty reason (Required), 6.3 medication (Required). Entries SHOULD also conform to IECoreMedicationStatement."
* section[sectionMedications].text MS
* section[sectionMedications].entry MS
* section[sectionMedications].emptyReason MS
* section[sectionProblems] MS
* section[sectionProblems] ^comment = "HIQA PS Section 7 Health Conditions: 7.2 empty reason (Required), 7.3 health condition (Required 0..*). Entries SHOULD also conform to IECoreConditionProblemsHealthConcerns."
* section[sectionProblems].text MS
* section[sectionProblems].entry MS
* section[sectionProblems].emptyReason MS
* section[sectionResults] MS
* section[sectionResults] ^comment = "HIQA PS Section 8 Observation Results (8.2 Required 0..*): EU Base medical test results / HL7 Europe Laboratory where applicable."
* section[sectionResults].text MS
* section[sectionResults].entry MS
* section[sectionProceduresHx] MS
* section[sectionProceduresHx] ^comment = "HIQA PS Section 9 Procedures, Operations and Treatments: 9.2 empty reason (Required), 9.3 record entry (Required 0..*). Entries SHOULD also conform to IECoreProcedure."
* section[sectionProceduresHx].text MS
* section[sectionProceduresHx].entry MS
* section[sectionProceduresHx].emptyReason MS
* section[sectionMedicalDevices] MS
* section[sectionMedicalDevices] ^comment = "HIQA PS Section 10 Medical Devices/Implants: 10.2 empty reason (Required), 10.3 record entry (Required 0..*) as DeviceUseStatement (period of use, status, body site, reason) referencing the device (IECoreImplantableDevice)."
* section[sectionMedicalDevices].text MS
* section[sectionMedicalDevices].entry MS
* section[sectionMedicalDevices].emptyReason MS
* section[sectionPatientStory] MS
* section[sectionPatientStory] ^comment = "HIQA PS Section 11 Patient Provided Data: 11.1 patient story (Optional; narrative)."
* section[sectionPatientStory].text MS
* section[sectionSocialHistory] MS
* section[sectionSocialHistory] ^comment = "HIQA PS Section 12 Social Context: living situation (12.2), what matters to the patient (12.3), family situation (12.4) and other determinants of health (12.5) are free text in HIQA (Required) and are carried in the section narrative."
* section[sectionSocialHistory].text MS
* section[sectionAdvanceDirectives] MS
* section[sectionAdvanceDirectives] ^comment = "HIQA PS Section 13 Advance Healthcare Directive: 13.2 empty reason (Required), 13.3 AHD (Required 0..*). IE Core uses IECoreADIDocumentReference (ADR-004): under the Assisted Decision-Making (Capacity) Act 2015 an AHD is a written document, and the attachment (13.3.2) is authoritative."
* section[sectionAdvanceDirectives].text MS
* section[sectionAdvanceDirectives].entry MS
* section[sectionAdvanceDirectives].emptyReason MS
* section[sectionTravelHx] MS
* section[sectionTravelHx] ^comment = "HIQA PS Section 14 Travel History (14.2 Required 0..*): EPS travel observation (country visited, period, infectious agent)."
* section[sectionTravelHx].text MS
* section[sectionTravelHx].entry MS
* section[sectionPregnancyHx] MS
* section[sectionPregnancyHx] ^comment = "HIQA PS Section 15 Pregnancy Information: current pregnancy (15.2: status, EDD, gestational age) and pregnancy history (15.3: outcome)."
* section[sectionPregnancyHx].text MS
* section[sectionPregnancyHx].entry MS
* section[sectionImmunizations] MS
* section[sectionImmunizations] ^comment = "HIQA PS Section 16 Immunisation Information: 16.2 empty reason (Required), 16.3 immunisations (Required 0..*). Entries SHOULD also conform to IECoreImmunization."
* section[sectionImmunizations].text MS
* section[sectionImmunizations].entry MS
* section[sectionImmunizations].emptyReason MS
* section[sectionFunctionalStatus] MS
* section[sectionFunctionalStatus] ^comment = "HIQA PS Section 17 Functional Status (17.2–17.4 Required)."
* section[sectionFunctionalStatus].text MS
* section[sectionFunctionalStatus].entry MS
* section[sectionPlanOfCare] MS
* section[sectionPlanOfCare] ^comment = "HIQA PS Section 18 Care Plan (18.2 Required 0..1). Entries SHOULD also conform to IECoreCarePlan."
* section[sectionPlanOfCare].text MS
* section[sectionPlanOfCare].entry MS

* obeys ie-ps-1


Profile: IECoreBundlePatientSummary
Parent: $EUBundleEPS
Id: ie-core-bundle-patient-summary
Title: "IE Core Bundle (Patient Summary)"
Description: "The Irish Patient Summary document Bundle, derived from the HL7 Europe Patient Summary Bundle (which imposes the IPS Bundle). The first entry is IECoreCompositionPatientSummary; the patient is IECorePatientSummaryPatient. Health insurance (HIQA PS 1.3.4) travels as IECoreCoverage entries."
* ^status = #draft
* identifier 1..1 MS
* identifier ^comment = "HIQA PS 19.1.2 Document identifier (Mandatory): stable for the lifetime of the document and never reused."
* timestamp 1..1 MS
* entry[composition].resource only IECoreCompositionPatientSummary
* entry[patient].resource only IECorePatientSummaryPatient
* entry contains coverage 0..* MS
* entry[coverage].resource only IECoreCoverage
* entry[coverage] ^comment = "HIQA PS 1.3.4 Health insurance information (Required 0..*): type (1.3.4.1), policy or card number (1.3.4.2), insurer (1.3.4.3)."


Invariant: ie-ps-1
Description: "Each Patient Summary section for which HIQA defines an empty reason (alerts, allergies, medication, health conditions, procedures, devices, advance healthcare directive, immunisation) SHALL contain entries or an emptyReason (HIQA PS 4.2, 5.2, 6.2, 7.2, 9.2, 10.2, 13.2, 16.2)"
Expression: "section.where(code.coding.where(system = 'http://loinc.org' and (code = '104605-1' or code = '48765-2' or code = '10160-0' or code = '11450-4' or code = '47519-4' or code = '46264-8' or code = '42348-3' or code = '11369-6')).exists()).all(entry.exists() or emptyReason.exists())"
Severity: #error

Invariant: ie-ps-attester-1
Description: "Each attestation or legal authentication SHALL identify who attested and when (HIQA PS 19.1.11.1/.2, 19.1.12.1/.2)"
Expression: "attester.all(party.exists() and time.exists())"
Severity: #error
