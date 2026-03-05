// ============================================================================
// IE Core ValueSets
// Ireland (IE) Core FHIR Implementation Guide
// Canonical: http://hl7.hse.ie/fhir/ie/core
// FHIR R4 (4.0.1)
// ============================================================================

// --- Standard Code System Aliases ---
Alias: $SCT = http://snomed.info/sct
Alias: $LOINC = http://loinc.org
Alias: $RXNORM = http://www.nlm.nih.gov/research/umls/rxnorm
Alias: $CVX = http://hl7.org/fhir/sid/cvx
Alias: $ATC = http://www.whocc.no/atc
Alias: $ICD10PCS = http://www.cms.gov/Medicare/Coding/ICD10
Alias: $V2-0074 = http://terminology.hl7.org/CodeSystem/v2-0074
Alias: $V2-0136 = http://terminology.hl7.org/CodeSystem/v2-0136
Alias: $V2-0203 = http://terminology.hl7.org/CodeSystem/v2-0203
Alias: $V2-0493 = http://terminology.hl7.org/CodeSystem/v2-0493
Alias: $V3-NULLFLAVOR = http://terminology.hl7.org/CodeSystem/v3-NullFlavor
Alias: $OBSERVATION-CATEGORY = http://terminology.hl7.org/CodeSystem/observation-category
Alias: $CONDITION-CATEGORY = http://terminology.hl7.org/CodeSystem/condition-category
Alias: $NARRATIVE-STATUS = http://hl7.org/fhir/narrative-status
Alias: $OBSERVATION-STATUS = http://hl7.org/fhir/observation-status
Alias: $PROVENANCE-PARTICIPANT-TYPE = http://terminology.hl7.org/CodeSystem/provenance-participant-type
Alias: $DATA-ABSENT-REASON = http://terminology.hl7.org/CodeSystem/data-absent-reason
Alias: $COVERAGE-TYPE = http://terminology.hl7.org/CodeSystem/v3-ActCode
Alias: $LOCATION-ROLE-TYPE = http://terminology.hl7.org/CodeSystem/v3-ServiceDeliveryLocationRoleType
Alias: $MEDICATION-ADHERENCE = http://hl7.org/fhir/CodeSystem/medication-statement-adherence

// --- IE Core Code System Aliases ---
Alias: $IE-CS = http://hl7.hse.ie/fhir/ie/core/CodeSystem/ie-core-codesystem
Alias: $IE-CONDITION-CAT = http://hl7.hse.ie/fhir/ie/core/CodeSystem/ie-core-condition-category
Alias: $IE-PROVENANCE = http://hl7.hse.ie/fhir/ie/core/CodeSystem/ie-core-provenance-participant-type-codes
Alias: $IE-TAGS = http://hl7.hse.ie/fhir/ie/core/CodeSystem/ie-core-tags
Alias: $IE-DOCREF-CAT = http://hl7.hse.ie/fhir/ie/core/CodeSystem/ie-core-documentreference-category-codes
Alias: $IE-SCREENING = http://hl7.hse.ie/fhir/ie/core/CodeSystem/ie-core-screening-assessment-codes
Alias: $IE-COUNTY = http://hl7.hse.ie/fhir/ie/core/CodeSystem/ie-core-county-codes
Alias: $IE-ETHNICITY = http://hl7.hse.ie/fhir/ie/core/CodeSystem/ie-core-ethnicity-codes
Alias: $IE-IHI-STATUS = http://hl7.hse.ie/fhir/ie/core/CodeSystem/ie-core-ihi-status-codes
Alias: $IE-IHI-RECORD = http://hl7.hse.ie/fhir/ie/core/CodeSystem/ie-core-ihi-record-status-codes


// ============================================================================
// 1. Ireland Counties
// ============================================================================
ValueSet: IECoreCounties
Id: ie-core-counties
Title: "Ireland Counties"
Description: "The 26 counties of the Republic of Ireland."
* ^experimental = false
* include codes from system $IE-COUNTY

// ============================================================================
// 2. IE Core Ethnicity
// ============================================================================
ValueSet: IECoreEthnicity
Id: ie-core-ethnicity
Title: "IE Core Ethnicity"
Description: "Ethnicity categories for use in the Irish health system, based on CSO census categories."
* ^experimental = false
* include codes from system $IE-ETHNICITY

