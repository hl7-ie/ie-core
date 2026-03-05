// ================================================================
// IE Core Vital Signs Profiles
// ================================================================

// ----------------------------------------------------------------
// 1. IE Core Vital Signs (Base)
// ----------------------------------------------------------------
Profile: IECoreVitalSigns
Parent: http://hl7.org/fhir/StructureDefinition/vitalsigns
Id: ie-core-vital-signs
Title: "IE Core Vital Signs"
Description: "Base vital signs profile for the Irish healthcare context. Inherits from the FHIR Vital Signs base profile."
* ^status = #draft
* status MS
* category MS
* code MS
* subject MS
* subject only Reference(Patient)
* effective[x] MS
* value[x] MS
* dataAbsentReason MS
* component MS

// ----------------------------------------------------------------
// 2. IE Core Blood Pressure
// ----------------------------------------------------------------
Profile: IECoreBloodPressure
Parent: IECoreVitalSigns
Id: ie-core-blood-pressure
Title: "IE Core Blood Pressure"
Description: "Records blood pressure observations with systolic and diastolic components in the Irish healthcare context."
* ^status = #draft
* code = $LOINC#85354-9 "Blood pressure panel with all children optional"
* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component contains
    systolic 1..1 MS and
    diastolic 1..1 MS
* component[systolic].code = $LOINC#8480-6 "Systolic blood pressure"
* component[systolic].value[x] only Quantity
* component[systolic].value[x] MS
* component[systolic].valueQuantity.value 1..1 MS
* component[systolic].valueQuantity.unit 1..1 MS
* component[systolic].valueQuantity.system 1..1
* component[systolic].valueQuantity.system = $UCUM
* component[systolic].valueQuantity.code 1..1
* component[systolic].valueQuantity.code = #mm[Hg]
* component[diastolic].code = $LOINC#8462-4 "Diastolic blood pressure"
* component[diastolic].value[x] only Quantity
* component[diastolic].value[x] MS
* component[diastolic].valueQuantity.value 1..1 MS
* component[diastolic].valueQuantity.unit 1..1 MS
* component[diastolic].valueQuantity.system 1..1
* component[diastolic].valueQuantity.system = $UCUM
* component[diastolic].valueQuantity.code 1..1
* component[diastolic].valueQuantity.code = #mm[Hg]

// ----------------------------------------------------------------
// 3. IE Core BMI
// ----------------------------------------------------------------
Profile: IECoreBMI
Parent: IECoreVitalSigns
Id: ie-core-bmi
Title: "IE Core BMI"
Description: "Records Body Mass Index (BMI) observations in the Irish healthcare context."
* ^status = #draft
* code = $LOINC#39156-5 "Body mass index (BMI) [Ratio]"
* value[x] only Quantity
* valueQuantity MS
* valueQuantity.value 1..1 MS
* valueQuantity.unit 1..1 MS
* valueQuantity.system 1..1
* valueQuantity.system = $UCUM
* valueQuantity.code 1..1
* valueQuantity.code = #kg/m2

// ----------------------------------------------------------------
// 4. IE Core Body Height
// ----------------------------------------------------------------
Profile: IECoreBodyHeight
Parent: IECoreVitalSigns
Id: ie-core-body-height
Title: "IE Core Body Height"
Description: "Records body height/length observations in the Irish healthcare context. Accepted UCUM units: [in_i] (inches) or cm (centimetres)."
* ^status = #draft
* code = $LOINC#8302-2 "Body height"
* value[x] only Quantity
* valueQuantity MS
* valueQuantity.value 1..1 MS
* valueQuantity.unit 1..1 MS
* valueQuantity.system 1..1
* valueQuantity.system = $UCUM
* valueQuantity.code 1..1

// ----------------------------------------------------------------
// 5. IE Core Body Weight
// ----------------------------------------------------------------
Profile: IECoreBodyWeight
Parent: IECoreVitalSigns
Id: ie-core-body-weight
Title: "IE Core Body Weight"
Description: "Records body weight observations in the Irish healthcare context. Accepted UCUM units: [lb_av] (pounds) or kg (kilograms)."
* ^status = #draft
* code = $LOINC#29463-7 "Body weight"
* value[x] only Quantity
* valueQuantity MS
* valueQuantity.value 1..1 MS
* valueQuantity.unit 1..1 MS
* valueQuantity.system 1..1
* valueQuantity.system = $UCUM
* valueQuantity.code 1..1

// ----------------------------------------------------------------
// 6. IE Core Body Temperature
// ----------------------------------------------------------------
Profile: IECoreBodyTemperature
Parent: IECoreVitalSigns
Id: ie-core-body-temperature
Title: "IE Core Body Temperature"
Description: "Records body temperature observations in the Irish healthcare context. Accepted UCUM units: Cel (Celsius) or [degF] (Fahrenheit)."
* ^status = #draft
* code = $LOINC#8310-5 "Body temperature"
* value[x] only Quantity
* valueQuantity MS
* valueQuantity.value 1..1 MS
* valueQuantity.unit 1..1 MS
* valueQuantity.system 1..1
* valueQuantity.system = $UCUM
* valueQuantity.code 1..1

// ----------------------------------------------------------------
// 7. IE Core Head Circumference
// ----------------------------------------------------------------
Profile: IECoreHeadCircumference
Parent: IECoreVitalSigns
Id: ie-core-head-circumference
Title: "IE Core Head Circumference"
Description: "Records head circumference observations in the Irish healthcare context."
* ^status = #draft
* code = $LOINC#9843-4 "Head Occipital-frontal circumference"
* value[x] only Quantity
* valueQuantity MS
* valueQuantity.value 1..1 MS
* valueQuantity.unit 1..1 MS
* valueQuantity.system 1..1
* valueQuantity.system = $UCUM
* valueQuantity.code 1..1

