// ================================================================
// IE Core Observation Profiles
// ================================================================

// ----------------------------------------------------------------
// 1. IE Core Observation Clinical Result
// ----------------------------------------------------------------
Profile: IECoreObservationClinicalResult
Parent: Observation
Id: ie-core-observation-clinical-result
Title: "IE Core Observation Clinical Result"
Description: "Constrains the Observation resource to represent clinical test results for the Irish healthcare context."
* ^status = #draft
* status MS
* category MS
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains ie-clinical-result 1..1 MS
* category[ie-clinical-result] = $ObsCat#clinical-result
* code MS
* subject 1..1 MS
* subject only Reference(Patient)
* effective[x] MS
* value[x] MS
* dataAbsentReason MS
* interpretation MS
* method MS

// ----------------------------------------------------------------
// 2. IE Core Laboratory Result Observation
// ----------------------------------------------------------------
Profile: IECoreLaboratoryResultObservation
Parent: IECoreObservationClinicalResult
Id: ie-core-laboratory-result-observation
Title: "IE Core Laboratory Result Observation"
Description: "Constrains the Observation resource to represent laboratory test results for the Irish healthcare context."
* ^status = #draft
* category contains ie-laboratory 1..1 MS
* category[ie-laboratory] = $ObsCat#laboratory
* code from IECoreLaboratoryTestCodes (extensible)
* value[x] MS
* dataAbsentReason MS
* interpretation MS
* specimen MS
* referenceRange MS

// ----------------------------------------------------------------
// 3. IE Core Simple Observation
// ----------------------------------------------------------------
Profile: IECoreSimpleObservation
Parent: Observation
Id: ie-core-simple-observation
Title: "IE Core Simple Observation"
Description: "A simplified Observation profile for general-purpose use in the Irish healthcare context."
* ^status = #draft
* status MS
* category MS
* code MS
* subject 1..1 MS
* subject only Reference(Patient)
* effective[x] MS
* value[x] MS
* dataAbsentReason MS

// ----------------------------------------------------------------
// 4. IE Core Smoking Status Observation
// ----------------------------------------------------------------
Profile: IECoreSmokingStatusObservation
Parent: Observation
Id: ie-core-smoking-status-observation
Title: "IE Core Smoking Status Observation"
Description: "Records a patient's smoking/tobacco use status in the Irish healthcare context."
* ^status = #draft
* status 1..1 MS
* code = $LOINC#72166-2 "Tobacco smoking status"
* subject 1..1 MS
* subject only Reference(Patient)
* issued MS
* value[x] 1..1 MS
* value[x] only CodeableConcept
* valueCodeableConcept from IECoreSmokingStatus (extensible)

// ----------------------------------------------------------------
// 5. IE Core Observation Sexual Orientation
// ----------------------------------------------------------------
Profile: IECoreObservationSexualOrientation
Parent: Observation
Id: ie-core-observation-sexual-orientation
Title: "IE Core Observation Sexual Orientation"
Description: "Records a patient's sexual orientation in the Irish healthcare context."
* ^status = #draft
* status MS
* code = $LOINC#76690-7 "Sexual orientation"
* subject 1..1 MS
* subject only Reference(Patient)
* value[x] 1..1
* value[x] only CodeableConcept
* valueCodeableConcept from IECoreSexualOrientationIncludingDataAbsentReason (extensible)

// ----------------------------------------------------------------
// 6. IE Core Observation Pregnancy Status
// ----------------------------------------------------------------
Profile: IECoreObservationPregnancyStatus
Parent: Observation
Id: ie-core-observation-pregnancy-status
Title: "IE Core Observation Pregnancy Status"
Description: "Records a patient's pregnancy status in the Irish healthcare context."
* ^status = #draft
* status MS
* code = $LOINC#82810-3 "Pregnancy status"
* subject 1..1 MS
* subject only Reference(Patient)
* value[x] 1..1
* value[x] only CodeableConcept
* valueCodeableConcept from IECorePregnancyStatus (extensible)

// ----------------------------------------------------------------
// 7. IE Core Observation Pregnancy Intent
// ----------------------------------------------------------------
Profile: IECoreObservationPregnancyIntent
Parent: Observation
Id: ie-core-observation-pregnancy-intent
Title: "IE Core Observation Pregnancy Intent"
Description: "Records a patient's pregnancy intent in the Irish healthcare context."
* ^status = #draft
* status MS
* code = $LOINC#86645-9 "Future pregnancy intention Reported"
* subject 1..1 MS
* subject only Reference(Patient)
* value[x] 1..1
* value[x] only CodeableConcept
* valueCodeableConcept from IECorePregnancyIntent (extensible)