// ============================================================================
// 3. IE Core Gender Identity
// ============================================================================
ValueSet: IECoreGenderIdentity
Id: ie-core-gender-identity
Title: "IE Core Gender Identity"
Description: "Gender identity concepts for use in the IE Core Implementation Guide."
* ^experimental = false
* $SCT#446141000124107 "Identifies as female gender"
* $SCT#446151000124109 "Identifies as male gender"
* $SCT#33791000087105 "Identifies as nonbinary gender"
* $SCT#407377000 "Female-to-male transsexual"
* $SCT#407376009 "Male-to-female transsexual"
* $SCT#394743007 "Gender identity unknown"
* $DATA-ABSENT-REASON#asked-declined "Asked But Declined"

// ============================================================================
// 4. Yes No and Unknowns
// ============================================================================
ValueSet: IECoreYesNoUnknowns
Id: ie-core-yes-no-unknowns
Title: "Yes No and Unknowns"
Description: "Yes, No, and Unknown answer codes for use in the IE Core Implementation Guide."
* ^experimental = false
* $V2-0136#Y "Yes"
* $V2-0136#N "No"
* $DATA-ABSENT-REASON#asked-unknown "Asked But Unknown"
* $DATA-ABSENT-REASON#temp-unknown "Temporarily Unknown"
* $DATA-ABSENT-REASON#not-asked "Not Asked"
* $DATA-ABSENT-REASON#asked-declined "Asked But Declined"

// ============================================================================
// 5. IHI Status
// ============================================================================
ValueSet: IECoreIHIStatus
Id: ie-core-ihi-status
Title: "IHI Status"
Description: "Status values for Individual Health Identifiers (IHI)."
* ^experimental = false
* include codes from system $IE-IHI-STATUS

// ============================================================================
// 6. IHI Record Status
// ============================================================================
ValueSet: IECoreIHIRecordStatus
Id: ie-core-ihi-record-status
Title: "IHI Record Status"
Description: "Record-level status values for Individual Health Identifier (IHI) records."
* ^experimental = false
* include codes from system $IE-IHI-RECORD

// ============================================================================
// 7. Allergy Intolerance Set
// ============================================================================
ValueSet: IECoreAllergyIntoleranceSet
Id: ie-core-allergy-intolerance-set
Title: "IE Core Allergy Intolerance Set"
Description: "Codes for substances and clinical findings related to allergies and intolerances."
* ^experimental = false
* include codes from system $SCT where concept is-a #105590001 "Substance"
* include codes from system $SCT where concept is-a #418038007 "Propensity to adverse reactions to substance"
* include codes from system $SCT where concept is-a #373873005 "Pharmaceutical / biologic product"

// ============================================================================
// 8. Condition Codes
// ============================================================================
ValueSet: IECoreConditionCode
Id: ie-core-condition-code
Title: "IE Core Condition Codes"
Description: "Condition codes drawn from SNOMED CT clinical finding hierarchy."
* ^experimental = false
* include codes from system $SCT where concept is-a #404684003 "Clinical finding"

// ============================================================================
// 9. Procedure Codes
// ============================================================================
ValueSet: IECoreProcedureCode
Id: ie-core-procedure-code
Title: "IE Core Procedure Codes"
Description: "Procedure codes drawn from SNOMED CT procedure hierarchy and ICD-10-PCS."
* ^experimental = false
* include codes from system $SCT where concept is-a #71388002 "Procedure"
* include codes from system $ICD10PCS

// ============================================================================
// 10. Encounter Type
// ============================================================================
ValueSet: IECoreEncounterType
Id: ie-core-encounter-type
Title: "IE Core Encounter Type"
Description: "Encounter type codes for categorising patient encounters."
* ^experimental = false
* include codes from system $SCT where concept is-a #308335008 "Patient encounter procedure"
* $SCT#11429006 "Consultation"
* $SCT#281036007 "Follow-up consultation"
* $SCT#185347001 "Encounter for problem"
* $SCT#50849002 "Emergency room admission"
* $SCT#270427003 "Patient-initiated encounter"
* $SCT#185349003 "Encounter for check up"
* $SCT#439740005 "Postoperative follow-up visit"