// ----------------------------------------------------------------
// 8. IE Core Heart Rate
// ----------------------------------------------------------------
Profile: IECoreHeartRate
Parent: IECoreVitalSigns
Id: ie-core-heart-rate
Title: "IE Core Heart Rate"
Description: "Records heart rate observations in the Irish healthcare context."
* ^status = #draft
* code = $LOINC#8867-4 "Heart rate"
* value[x] only Quantity
* valueQuantity MS
* valueQuantity.value 1..1 MS
* valueQuantity.unit 1..1 MS
* valueQuantity.system 1..1
* valueQuantity.system = $UCUM
* valueQuantity.code 1..1
* valueQuantity.code = #/min

// ----------------------------------------------------------------
// 9. IE Core Respiratory Rate
// ----------------------------------------------------------------
Profile: IECoreRespiratoryRate
Parent: IECoreVitalSigns
Id: ie-core-respiratory-rate
Title: "IE Core Respiratory Rate"
Description: "Records respiratory rate observations in the Irish healthcare context."
* ^status = #draft
* code = $LOINC#9279-1 "Respiratory rate"
* value[x] only Quantity
* valueQuantity MS
* valueQuantity.value 1..1 MS
* valueQuantity.unit 1..1 MS
* valueQuantity.system 1..1
* valueQuantity.system = $UCUM
* valueQuantity.code 1..1
* valueQuantity.code = #/min

// ----------------------------------------------------------------
// 10. IE Core Pulse Oximetry
// ----------------------------------------------------------------
Profile: IECorePulseOximetry
Parent: IECoreVitalSigns
Id: ie-core-pulse-oximetry
Title: "IE Core Pulse Oximetry"
Description: "Records pulse oximetry (SpO2) observations with optional flow rate and concentration components in the Irish healthcare context."
* ^status = #draft
* code = $LOINC#59408-5 "Oxygen saturation in Arterial blood by Pulse oximetry"
* value[x] only Quantity
* valueQuantity MS
* valueQuantity.value 1..1 MS
* valueQuantity.unit 1..1 MS
* valueQuantity.system 1..1
* valueQuantity.system = $UCUM
* valueQuantity.code 1..1
* valueQuantity.code = #%
* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component contains
    flowRate 0..1 MS and
    concentration 0..1 MS
* component[flowRate].code = $LOINC#3151-8 "Inhaled oxygen flow rate"
* component[flowRate].value[x] only Quantity
* component[flowRate].value[x] MS
* component[flowRate].valueQuantity.value 1..1 MS
* component[flowRate].valueQuantity.unit 1..1 MS
* component[flowRate].valueQuantity.system 1..1
* component[flowRate].valueQuantity.system = $UCUM
* component[flowRate].valueQuantity.code 1..1
* component[flowRate].valueQuantity.code = #L/min
* component[concentration].code = $LOINC#3150-0 "Inhaled oxygen concentration"
* component[concentration].value[x] only Quantity
* component[concentration].value[x] MS
* component[concentration].valueQuantity.value 1..1 MS
* component[concentration].valueQuantity.unit 1..1 MS
* component[concentration].valueQuantity.system 1..1
* component[concentration].valueQuantity.system = $UCUM
* component[concentration].valueQuantity.code 1..1
* component[concentration].valueQuantity.code = #%

// ----------------------------------------------------------------
// 11. IE Core Pediatric BMI for Age
// ----------------------------------------------------------------
Profile: IECorePediatricBMIForAge
Parent: IECoreVitalSigns
Id: ie-core-pediatric-bmi-for-age
Title: "IE Core Pediatric BMI for Age"
Description: "Records pediatric BMI-for-age percentile observations in the Irish healthcare context."
* ^status = #draft
* code = $LOINC#59576-9 "Body mass index (BMI) [Percentile] Per age and sex"
* value[x] only Quantity
* valueQuantity MS
* valueQuantity.value 1..1 MS
* valueQuantity.unit 1..1 MS
* valueQuantity.system 1..1
* valueQuantity.system = $UCUM
* valueQuantity.code 1..1
* valueQuantity.code = #%

// ----------------------------------------------------------------
// 12. IE Core Pediatric Weight for Height
// ----------------------------------------------------------------
Profile: IECorePediatricWeightForHeight
Parent: IECoreVitalSigns
Id: ie-core-pediatric-weight-for-height
Title: "IE Core Pediatric Weight for Height"
Description: "Records pediatric weight-for-height percentile observations in the Irish healthcare context."
* ^status = #draft
* code = $LOINC#77606-2 "Weight-for-length Per age and sex"
* value[x] only Quantity
* valueQuantity MS
* valueQuantity.value 1..1 MS
* valueQuantity.unit 1..1 MS
* valueQuantity.system 1..1
* valueQuantity.system = $UCUM
* valueQuantity.code 1..1
* valueQuantity.code = #%

// ----------------------------------------------------------------
// 13. IE Core Head Occipital Frontal Circumference Percentile
// ----------------------------------------------------------------
Profile: IECoreHeadOccipitalFrontalCircumferencePercentile
Parent: IECoreVitalSigns
Id: ie-core-head-occipital-frontal-circumference-percentile
Title: "IE Core Head Occipital Frontal Circumference Percentile"
Description: "Records head occipital-frontal circumference percentile observations in the Irish healthcare context."
* ^status = #draft
* code = $LOINC#8289-1 "Head Occipital-frontal circumference Percentile"
* value[x] only Quantity
* valueQuantity MS
* valueQuantity.value 1..1 MS
* valueQuantity.unit 1..1 MS
* valueQuantity.system 1..1
* valueQuantity.system = $UCUM
* valueQuantity.code 1..1
* valueQuantity.code = #%