// ----------------------------------------------------------------
// 8. IE Core Observation Occupation
// ----------------------------------------------------------------
Profile: IECoreObservationOccupation
Parent: Observation
Id: ie-core-observation-occupation
Title: "IE Core Observation Occupation"
Description: "Records a patient's occupation history in the Irish healthcare context."
* ^status = #draft
* status MS
* code = $LOINC#11341-5 "History of occupation"
* subject 1..1 MS
* subject only Reference(Patient)
* value[x] MS
* value[x] only CodeableConcept

// ----------------------------------------------------------------
// 9. IE Core Observation Screening Assessment
// ----------------------------------------------------------------
Profile: IECoreObservationScreeningAssessment
Parent: Observation
Id: ie-core-observation-screening-assessment
Title: "IE Core Observation Screening Assessment"
Description: "Constrains the Observation resource for screening and assessment results, including social determinants of health (SDOH), in the Irish healthcare context."
* ^status = #draft
* status MS
* category MS
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains
    ie-survey 1..1 MS and
    ie-sdoh 0..1 MS
* category[ie-survey] = $ObsCat#survey
* category[ie-sdoh] = $ObsCat#social-history
* code MS
* subject 1..1 MS
* subject only Reference(Patient)
* effective[x] MS
* performer MS
* value[x] MS
* hasMember MS
* derivedFrom MS

// ----------------------------------------------------------------
// 10. IE Core Care Experience Preference
// ----------------------------------------------------------------
Profile: IECoreCareExperiencePreference
Parent: Observation
Id: ie-core-care-experience-preference
Title: "IE Core Care Experience Preference"
Description: "Records a patient's care experience preferences in the Irish healthcare context."
* ^status = #draft
* status MS
* code = $LOINC#95541-9 "Care experience preference"
* subject 1..1 MS
* subject only Reference(Patient)
* value[x] MS

// ----------------------------------------------------------------
// 11. IE Core Treatment Intervention Preference
// ----------------------------------------------------------------
Profile: IECoreTreatmentInterventionPreference
Parent: Observation
Id: ie-core-treatment-intervention-preference
Title: "IE Core Treatment Intervention Preference"
Description: "Records a patient's treatment and intervention preferences for end-of-life care in the Irish healthcare context."
* ^status = #draft
* status MS
* code = $LOINC#75773-2 "Goals, preferences, and priorities for end of life care documentation"
* subject 1..1 MS
* subject only Reference(Patient)
* value[x] MS

// ----------------------------------------------------------------
// 12. IE Core Observation ADI Documentation
// ----------------------------------------------------------------
Profile: IECoreObservationADIDocumentation
Parent: Observation
Id: ie-core-observation-adi-documentation
Title: "IE Core Observation ADI Documentation"
Description: "Records Advance Directive Interoperability (ADI) documentation observations in the Irish healthcare context."
* ^status = #draft
* status MS
* code = $LOINC#45473-6 "Advance directive - living will"
* subject 1..1 MS
* subject only Reference(Patient)
* value[x] MS

// ----------------------------------------------------------------
// 13. IE Core Average Blood Pressure
// ----------------------------------------------------------------
Profile: IECoreAverageBloodPressure
Parent: Observation
Id: ie-core-average-blood-pressure
Title: "IE Core Average Blood Pressure"
Description: "Records average (mean) blood pressure measurements with systolic and diastolic components in the Irish healthcare context."
* ^status = #draft
* status MS
* code = $LOINC#96607-7 "Blood pressure panel mean systolic and mean diastolic"
* subject 1..1 MS
* subject only Reference(Patient)
* effective[x] MS
* value[x] MS
* component MS
* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component contains
    systolicAverage 1..1 MS and
    diastolicAverage 1..1 MS
* component[systolicAverage].code = $LOINC#96608-5 "Systolic blood pressure mean"
* component[systolicAverage].value[x] only Quantity
* component[systolicAverage].value[x] MS
* component[systolicAverage].valueQuantity.value 1..1 MS
* component[systolicAverage].valueQuantity.unit 1..1 MS
* component[systolicAverage].valueQuantity.system 1..1
* component[systolicAverage].valueQuantity.system = $UCUM
* component[systolicAverage].valueQuantity.code 1..1
* component[systolicAverage].valueQuantity.code = #mm[Hg]
* component[diastolicAverage].code = $LOINC#96609-3 "Diastolic blood pressure mean"
* component[diastolicAverage].value[x] only Quantity
* component[diastolicAverage].value[x] MS
* component[diastolicAverage].valueQuantity.value 1..1 MS
* component[diastolicAverage].valueQuantity.unit 1..1 MS
* component[diastolicAverage].valueQuantity.system 1..1
* component[diastolicAverage].valueQuantity.system = $UCUM
* component[diastolicAverage].valueQuantity.code 1..1
* component[diastolicAverage].valueQuantity.code = #mm[Hg]