// ============================================================================
// 11. Discharge Disposition
// ============================================================================
ValueSet: IECoreDischargeDisposition
Id: ie-core-discharge-disposition
Title: "IE Core Discharge Disposition"
Description: "Discharge disposition codes indicating patient destination upon discharge."
* ^experimental = false
* $SCT#306689006 "Discharge to home"
* $SCT#306691003 "Discharge to residential home"
* $SCT#306694006 "Discharge to nursing home"
* $SCT#306705005 "Discharge to convalescent hospital"
* $SCT#19712007 "Patient transfer, to another health care facility"
* $SCT#225928004 "Transfer of patient to another care unit"
* $SCT#306706006 "Discharge to hospice"
* $SCT#75004002 "Emergency hospital admission"
* $SCT#73770003 "Emergency department discharge"
* $SCT#371827001 "Patient deceased during stay"
* $SCT#58000006 "Patient discharge, alive"
* $SCT#397709008 "Patient died"

// ============================================================================
// 12. Medication Codes
// ============================================================================
ValueSet: IECoreMedicationCodes
Id: ie-core-medication-codes
Title: "IE Core Medication Codes"
Description: "Medication codes for the Irish healthcare system. SNOMED CT is the primary clinical terminology as recommended by HIQA and adopted by eHealth Ireland. ATC (WHO) codes are included for international classification and EU cross-border interoperability (EHDS/MyHealth@EU)."
* ^experimental = false
* include codes from system $SCT where concept descendent-of #373873005 "Pharmaceutical / biologic product (product)"
* include codes from system $ATC

// ============================================================================
// 13. Vaccines
// ============================================================================
ValueSet: IECoreVaccines
Id: ie-core-vaccines
Title: "IE Core Vaccines"
Description: "Vaccine codes from the CDC CVX code system."
* ^experimental = false
* include codes from system $CVX

// ============================================================================
// 14. Laboratory Test Codes
// ============================================================================
ValueSet: IECoreLaboratoryTestCodes
Id: ie-core-laboratory-test-codes
Title: "IE Core Laboratory Test Codes"
Description: "Laboratory test codes from LOINC for use in diagnostic observations."
* ^experimental = false
* include codes from system $LOINC

// ============================================================================
// 15. Specimen Type
// ============================================================================
ValueSet: IECoreSpecimenType
Id: ie-core-specimen-type
Title: "IE Core Specimen Type"
Description: "Specimen type codes drawn from the SNOMED CT specimen hierarchy."
* ^experimental = false
* include codes from system $SCT where concept is-a #123038009 "Specimen"

// ============================================================================
// 16. Specimen Condition
// ============================================================================
ValueSet: IECoreSpecimenCondition
Id: ie-core-specimen-condition
Title: "IE Core Specimen Condition"
Description: "HL7 v2 specimen condition codes describing the state of a specimen."
* ^experimental = false
* include codes from system $V2-0493

// ============================================================================
// 17. Vital Sign Result Type
// ============================================================================
ValueSet: IECoreVitalSignResultType
Id: ie-core-vital-sign-result-type
Title: "IE Core Vital Sign Result Type"
Description: "LOINC codes identifying vital sign observation types."
* ^experimental = false
* $LOINC#85354-9 "Blood pressure panel with all children optional"
* $LOINC#8480-6 "Systolic blood pressure"
* $LOINC#8462-4 "Diastolic blood pressure"
* $LOINC#8867-4 "Heart rate"
* $LOINC#9279-1 "Respiratory rate"
* $LOINC#8310-5 "Body temperature"
* $LOINC#29463-7 "Body weight"
* $LOINC#8302-2 "Body height"
* $LOINC#39156-5 "Body mass index (BMI) [Ratio]"
* $LOINC#59408-5 "Oxygen saturation in Arterial blood by Pulse oximetry"
* $LOINC#8287-5 "Head Occipital-frontal circumference by Tape measure"
* $LOINC#59576-9 "Body mass index (BMI) [Percentile] Per age and sex"
* $LOINC#77606-2 "Weight-for-length Per age and sex"
* $LOINC#96607-7 "Blood pressure panel mean systolic and mean diastolic"

// ============================================================================
// 18. Narrative Status
// ============================================================================
ValueSet: IECoreNarrativeStatus
Id: ie-core-narrative-status
Title: "IE Core Narrative Status"
Description: "Allowed narrative status codes for IE Core resources."
* ^experimental = false
* $NARRATIVE-STATUS#generated "Generated"
* $NARRATIVE-STATUS#additional "Additional"

// ============================================================================
// 19. Smoking Status
// ============================================================================
ValueSet: IECoreSmokingStatus
Id: ie-core-smoking-status
Title: "IE Core Smoking Status"
Description: "SNOMED CT codes representing a patient's smoking status."
* ^experimental = false
* $SCT#449868002 "Current every day smoker"
* $SCT#428041000124106 "Occasional tobacco smoker"
* $SCT#8517006 "Former smoker"
* $SCT#266919005 "Never smoked tobacco"
* $SCT#77176002 "Smoker, current status unknown"
* $SCT#266927001 "Tobacco smoking consumption unknown"
* $SCT#428071000124103 "Heavy tobacco smoker"
* $SCT#428061000124105 "Light tobacco smoker"

// ============================================================================
// 20. Smoking Status Comprehensive
// ============================================================================
ValueSet: IECoreSmokingStatusComprehensive
Id: ie-core-smoking-status-comprehensive
Title: "IE Core Smoking Status Comprehensive"
Description: "Comprehensive set of SNOMED CT codes for tobacco use and smoking status."
* ^experimental = false
* include codes from system $SCT where concept is-a #365980008 "Finding of tobacco use and exposure"
* $SCT#449868002 "Current every day smoker"
* $SCT#428041000124106 "Occasional tobacco smoker"
* $SCT#8517006 "Former smoker"
* $SCT#266919005 "Never smoked tobacco"
* $SCT#77176002 "Smoker, current status unknown"
* $SCT#266927001 "Tobacco smoking consumption unknown"
* $SCT#428071000124103 "Heavy tobacco smoker"
* $SCT#428061000124105 "Light tobacco smoker"
* $SCT#428081000124100 "Tobacco smoker"
* $SCT#160618006 "Current non-smoker but past smoking history unknown"
* $SCT#735128000 "Current occasional tobacco smoker"
* $SCT#160616005 "Trying to give up smoking"

// ============================================================================
// 21. Smoking Status Type
// ============================================================================
ValueSet: IECoreSmokingStatusType
Id: ie-core-smoking-status-type
Title: "IE Core Smoking Status Type"
Description: "LOINC observation codes used to identify the type of smoking status observation."
* ^experimental = false
* $LOINC#72166-2 "Tobacco smoking status"
* $LOINC#11367-0 "History of Tobacco use"

// ============================================================================
// 22. Survey Codes
// ============================================================================
ValueSet: IECoreSurveyCodes
Id: ie-core-survey-codes
Title: "IE Core Survey Codes"
Description: "LOINC survey and screening panel codes for structured assessments."
* ^experimental = false
* $LOINC#44249-1 "PHQ-9 quick depression assessment panel"
* $LOINC#69725-0 "GAD-7 Anxiety"
* $LOINC#72109-2 "Alcohol Use Disorder Identification Test - Consumption"
* $LOINC#71354-5 "AUDIT-C Total score"
* $LOINC#96777-8 "Accountable health communities health-related social needs screening tool"
* $LOINC#97023-6 "Accountable health communities health-related social needs supplemental questions"
* $LOINC#76504-0 "CAGE Substance abuse screening"
* $LOINC#62199-5 "Mental health screening assessment"
* $LOINC#73831-0 "Adolescent depression screening assessment"
* $LOINC#89206-7 "Fitness assessment panel"

// ============================================================================
// 23. Simple Observation Category
// ============================================================================
ValueSet: IECoreSimpleObservationCategory
Id: ie-core-simple-observation-category
Title: "IE Core Simple Observation Category"
Description: "Observation category codes permitted for IE Core Simple Observations."
* ^experimental = false
* $OBSERVATION-CATEGORY#social-history "Social History"
* $OBSERVATION-CATEGORY#survey "Survey"
* $OBSERVATION-CATEGORY#activity "Activity"
* $OBSERVATION-CATEGORY#vital-signs "Vital Signs"
* $OBSERVATION-CATEGORY#exam "Exam"
* $OBSERVATION-CATEGORY#therapy "Therapy"

// ============================================================================
// 24. Clinical Result Observation Category
// ============================================================================
ValueSet: IECoreClinicalResultObservationCategory
Id: ie-core-clinical-result-observation-category
Title: "IE Core Clinical Result Observation Category"
Description: "Observation category codes for clinical result observations."
* ^experimental = false
* $OBSERVATION-CATEGORY#laboratory "Laboratory"
* $OBSERVATION-CATEGORY#exam "Exam"
* $OBSERVATION-CATEGORY#imaging "Imaging"
* $OBSERVATION-CATEGORY#procedure "Procedure"
* $OBSERVATION-CATEGORY#vital-signs "Vital Signs"

// ============================================================================
// 25. Screening Assessment Observation Category
// ============================================================================
ValueSet: IECoreScreeningAssessmentObservationCategory
Id: ie-core-screening-assessment-observation-category
Title: "IE Core Screening Assessment Observation Category"
Description: "Observation category codes for screening and assessment observations."
* ^experimental = false
* $OBSERVATION-CATEGORY#survey "Survey"
* $IE-SCREENING#sdoh "Social Determinants of Health"

// ============================================================================
// 26. Screening Assessment Condition Category
// ============================================================================
ValueSet: IECoreScreeningAssessmentConditionCategory
Id: ie-core-screening-assessment-condition-category
Title: "IE Core Screening Assessment Condition Category"
Description: "Condition category codes for screening and assessment related conditions."
* ^experimental = false
* $IE-CONDITION-CAT#health-concern "Health Concern"

// ============================================================================
// 27. Sexual Orientation including Data Absent Reason
// ============================================================================
ValueSet: IECoreSexualOrientationIncludingDataAbsentReason
Id: ie-core-sexual-orientation-including-data-absent-reason
Title: "IE Core Sexual Orientation"
Description: "Sexual orientation concepts including data absent reason codes."
* ^experimental = false
* $SCT#20430005 "Heterosexual"
* $SCT#38628009 "Homosexual"
* $SCT#42035005 "Bisexual"
* $SCT#472986005 "Sexually attracted to neither male nor female sex"
* $V3-NULLFLAVOR#OTH "Other"
* $V3-NULLFLAVOR#ASKU "Asked but unknown"
* $V3-NULLFLAVOR#UNK "Unknown"

// ============================================================================
// 28. Pregnancy Status Codes
// ============================================================================
ValueSet: IECorePregnancyStatus
Id: ie-core-pregnancy-status
Title: "IE Core Pregnancy Status Codes"
Description: "SNOMED CT codes for reporting a patient's pregnancy status."
* ^experimental = false
* $SCT#77386006 "Pregnant"
* $SCT#60001007 "Not pregnant"
* $SCT#261665006 "Unknown"

// ============================================================================
// 29. Pregnancy Intent Codes
// ============================================================================
ValueSet: IECorePregnancyIntent
Id: ie-core-pregnancy-intent
Title: "IE Core Pregnancy Intent Codes"
Description: "Codes indicating a patient's pregnancy intention."
* ^experimental = false
* $SCT#454381000124105 "Intends to become pregnant"
* $SCT#454391000124108 "Does not intend to become pregnant"
* $SCT#454401000124105 "Ambivalent about becoming pregnant"
* $V3-NULLFLAVOR#UNK "Unknown"

// ============================================================================
// 30. Goal Codes
// ============================================================================
ValueSet: IECoreGoalCodes
Id: ie-core-goal-codes
Title: "IE Core Goal Codes"
Description: "SNOMED CT goal and target codes for care planning."
* ^experimental = false
* include codes from system $SCT where concept is-a #410518001 "Goal"

// ============================================================================
// 31. Payer Type
// ============================================================================
ValueSet: IECorePayerType
Id: ie-core-payer-type
Title: "IE Core Payer Type"
Description: "Payer type codes relevant to the Irish health system including HSE schemes and private coverage."
* ^experimental = false
* $COVERAGE-TYPE#PUBLICPOL "Public healthcare"
* $COVERAGE-TYPE#SUBSIDIZ "Subsidized health program"
* $COVERAGE-TYPE#EHCPOL "Extended healthcare"
* $COVERAGE-TYPE#pay "Pay"
* $SCT#310151008 "Medical card holder"
* $SCT#310152001 "GP visit card holder"
* $SCT#413195004 "Drug payment scheme"
* $SCT#394733004 "Long term illness scheme"
* $SCT#36629006 "Private health insurance"

// ============================================================================
// 32. Healthcare Provider Taxonomy
// ============================================================================
ValueSet: IECoreHealthcareProviderTaxonomy
Id: ie-core-healthcare-provider-taxonomy
Title: "IE Core Healthcare Provider Taxonomy"
Description: "Healthcare provider taxonomy codes for categorising provider specialties and roles."
* ^experimental = false
* include codes from system $SCT where concept is-a #223366009 "Healthcare professional"
* include codes from system $SCT where concept is-a #394658006 "Clinical specialty"

// ============================================================================
// 33. Provenance Participant Type
// ============================================================================
ValueSet: IECoreProvenanceParticipantType
Id: ie-core-provenance-participant-type
Title: "IE Core Provenance Participant Type"
Description: "Provenance participant type codes including IE Core specific types."
* ^experimental = false
* include codes from system $PROVENANCE-PARTICIPANT-TYPE
* $IE-PROVENANCE#transmitter "Transmitter"

// ============================================================================
// 34. Clinical Note Type
// ============================================================================
ValueSet: IECoreClinicalNoteType
Id: ie-core-clinical-note-type
Title: "IE Core Clinical Note Type"
Description: "LOINC document type codes for clinical notes."
* ^experimental = false
* $LOINC#18842-5 "Discharge summary"
* $LOINC#11488-4 "Consultation note"
* $LOINC#34117-2 "History and physical note"
* $LOINC#11506-3 "Progress note"
* $LOINC#28570-0 "Procedure note"
* $LOINC#57133-1 "Referral note"
* $LOINC#18761-7 "Transfer summary note"
* $LOINC#34133-9 "Summarization of episode note"

// ============================================================================
// 35. DocumentReference Type
// ============================================================================
ValueSet: IECoreDocumentReferenceType
Id: ie-core-documentreference-type
Title: "IE Core DocumentReference Type"
Description: "LOINC document type codes for typed DocumentReference resources."
* ^experimental = false
* $LOINC#18842-5 "Discharge summary"
* $LOINC#11488-4 "Consultation note"
* $LOINC#34117-2 "History and physical note"
* $LOINC#11506-3 "Progress note"
* $LOINC#28570-0 "Procedure note"
* $LOINC#57133-1 "Referral note"
* $LOINC#18761-7 "Transfer summary note"
* $LOINC#34133-9 "Summarization of episode note"
* $LOINC#34746-8 "Nurse Note"
* $LOINC#11502-2 "Laboratory report"
* $LOINC#18748-4 "Diagnostic imaging study"
* $LOINC#57016-8 "Privacy policy acknowledgment Document"
* $LOINC#57017-6 "Privacy policy Organization Document"
* $LOINC#64290-0 "Health insurance card"

// ============================================================================
// 36. DocumentReference Category
// ============================================================================
ValueSet: IECoreDocumentReferenceCategory
Id: ie-core-documentreference-category
Title: "IE Core DocumentReference Category"
Description: "Category codes for DocumentReference resources."
* ^experimental = false
* include codes from system $IE-DOCREF-CAT

// ============================================================================
// 37. Diagnostic Report Category
// ============================================================================
ValueSet: IECoreDiagnosticReportCategory
Id: ie-core-diagnosticreport-category
Title: "IE Core Diagnostic Report Category"
Description: "Category codes for DiagnosticReport resources."
* ^experimental = false
* $V2-0074#LAB "Laboratory"
* $V2-0074#RAD "Radiology"
* $V2-0074#CUS "Cardiac Ultrasound"
* $V2-0074#CT "CAT Scan"
* $V2-0074#NMR "Nuclear Magnetic Resonance"
* $V2-0074#NMS "Nuclear Medicine Scan"
* $V2-0074#MYC "Mycology"
* $V2-0074#PAT "Pathology"
* $V2-0074#SP "Surgical Pathology"
* $LOINC#LP29684-5 "Radiology"
* $LOINC#LP29708-2 "Cardiology"
* $LOINC#LP7839-6 "Pathology"

// ============================================================================
// 38. Non Laboratory Diagnostic Report and Note Codes
// ============================================================================
ValueSet: IECoreDiagnosticReportReportAndNoteCodes
Id: ie-core-diagnosticreport-report-and-note-codes
Title: "IE Core Non Laboratory Diagnostic Report and Note Codes"
Description: "LOINC codes for non-laboratory diagnostic reports and clinical notes."
* ^experimental = false
* $LOINC#18842-5 "Discharge summary"
* $LOINC#11488-4 "Consultation note"
* $LOINC#34117-2 "History and physical note"
* $LOINC#11506-3 "Progress note"
* $LOINC#28570-0 "Procedure note"
* $LOINC#57133-1 "Referral note"
* $LOINC#18748-4 "Diagnostic imaging study"
* $LOINC#59768-2 "Procedure report"
* $LOINC#18745-0 "Cardiac catheterization study"
* $LOINC#59770-8 "Procedure reason report"
* $LOINC#47039-3 "Inpatient Admission history and physical note"
* $LOINC#34746-8 "Nurse Note"

// ============================================================================
// 39. Care Team Member Function
// ============================================================================
ValueSet: IECoreCareTeamMemberFunction
Id: ie-core-care-team-member-function
Title: "IE Core Care Team Member Function"
Description: "SNOMED CT codes for care team member functions and roles."
* ^experimental = false
* include codes from system $SCT where concept is-a #223366009 "Healthcare professional"
* $SCT#446050000 "Primary care provider"
* $SCT#768819009 "Consultant"
* $SCT#224535009 "Registered nurse"
* $SCT#307988006 "Medical registrar"
* $SCT#158965000 "Doctor"
* $SCT#36682004 "Physiotherapist"
* $SCT#80546007 "Occupational therapist"
* $SCT#106289002 "Dentist"
* $SCT#46255001 "Pharmacist"
* $SCT#159026005 "Speech and language therapist"
* $SCT#224529009 "Clinical nurse specialist"
* $SCT#224540001 "Community nurse"
* $SCT#28229004 "Optometrist"
* $SCT#21450003 "Neuropsychologist"
* $SCT#224587008 "Community midwife"
* $SCT#309343006 "Physician"
* $SCT#159033005 "Dietitian"
* $SCT#224570006 "Clinical psychologist"

// ============================================================================
// 40. ServiceRequest Category
// ============================================================================
ValueSet: IECoreServiceRequestCategory
Id: ie-core-servicerequest-category
Title: "IE Core ServiceRequest Category"
Description: "Category codes for ServiceRequest resources."
* ^experimental = false
* $SCT#108252007 "Laboratory procedure"
* $SCT#363679005 "Imaging"
* $SCT#409063005 "Counselling"
* $SCT#409073007 "Education"
* $SCT#387713003 "Surgical procedure"
* $SCT#103693007 "Diagnostic procedure"
* $SCT#3457005 "Patient referral"
* $SCT#386053000 "Evaluation procedure"

// ============================================================================
// 41. Medication Adherence
// ============================================================================
ValueSet: IECoreMedicationAdherence
Id: ie-core-medication-adherence
Title: "IE Core Medication Adherence"
Description: "Codes indicating a patient's medication adherence status."
* ^experimental = false
* $SCT#275929009 "Compliant - making progress towards goals"
* $SCT#275928001 "Non-compliant - Loss to follow-up"
* $SCT#266710000 "Drugs not taken/completed"
* $SCT#182890002 "Patient requests drug"
* $SCT#182834008 "Drug course completed"
* $SCT#182840001 "Drug treatment stopped - medical advice"
* $SCT#182841002 "Doctor stopped drugs - Loss to follow-up"
* $SCT#182845006 "Drug treatment not indicated"

// ============================================================================
// 42. Information Source for Medication Adherence
// ============================================================================
ValueSet: IECoreInformationSourceForMedicationAdherence
Id: ie-core-information-source-for-medication-adherence
Title: "IE Core Information Source for Medication Adherence"
Description: "Codes identifying the source of medication adherence information."
* ^experimental = false
* $SCT#116154003 "Patient"
* $SCT#394572006 "Medical secretary"
* $SCT#158965000 "Doctor"
* $SCT#224535009 "Registered nurse"
* $SCT#46255001 "Pharmacist"
* $SCT#125677006 "Relative"
* $SCT#394863008 "Non-clinical staff"

// ============================================================================
// 43. Location Type
// ============================================================================
ValueSet: IECoreLocationType
Id: ie-core-location-type
Title: "IE Core Location Type"
Description: "Codes for classifying healthcare delivery location types."
* ^experimental = false
* include codes from system $LOCATION-ROLE-TYPE
* $SCT#22232009 "Hospital"
* $SCT#264372000 "Pharmacy"
* $SCT#257622000 "Healthcare facility"
* $SCT#264358009 "General practice premises"
* $SCT#309898008 "Outpatient department"
* $SCT#225728007 "Accident and Emergency department"
* $SCT#702871004 "Community health centre"

// ============================================================================
// 44. Problem or Health Concern
// ============================================================================
ValueSet: IECoreProblemOrHealthConcern
Id: ie-core-problem-or-health-concern
Title: "IE Core Problem or Health Concern"
Description: "Condition category codes indicating whether a condition is a problem-list item or a health concern."
* ^experimental = false
* $CONDITION-CATEGORY#problem-list-item "Problem List Item"
* $IE-CONDITION-CAT#health-concern "Health Concern"

// ============================================================================
// 45. Advance Directives Content Type
// ============================================================================
ValueSet: IECoreAdvanceDirectivesContentType
Id: ie-core-advance-directives-content-type
Title: "IE Core Advance Directives Content Type"
Description: "LOINC codes for advance directive document content types."
* ^experimental = false
* $LOINC#75320-2 "Advance directive"
* $LOINC#81334-5 "Patient Personal advance care plan"
* $LOINC#86533-7 "Patient Living will"
* $LOINC#92664-2 "Power of attorney"
* $LOINC#81335-2 "Patient Healthcare agent"
* $LOINC#77599-9 "Additional documentation"
* $LOINC#81340-2 "Goals, preferences, and priorities for medical treatment"
* $LOINC#81336-0 "Patient Consent for participation in healthcare research"

// ============================================================================
// 46. Advance Healthcare Directive Categories
// ============================================================================
ValueSet: IECoreAdvanceHealthcareDirectiveCategoriesGrouper
Id: ie-core-advance-healthcare-directive-categories-grouper
Title: "IE Core Advance Healthcare Directive Categories"
Description: "Grouper value set for advance healthcare directive document categories."
* ^experimental = false
* $LOINC#42348-3 "Advance directives"
* $LOINC#75320-2 "Advance directive"
* $LOINC#81334-5 "Patient Personal advance care plan"
* $LOINC#81335-2 "Patient Healthcare agent"
* $LOINC#92664-2 "Power of attorney"
* $LOINC#86533-7 "Patient Living will"

// ============================================================================
// 47. Observation Smoking Status
// ============================================================================
ValueSet: IECoreObservationSmokingStatus
Id: ie-core-observation-smoking-status
Title: "IE Core Status for Smoking Status Observation"
Description: "Observation status values permitted for smoking status observations."
* ^experimental = false
* $OBSERVATION-STATUS#final "Final"
* $OBSERVATION-STATUS#entered-in-error "Entered in Error"

// ============================================================================
// 48. Alcohol Drinking Status
// ============================================================================
ValueSet: IECoreAlcoholDrinkingStatus
Id: ie-core-alcohol-drinking-status
Title: "IE Core Alcohol Drinking Status"
Description: "SNOMED CT codes representing a patient's alcohol drinking status."
* ^experimental = false
* include codes from system $SCT where concept is-a #228273003 "Finding relating to alcohol drinking behavior"
* $SCT#219006 "Current drinker of alcohol"
* $SCT#228276006 "Occasional drinker"
* $SCT#228277002 "Heavy drinker"
* $SCT#228278007 "Very heavy drinker"
* $SCT#228274009 "Drinks alcohol daily"
* $SCT#105542008 "Current non-drinker of alcohol"
* $SCT#82581004 "Former drinker"
* $SCT#160573003 "Alcohol intake unknown"
* $SCT#711338006 "Never consumed alcohol"

// ============================================================================
// 49. hl7VS-identifierType IE Extended
// ============================================================================
ValueSet: IECoreV20203Extended
Id: ie-core-v2-0203-extended
Title: "hl7VS-identifierType IE Extended"
Description: "Extended HL7 v2 identifier type codes including Ireland-specific identifier types."
* ^experimental = false
* include codes from system $V2-0203
* $V2-0203#MR "Medical record number"
* $V2-0203#NI "National unique individual identifier"
* $V2-0203#PPN "Passport number"
* $V2-0203#SS "Social Security number"
* $V2-0203#DL "Driver's license number"
* $V2-0203#TAX "Tax ID number"
* $V2-0203#DR "Donor Registration Number"
* $V2-0203#EN "Employer number"
* $V2-0203#MD "Medical License number"
