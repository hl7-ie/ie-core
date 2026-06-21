// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Cross-Border ePrescription Examples                         │
// │  Patient: Seán Patrick Murphy (IE)                                  │
// │  Scenarios: IE→DE, IE→ES, IE→FR, IE→NL, IE→LV, IE→PT, IE→DK,       │
// │             IE→SE, IE→AT + Inbound FI→IE, BE→IE, DE→IE (via NePS)   │
// │  Aligned with: MyHealth@EU, eHDSI, EHDS, HL7 Europe MPD IG, xt-EHR  │
// ╰──────────────────────────────────────────────────────────────────────╯


// ====================================================================
// SEÁN MURPHY – CORE PATIENT DEMOGRAPHICS
// ====================================================================

Instance: ie-core-patient-sean-murphy
InstanceOf: IECorePatient
Usage: #example
Title: "Patient – Seán Patrick Murphy (Irish, cross-border scenarios)"
Description: "Seán Patrick Murphy, an Irish patient with Type 2 Diabetes, Essential Hypertension, and Hypercholesterolaemia. Carries an Irish PPS number, IHI, GMS number and eIDAS identity used in cross-border ePrescription exchange via MyHealth@EU."

* identifier[0].system = $IHI
* identifier[=].type = $V2-0203#NI "National unique individual identifier"
* identifier[=].value = "210000000099887766"

* identifier[+].system = $GMS
* identifier[=].type = $V2-0203#MC "Patient's Medicare number"
* identifier[=].value = "1234567T"

* identifier[+].system = $PPS
* identifier[=].type = $V2-0203#JHN "Jurisdictional health number"
* identifier[=].value = "1234567T"

// eIDAS cross-border identifiers (one per destination country)
* identifier[+].system = "http://eidas.europa.eu/attributes/naturalperson/PersonIdentifier"
* identifier[=].type = $V2-0203#NI "National unique individual identifier"
* identifier[=].value = "IE/DE/1234567T"

* active = true
* name[0].use = #official
* name[=].family = "Murphy"
* name[=].given[0] = "Seán"
* name[=].given[+] = "Patrick"
* name[=].prefix = "Mr."

* gender = #male
* birthDate = "1975-03-15"

* address[0].use = #home
* address[=].type = #physical
* address[=].line[0] = "14 Grafton Street"
* address[=].city = "Dublin 2"
* address[=].state = "Dublin"
* address[=].postalCode = "D02 XY45"
* address[=].country = "IE"

* telecom[0].system = #phone
* telecom[=].value = "+353 87 900 1234"
* telecom[=].use = #mobile
* telecom[+].system = #email
* telecom[=].value = "sean.murphy@example.ie"
* telecom[=].use = #home

* communication[0].language = urn:ietf:bcp:47#en "English"
* communication[=].preferred = true
* communication[+].language = urn:ietf:bcp:47#ga "Irish"


// ====================================================================
// GP – DR. AOIFE O'BRIEN, GRAFTON STREET MEDICAL PRACTICE
// ====================================================================

Instance: ie-core-practitioner-aoife-obrien
InstanceOf: IECorePractitioner
Usage: #example
Title: "Practitioner – Dr. Aoife O'Brien (GP, Dublin)"
Description: "Dr. Aoife O'Brien, General Practitioner at Grafton Street Medical Practice, Dublin. Prescribing physician for Seán Murphy's cross-border prescriptions."

* identifier[0].system = $IMC
* identifier[=].type = $V2-0203#MD "Medical License number"
* identifier[=].value = "GP-IE-12345"

* active = true
* name[0].use = #official
* name[=].family = "O'Brien"
* name[=].given = "Aoife"
* name[=].prefix = "Dr."
* gender = #female

* telecom[0].system = #phone
* telecom[=].value = "+353 1 677 1234"
* telecom[=].use = #work
* telecom[+].system = #email
* telecom[=].value = "aoife.obrien@graftonmedical.ie"
* telecom[=].use = #work

* address[0].use = #work
* address[=].line = "14 Grafton Street"
* address[=].city = "Dublin 2"
* address[=].postalCode = "D02 XY45"
* address[=].country = "IE"

* qualification[0].code = $SCT#62247001 "General practitioner"
* qualification[=].issuer.display = "Irish Medical Council"


Instance: ie-core-organization-grafton-medical
InstanceOf: IECoreOrganization
Usage: #example
Title: "Organization – Grafton Street Medical Practice"
Description: "Grafton Street Medical Practice, Dublin 2 — GP practice from which Seán Murphy's prescriptions are issued."

* identifier[0].system = $CRN
* identifier[=].value = "IE-GP-GSMP-001"
* identifier[+].system = $HPI
* identifier[=].value = "HPI-IE-ORG-GP-0001"

* active = true
* type = http://terminology.hl7.org/CodeSystem/organization-type#prov "Healthcare Provider"
* name = "Grafton Street Medical Practice"

* telecom[0].system = #phone
* telecom[=].value = "+353 1 677 1234"
* telecom[=].use = #work
* telecom[+].system = #email
* telecom[=].value = "info@graftonmedical.ie"
* telecom[=].use = #work

* address[0].use = #work
* address[=].type = #physical
* address[=].line = "14 Grafton Street"
* address[=].city = "Dublin 2"
* address[=].postalCode = "D02 XY45"
* address[=].country = "IE"


// ====================================================================
// ALLERGY – PENICILLIN / AMOXICILLIN (ANAPHYLAXIS)
// ====================================================================

Instance: ie-core-allergy-penicillin-murphy
InstanceOf: IECoreAllergyIntolerance
Usage: #example
Title: "AllergyIntolerance – Penicillin/Amoxicillin Anaphylaxis (Seán Murphy)"
Description: "CRITICAL ALLERGY: Seán Murphy has a documented severe anaphylactic reaction to Penicillin and Amoxicillin (penicillin-class antibiotics). First documented 1995. Do NOT dispense penicillin-class antibiotics."

* clinicalStatus = http://terminology.hl7.org/CodeSystem/allergyintolerance-clinical#active "Active"
* verificationStatus = http://terminology.hl7.org/CodeSystem/allergyintolerance-verification#confirmed "Confirmed"
* type = #allergy
* category = #medication
* criticality = #high

* code = $SCT#372687004 "Amoxicillin"
* code.text = "Penicillin / Amoxicillin (ALL penicillin-class antibiotics)"

* patient = Reference(ie-core-patient-sean-murphy) "Seán Murphy"
* onsetDateTime = "1995-01-01"
* recordedDate = "2010-06-01"

* reaction[0].substance = $SCT#372687004 "Amoxicillin"
* reaction[=].manifestation = $SCT#39579001 "Anaphylaxis"
* reaction[=].severity = #severe
* reaction[=].description = "Anaphylaxis. Do NOT dispense penicillin-class antibiotics."
* reaction[=].note[0].text = "Patient carries an EpiPen. Allergy first documented 1995 following hospitalisation."


// ====================================================================
// CONDITIONS
// ====================================================================

Instance: ie-core-condition-t2dm-murphy
InstanceOf: IECoreConditionProblemsHealthConcerns
Usage: #example
Title: "Condition – Type 2 Diabetes Mellitus (Seán Murphy)"
Description: "Type 2 Diabetes Mellitus (ICD-10: E11 / SNOMED: 44054006). Active since 2018. Managed with Metformin 500mg."

* clinicalStatus = http://terminology.hl7.org/CodeSystem/condition-clinical#active
* verificationStatus = http://terminology.hl7.org/CodeSystem/condition-ver-status#confirmed
* category = http://terminology.hl7.org/CodeSystem/condition-category#problem-list-item
* severity = $SCT#6736007 "Moderate"
* code.coding[0].system = $SCT
* code.coding[=].code = #44054006
* code.coding[=].display = "Diabetes mellitus type 2"
* code.coding[+].system = "http://hl7.org/fhir/sid/icd-10"
* code.coding[=].code = #E11
* code.coding[=].display = "Type 2 diabetes mellitus"
* code.text = "Type 2 Diabetes Mellitus"
* subject = Reference(ie-core-patient-sean-murphy) "Seán Murphy"
* onsetDateTime = "2018-03-10"
* recordedDate = "2018-03-10"


Instance: ie-core-condition-hypertension-murphy
InstanceOf: IECoreConditionProblemsHealthConcerns
Usage: #example
Title: "Condition – Essential Hypertension (Seán Murphy)"
Description: "Essential Hypertension (ICD-10: I10 / SNOMED: 38341003). Active since 2019. Managed with Lisinopril 10mg."

* clinicalStatus = http://terminology.hl7.org/CodeSystem/condition-clinical#active
* verificationStatus = http://terminology.hl7.org/CodeSystem/condition-ver-status#confirmed
* category = http://terminology.hl7.org/CodeSystem/condition-category#problem-list-item
* code.coding[0].system = $SCT
* code.coding[=].code = #38341003
* code.coding[=].display = "Hypertensive disorder"
* code.coding[+].system = "http://hl7.org/fhir/sid/icd-10"
* code.coding[=].code = #I10
* code.coding[=].display = "Essential (primary) hypertension"
* code.text = "Essential Hypertension"
* subject = Reference(ie-core-patient-sean-murphy) "Seán Murphy"
* onsetDateTime = "2019-05-22"
* recordedDate = "2019-05-22"


Instance: ie-core-condition-hypercholesterolaemia-murphy
InstanceOf: IECoreConditionProblemsHealthConcerns
Usage: #example
Title: "Condition – Hypercholesterolaemia (Seán Murphy)"
Description: "Hypercholesterolaemia (ICD-10: E78.5 / SNOMED: 13644009). Active since 2020. Managed with Atorvastatin 20mg."

* clinicalStatus = http://terminology.hl7.org/CodeSystem/condition-clinical#active
* verificationStatus = http://terminology.hl7.org/CodeSystem/condition-ver-status#confirmed
* category = http://terminology.hl7.org/CodeSystem/condition-category#problem-list-item
* code.coding[0].system = $SCT
* code.coding[=].code = #13644009
* code.coding[=].display = "Hypercholesterolemia"
* code.coding[+].system = "http://hl7.org/fhir/sid/icd-10"
* code.coding[=].code = #E78.5
* code.coding[=].display = "Hypercholesterolaemia"
* code.text = "Hypercholesterolaemia"
* subject = Reference(ie-core-patient-sean-murphy) "Seán Murphy"
* onsetDateTime = "2020-01-15"
* recordedDate = "2020-01-15"


// ====================================================================
// MEDICATIONS – SEÁN MURPHY'S CHRONIC MEDICATIONS
// ====================================================================

Instance: ie-medication-lisinopril-10
InstanceOf: IECoreMedicationEPrescription
Usage: #example
Title: "Medication – Lisinopril 10mg Tablets (ATC: C09AA03)"
Description: "Lisinopril 10mg tablets, ACE inhibitor for hypertension. NMPC is primary, SNOMED CT is secondary, and ATC code C09AA03 is included for classification."

* code.coding[0].system = $NMPC
* code.coding[=].code = #NMPC-LIS10TAB
* code.coding[=].display = "Lisinopril 10mg tablets"
* code.coding[+].system = $SCT
* code.coding[=].code = #386873009
* code.coding[=].display = "Lisinopril"
* code.coding[+].system = $ATC
* code.coding[=].code = #C09AA03
* code.coding[=].display = "Lisinopril"
* code.text = "Lisinopril 10mg tablets"
* form = $SCT#385055001 "Tablet"
* amount.numerator = 28 '{tablet}' "tablets"
* amount.denominator = 1 '{pack}' "pack"
* ingredient[0].itemCodeableConcept = $SCT#386873009 "Lisinopril"
* ingredient[=].isActive = true
* ingredient[=].strength.numerator = 10 'mg' "mg"
* ingredient[=].strength.denominator = 1 '{tablet}' "tablet"


Instance: ie-medication-warfarin-5
InstanceOf: IECoreMedicationEPrescription
Usage: #example
Title: "Medication – Warfarin 5mg Tablets (ATC: B01AA03)"
Description: "Warfarin sodium 5mg tablets, anticoagulant. NMPC is primary, SNOMED CT is secondary, and ATC code B01AA03 is included for classification. Requires INR monitoring."

* code.coding[0].system = $NMPC
* code.coding[=].code = #NMPC-WAR5TAB
* code.coding[=].display = "Warfarin 5mg tablets"
* code.coding[+].system = $SCT
* code.coding[=].code = #372756006
* code.coding[=].display = "Warfarin"
* code.coding[+].system = $ATC
* code.coding[=].code = #B01AA03
* code.coding[=].display = "Warfarin"
* code.text = "Warfarin 5mg tablets"
* form = $SCT#385055001 "Tablet"
* amount.numerator = 28 '{tablet}' "tablets"
* amount.denominator = 1 '{pack}' "pack"
* ingredient[0].itemCodeableConcept = $SCT#372756006 "Warfarin"
* ingredient[=].isActive = true
* ingredient[=].strength.numerator = 5 'mg' "mg"
* ingredient[=].strength.denominator = 1 '{tablet}' "tablet"


Instance: ie-medication-insulin-glargine
InstanceOf: IECoreMedicationEPrescription
Usage: #example
Title: "Medication – Insulin Glargine 100u/ml Injection (ATC: A10AE04)"
Description: "Insulin glargine 100 units/ml solution for injection, long-acting basal insulin. NMPC is primary, SNOMED CT is secondary, and ATC code A10AE04 is included for classification."

* code.coding[0].system = $NMPC
* code.coding[=].code = #NMPC-INSGLAR100
* code.coding[=].display = "Insulin glargine 100 units/ml solution for injection"
* code.coding[+].system = $SCT
* code.coding[=].code = #411529005
* code.coding[=].display = "Insulin glargine"
* code.coding[+].system = $ATC
* code.coding[=].code = #A10AE04
* code.coding[=].display = "Insulin glargine"
* code.text = "Insulin Glargine 100u/ml solution for injection"
* form = $SCT#385219001 "Solution for injection"
* amount.numerator = 5 '{cartridge}' "cartridges"
* amount.denominator = 1 '{pack}' "pack"
* ingredient[0].itemCodeableConcept = $SCT#411529005 "Insulin glargine"
* ingredient[=].isActive = true
* ingredient[=].strength.numerator = 100 'U/mL' "units/mL"
* ingredient[=].strength.denominator = 1 'mL' "mL"


Instance: ie-medication-insulin-aspart
InstanceOf: IECoreMedicationEPrescription
Usage: #example
Title: "Medication – Insulin Aspart 100u/ml Injection (ATC: A10AB05)"
Description: "Insulin aspart 100 units/ml solution for injection, rapid-acting insulin. NMPC is primary, SNOMED CT is secondary, and ATC code A10AB05 is included for classification."

* code.coding[0].system = $NMPC
* code.coding[=].code = #NMPC-INSASP100
* code.coding[=].display = "Insulin aspart 100 units/ml solution for injection"
* code.coding[+].system = $SCT
* code.coding[=].code = #325072002
* code.coding[=].display = "Insulin aspart"
* code.coding[+].system = $ATC
* code.coding[=].code = #A10AB05
* code.coding[=].display = "Insulin aspart"
* code.text = "Insulin Aspart 100u/ml solution for injection"
* form = $SCT#385219001 "Solution for injection"
* amount.numerator = 5 '{cartridge}' "cartridges"
* amount.denominator = 1 '{pack}' "pack"
* ingredient[0].itemCodeableConcept = $SCT#325072002 "Insulin aspart"
* ingredient[=].isActive = true
* ingredient[=].strength.numerator = 100 'U/mL' "units/mL"
* ingredient[=].strength.denominator = 1 'mL' "mL"


Instance: ie-medication-sertraline-50
InstanceOf: IECoreMedicationEPrescription
Usage: #example
Title: "Medication – Sertraline 50mg Tablets (ATC: N06AB06)"
Description: "Sertraline hydrochloride 50mg tablets, SSRI antidepressant. NMPC is primary, SNOMED CT is secondary, and ATC code N06AB06 is included for classification."

* code.coding[0].system = $NMPC
* code.coding[=].code = #NMPC-SER50TAB
* code.coding[=].display = "Sertraline 50mg tablets"
* code.coding[+].system = $SCT
* code.coding[=].code = #372594008
* code.coding[=].display = "Sertraline"
* code.coding[+].system = $ATC
* code.coding[=].code = #N06AB06
* code.coding[=].display = "Sertraline"
* code.text = "Sertraline 50mg tablets"
* form = $SCT#385055001 "Tablet"
* amount.numerator = 28 '{tablet}' "tablets"
* amount.denominator = 1 '{pack}' "pack"
* ingredient[0].itemCodeableConcept = $SCT#372594008 "Sertraline"
* ingredient[=].isActive = true
* ingredient[=].strength.numerator = 50 'mg' "mg"
* ingredient[=].strength.denominator = 1 '{tablet}' "tablet"


Instance: ie-medication-omeprazole-20
InstanceOf: IECoreMedicationEPrescription
Usage: #example
Title: "Medication – Omeprazole 20mg Capsules (ATC: A02BC01)"
Description: "Omeprazole 20mg gastro-resistant capsules, proton pump inhibitor. NMPC is primary, SNOMED CT is secondary, and ATC code A02BC01 is included for classification."

* code.coding[0].system = $NMPC
* code.coding[=].code = #NMPC-OME20CAP
* code.coding[=].display = "Omeprazole 20mg gastro-resistant capsules"
* code.coding[+].system = $SCT
* code.coding[=].code = #372718005
* code.coding[=].display = "Omeprazole"
* code.coding[+].system = $ATC
* code.coding[=].code = #A02BC01
* code.coding[=].display = "Omeprazole"
* code.text = "Omeprazole 20mg gastro-resistant capsules"
* form = $SCT#385049006 "Capsule"
* amount.numerator = 28 '{capsule}' "capsules"
* amount.denominator = 1 '{pack}' "pack"
* ingredient[0].itemCodeableConcept = $SCT#372718005 "Omeprazole"
* ingredient[=].isActive = true
* ingredient[=].strength.numerator = 20 'mg' "mg"
* ingredient[=].strength.denominator = 1 '{capsule}' "capsule"


Instance: ie-medication-atorvastatin-80
InstanceOf: IECoreMedicationEPrescription
Usage: #example
Title: "Medication – Atorvastatin 80mg Tablets (ATC: C10AA05)"
Description: "Atorvastatin 80mg film-coated tablets (high-intensity statin). NMPC is primary, SNOMED CT is secondary, and ATC code C10AA05 is included for classification."

* code.coding[0].system = $NMPC
* code.coding[=].code = #NMPC-ATV80TAB
* code.coding[=].display = "Atorvastatin 80mg tablets"
* code.coding[+].system = $SCT
* code.coding[=].code = #373444002
* code.coding[=].display = "Atorvastatin"
* code.coding[+].system = $ATC
* code.coding[=].code = #C10AA05
* code.coding[=].display = "Atorvastatin"
* code.text = "Atorvastatin 80mg tablets"
* form = $SCT#385055001 "Tablet"
* amount.numerator = 28 '{tablet}' "tablets"
* amount.denominator = 1 '{pack}' "pack"
* ingredient[0].itemCodeableConcept = $SCT#373444002 "Atorvastatin"
* ingredient[=].isActive = true
* ingredient[=].strength.numerator = 80 'mg' "mg"
* ingredient[=].strength.denominator = 1 '{tablet}' "tablet"


Instance: ie-medication-ramipril-10
InstanceOf: IECoreMedicationEPrescription
Usage: #example
Title: "Medication – Ramipril 10mg Capsules (ATC: C09AA05)"
Description: "Ramipril 10mg capsules, ACE inhibitor. NMPC is primary, SNOMED CT is secondary, and ATC code C09AA05 is included for classification."

* code.coding[0].system = $NMPC
* code.coding[=].code = #NMPC-RAM10CAP
* code.coding[=].display = "Ramipril 10mg capsules"
* code.coding[+].system = $SCT
* code.coding[=].code = #386872004
* code.coding[=].display = "Ramipril"
* code.coding[+].system = $ATC
* code.coding[=].code = #C09AA05
* code.coding[=].display = "Ramipril"
* code.text = "Ramipril 10mg capsules"
* form = $SCT#385049006 "Capsule"
* amount.numerator = 28 '{capsule}' "capsules"
* amount.denominator = 1 '{pack}' "pack"
* ingredient[0].itemCodeableConcept = $SCT#386872004 "Ramipril"
* ingredient[=].isActive = true
* ingredient[=].strength.numerator = 10 'mg' "mg"
* ingredient[=].strength.denominator = 1 '{capsule}' "capsule"


// ====================================================================
// SCENARIO 1: IE → GERMANY (BERLIN) – Metformin + Lisinopril
// Date: 2025-01-20 | Apotheke am Brandenburger Tor
// ====================================================================

Instance: ie-org-de-apotheke-brandenburger
InstanceOf: IECoreOrganization
Usage: #example
Title: "Pharmacy – Apotheke am Brandenburger Tor, Berlin (DE)"
Description: "German pharmacy in Berlin where Seán Murphy's Irish ePrescription for Metformin and Lisinopril was dispensed on 20 January 2025."

* identifier[0].system = "http://fhir.de/sid/apothekenVerzeichnis"
* identifier[=].value = "DE-APO-10117-001"
* active = true
* type = http://terminology.hl7.org/CodeSystem/organization-type#prov "Healthcare Provider"
* name = "Apotheke am Brandenburger Tor"
* address[0].use = #work
* address[=].line = "Pariser Platz 1"
* address[=].city = "Berlin"
* address[=].postalCode = "10117"
* address[=].country = "DE"
* telecom[0].system = #phone
* telecom[=].value = "+49 30 202 64 14"
* telecom[=].use = #work


Instance: ie-rx-sean-de-metformin
InstanceOf: IECoreMedicationRequestEPrescription
Usage: #example
Title: "Scenario 1 (IE→DE) – Prescription: Metformin 500mg for Germany"
Description: "Irish ePrescription for Metformin 500mg for Seán Murphy, transmitted via MyHealth@EU to Germany. Carries PCRS identifier and eIDAS cross-border identifier."

* identifier[0].system = "https://hl7-ie.github.io/fhir/ie/core/sid/pcrs-rx"
* identifier[=].value = "PCRS-RX-2025-IE-DE-001"
* identifier[+].system = "http://eidas.europa.eu/attributes/naturalperson/PersonIdentifier"
* identifier[=].value = "IE/DE/1234567T"

* groupIdentifier.system = "https://hl7-ie.github.io/fhir/ie/core/sid/prescription-group"
* groupIdentifier.value = "IE-GP-RX-GROUP-20250120-DE"

* status = #active
* intent = #order
* category = http://terminology.hl7.org/CodeSystem/medicationrequest-category#community "Community"

* medicationReference = Reference(ie-core-medication-metformin-500)
* subject = Reference(ie-core-patient-sean-murphy) "Seán Murphy"
* requester = Reference(ie-core-practitioner-aoife-obrien) "Dr. Aoife O'Brien"
* authoredOn = "2025-01-15"

* reasonCode = $SCT#44054006 "Diabetes mellitus type 2"
* reasonCode.coding[+].system = $ATC
* reasonCode.coding[=].code = #A10BA02
* reasonCode.coding[=].display = "Metformin"

* dosageInstruction[0].text = "Take one 500mg tablet twice daily with meals"
* dosageInstruction[=].timing.repeat.frequency = 2
* dosageInstruction[=].timing.repeat.period = 1
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].route = $SCT#26643006 "Oral route"
* dosageInstruction[=].doseAndRate[0].doseQuantity = 500 'mg' "mg"

* dispenseRequest.validityPeriod.start = "2025-01-15"
* dispenseRequest.validityPeriod.end = "2025-04-15"
* dispenseRequest.numberOfRepeatsAllowed = 0
* dispenseRequest.quantity = 60 '{tablet}' "tablets"
* dispenseRequest.expectedSupplyDuration = 30 'd' "days"

* substitution.allowedBoolean = true


Instance: ie-rx-sean-de-lisinopril
InstanceOf: IECoreMedicationRequestEPrescription
Usage: #example
Title: "Scenario 1 (IE→DE) – Prescription: Lisinopril 10mg for Germany"
Description: "Irish ePrescription for Lisinopril 10mg for Seán Murphy, transmitted via MyHealth@EU to Germany."

* identifier[0].system = "https://hl7-ie.github.io/fhir/ie/core/sid/pcrs-rx"
* identifier[=].value = "PCRS-RX-2025-IE-DE-002"
* identifier[+].system = "http://eidas.europa.eu/attributes/naturalperson/PersonIdentifier"
* identifier[=].value = "IE/DE/1234567T"

* groupIdentifier.system = "https://hl7-ie.github.io/fhir/ie/core/sid/prescription-group"
* groupIdentifier.value = "IE-GP-RX-GROUP-20250120-DE"

* status = #active
* intent = #order
* category = http://terminology.hl7.org/CodeSystem/medicationrequest-category#community "Community"

* medicationReference = Reference(ie-medication-lisinopril-10)
* subject = Reference(ie-core-patient-sean-murphy) "Seán Murphy"
* requester = Reference(ie-core-practitioner-aoife-obrien) "Dr. Aoife O'Brien"
* authoredOn = "2025-01-15"

* reasonCode = $SCT#38341003 "Hypertensive disorder"
* reasonCode.coding[+].system = $ATC
* reasonCode.coding[=].code = #C09AA03
* reasonCode.coding[=].display = "Lisinopril"

* dosageInstruction[0].text = "Take one 10mg tablet once daily in the morning"
* dosageInstruction[=].timing.repeat.frequency = 1
* dosageInstruction[=].timing.repeat.period = 1
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].timing.repeat.when = #MORN
* dosageInstruction[=].route = $SCT#26643006 "Oral route"
* dosageInstruction[=].doseAndRate[0].doseQuantity = 10 'mg' "mg"

* dispenseRequest.validityPeriod.start = "2025-01-15"
* dispenseRequest.validityPeriod.end = "2025-04-15"
* dispenseRequest.numberOfRepeatsAllowed = 0
* dispenseRequest.quantity = 28 '{tablet}' "tablets"
* dispenseRequest.expectedSupplyDuration = 28 'd' "days"

* substitution.allowedBoolean = true


Instance: ie-dispense-de-metformin
InstanceOf: IECoreMedicationDispenseEDispensation
Usage: #example
Title: "Scenario 1 (IE→DE) – German Dispensation: Metformin (PZN 04823246)"
Description: "German pharmacy dispensation of Metformin 500mg Filmtabletten (Ratiopharm, PZN 04823246) against the Irish cross-border ePrescription. Generic substitution performed."

* identifier[0].system = "http://fhir.de/sid/apothekenVerzeichnis"
* identifier[=].value = "DE-DISP-2025-XB-001-MET"
* status = #completed

* medicationCodeableConcept = $NMPC#NMPC-MET500TAB "Metformin hydrochloride 500mg film-coated tablets"
* medicationCodeableConcept.coding[+] = $SCT#372567009 "Metformin"
* medicationCodeableConcept.coding[+].system = "http://fhir.de/CodeSystem/ifa/pzn"
* medicationCodeableConcept.coding[=].code = #04823246
* medicationCodeableConcept.coding[=].display = "Metformin 500mg Filmtabletten (Ratiopharm)"
* medicationCodeableConcept.text = "Metformin 500mg Filmtabletten (Ratiopharm)"

* subject = Reference(ie-core-patient-sean-murphy) "Seán Murphy"
* performer[0].actor = Reference(ie-org-de-apotheke-brandenburger) "Apotheke am Brandenburger Tor"

* authorizingPrescription = Reference(ie-rx-sean-de-metformin) "PCRS-RX-2025-IE-DE-001"

* type = http://terminology.hl7.org/CodeSystem/v3-ActCode#DF "Daily Fill"
* quantity = 60 '{tablet}' "tablets"
* daysSupply = 30 'd' "days"
* whenPrepared = "2025-01-20T10:00:00+01:00"
* whenHandedOver = "2025-01-20T10:15:00+01:00"

* dosageInstruction[0].text = "Zweimal täglich 1 Tablette zu den Mahlzeiten einnehmen (Take one 500mg tablet twice daily with meals)"

* substitution.wasSubstituted = true
* substitution.type = http://terminology.hl7.org/CodeSystem/v3-substanceAdminSubstitution#G "Generic composition"
* substitution.reason = $SCT#373873005 "Pharmaceutical / biologic product"


Instance: ie-dispense-de-lisinopril
InstanceOf: IECoreMedicationDispenseEDispensation
Usage: #example
Title: "Scenario 1 (IE→DE) – German Dispensation: Lisinopril (PZN 03990693)"
Description: "German pharmacy dispensation of Lisinopril 10mg Tabletten (Hexal, PZN 03990693) against the Irish cross-border ePrescription. Generic substitution performed."

* identifier[0].system = "http://fhir.de/sid/apothekenVerzeichnis"
* identifier[=].value = "DE-DISP-2025-XB-001-LIS"
* status = #completed

* medicationCodeableConcept = $NMPC#NMPC-LIS10TAB "Lisinopril 10mg tablets"
* medicationCodeableConcept.coding[+] = $SCT#386873009 "Lisinopril"
* medicationCodeableConcept.coding[+].system = "http://fhir.de/CodeSystem/ifa/pzn"
* medicationCodeableConcept.coding[=].code = #03990693
* medicationCodeableConcept.coding[=].display = "Lisinopril 10mg Tabletten (Hexal)"
* medicationCodeableConcept.text = "Lisinopril 10mg Tabletten (Hexal)"

* subject = Reference(ie-core-patient-sean-murphy) "Seán Murphy"
* performer[0].actor = Reference(ie-org-de-apotheke-brandenburger) "Apotheke am Brandenburger Tor"

* authorizingPrescription = Reference(ie-rx-sean-de-lisinopril) "PCRS-RX-2025-IE-DE-002"

* type = http://terminology.hl7.org/CodeSystem/v3-ActCode#DF "Daily Fill"
* quantity = 28 '{tablet}' "tablets"
* daysSupply = 28 'd' "days"
* whenPrepared = "2025-01-20T10:00:00+01:00"
* whenHandedOver = "2025-01-20T10:15:00+01:00"

* dosageInstruction[0].text = "Einmal täglich 1 Tablette morgens (Take one 10mg tablet once daily in the morning)"

* substitution.wasSubstituted = true
* substitution.type = http://terminology.hl7.org/CodeSystem/v3-substanceAdminSubstitution#G "Generic composition"
* substitution.reason = $SCT#373873005 "Pharmaceutical / biologic product"


// ====================================================================
// SCENARIO 5 (IE→LV) – Metformin + Lisinopril in Latvia
// ====================================================================

Instance: ie-org-lv-mes-aptieka
InstanceOf: IECoreOrganization
Usage: #example
Title: "Pharmacy – Mēs atdot Aptieka, Riga (LV)"
Description: "Latvian pharmacy in Riga where Seán Murphy's Irish ePrescription was dispensed (15 June 2025)."

* identifier[0].system = "http://www.zva.gov.lv/fhir/sid/aptieka"
* identifier[=].value = "LV-APT-RIGA-001"
* active = true
* type = http://terminology.hl7.org/CodeSystem/organization-type#prov "Healthcare Provider"
* name = "Mēs atdot Aptieka"
* address[0].use = #work
* address[=].city = "Riga"
* address[=].country = "LV"


Instance: ie-rx-sean-lv-metformin
InstanceOf: IECoreMedicationRequestEPrescription
Usage: #example
Title: "Scenario 5 (IE→LV) – Prescription: Metformin 500mg for Latvia"
Description: "Irish ePrescription for Metformin 500mg for Seán Murphy, transmitted via MyHealth@EU to Latvia."

* identifier[0].system = "https://hl7-ie.github.io/fhir/ie/core/sid/pcrs-rx"
* identifier[=].value = "PCRS-RX-2025-IE-LV-001"
* identifier[+].system = "http://eidas.europa.eu/attributes/naturalperson/PersonIdentifier"
* identifier[=].value = "IE/LV/1234567T"

* status = #active
* intent = #order
* category = http://terminology.hl7.org/CodeSystem/medicationrequest-category#community "Community"
* medicationReference = Reference(ie-core-medication-metformin-500)
* subject = Reference(ie-core-patient-sean-murphy) "Seán Murphy"
* requester = Reference(ie-core-practitioner-aoife-obrien) "Dr. Aoife O'Brien"
* authoredOn = "2025-06-10"
* reasonCode = $SCT#44054006 "Diabetes mellitus type 2"
* dosageInstruction[0].text = "Take one 500mg tablet twice daily with meals"
* dosageInstruction[=].timing.repeat.frequency = 2
* dosageInstruction[=].timing.repeat.period = 1
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].route = $SCT#26643006 "Oral route"
* dispenseRequest.validityPeriod.start = "2025-06-10"
* dispenseRequest.validityPeriod.end = "2025-09-10"
* dispenseRequest.numberOfRepeatsAllowed = 0
* dispenseRequest.quantity = 60 '{tablet}' "tablets"
* substitution.allowedBoolean = true


Instance: ie-dispense-lv-metformin
InstanceOf: IECoreMedicationDispenseEDispensation
Usage: #example
Title: "Scenario 5 (IE→LV) – Latvian Dispensation: Metformin (ZRA-00098432)"
Description: "Latvian pharmacy dispensation of Metformins 500mg tabletes (ZRA code ZRA-00098432) against the Irish cross-border ePrescription."

* identifier[0].system = "http://www.zva.gov.lv/fhir/sid/dispensation"
* identifier[=].value = "LV-DISP-2025-XB-001"
* status = #completed

* medicationCodeableConcept = $NMPC#NMPC-MET500TAB "Metformin hydrochloride 500mg film-coated tablets"
* medicationCodeableConcept.coding[+] = $SCT#372567009 "Metformin"
* medicationCodeableConcept.coding[+].system = "http://www.zva.gov.lv/zalu-registrs"
* medicationCodeableConcept.coding[=].code = #ZRA-00098432
* medicationCodeableConcept.coding[=].display = "Metformins 500mg tabletes"
* medicationCodeableConcept.text = "Metformins 500mg tabletes"

* subject = Reference(ie-core-patient-sean-murphy) "Seán Murphy"
* performer[0].actor = Reference(ie-org-lv-mes-aptieka) "Mēs atdot Aptieka"
* authorizingPrescription = Reference(ie-rx-sean-lv-metformin) "PCRS-RX-2025-IE-LV-001"
* type = http://terminology.hl7.org/CodeSystem/v3-ActCode#DF "Daily Fill"
* quantity = 60 '{tablet}' "tablets"
* daysSupply = 30 'd' "days"
* whenHandedOver = "2025-06-15T11:00:00+03:00"
* dosageInstruction[0].text = "Lietot vienu 500mg tableti divas reizes dienā ēdienreizēs (Take one 500mg tablet twice daily with meals)"
* substitution.wasSubstituted = true
* substitution.type = http://terminology.hl7.org/CodeSystem/v3-substanceAdminSubstitution#G "Generic composition"


// ====================================================================
// SCENARIO 6 (IE→PT) – Sertraline + Omeprazole in Portugal
// ====================================================================

Instance: ie-org-pt-farmacia-central-lisbon
InstanceOf: IECoreOrganization
Usage: #example
Title: "Pharmacy – Farmácia Central, Lisbon (PT)"
Description: "Portuguese pharmacy in Lisbon where Seán Murphy's Irish ePrescription for Sertraline and Omeprazole was dispensed (20 June 2025)."

* identifier[0].system = "http://www.infarmed.pt/fhir/sid/farmacia"
* identifier[=].value = "PT-FAR-LIS-001"
* active = true
* type = http://terminology.hl7.org/CodeSystem/organization-type#prov "Healthcare Provider"
* name = "Farmácia Central"
* address[0].use = #work
* address[=].city = "Lisbon"
* address[=].country = "PT"


Instance: ie-rx-sean-pt-sertraline
InstanceOf: IECoreMedicationRequestEPrescription
Usage: #example
Title: "Scenario 6 (IE→PT) – Prescription: Sertraline 50mg for Portugal"
Description: "Irish ePrescription for Sertraline 50mg for Seán Murphy, transmitted via MyHealth@EU to Portugal."

* identifier[0].system = "https://hl7-ie.github.io/fhir/ie/core/sid/pcrs-rx"
* identifier[=].value = "PCRS-RX-2025-IE-PT-001"
* identifier[+].system = "http://eidas.europa.eu/attributes/naturalperson/PersonIdentifier"
* identifier[=].value = "IE/PT/1234567T"

* groupIdentifier.system = "https://hl7-ie.github.io/fhir/ie/core/sid/prescription-group"
* groupIdentifier.value = "IE-GP-RX-GROUP-20250620-PT"

* status = #active
* intent = #order
* category = http://terminology.hl7.org/CodeSystem/medicationrequest-category#community "Community"
* medicationReference = Reference(ie-medication-sertraline-50)
* subject = Reference(ie-core-patient-sean-murphy) "Seán Murphy"
* requester = Reference(ie-core-practitioner-aoife-obrien) "Dr. Aoife O'Brien"
* authoredOn = "2025-06-15"
* reasonCode = $SCT#35489007 "Depressive disorder"
* dosageInstruction[0].text = "Take one 50mg tablet once daily in the morning"
* dosageInstruction[=].timing.repeat.frequency = 1
* dosageInstruction[=].timing.repeat.period = 1
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].timing.repeat.when = #MORN
* dosageInstruction[=].route = $SCT#26643006 "Oral route"
* dispenseRequest.validityPeriod.start = "2025-06-15"
* dispenseRequest.validityPeriod.end = "2025-09-15"
* dispenseRequest.quantity = 28 '{tablet}' "tablets"
* substitution.allowedBoolean = false


Instance: ie-dispense-pt-sertraline
InstanceOf: IECoreMedicationDispenseEDispensation
Usage: #example
Title: "Scenario 6 (IE→PT) – Portuguese Dispensation: Sertraline (INF-00012345)"
Description: "Portuguese pharmacy dispensation of Sertralina 50mg Comprimidos (INFARMED code INF-00012345)."

* identifier[0].system = "http://www.infarmed.pt/fhir/sid/dispensacao"
* identifier[=].value = "PT-DISP-2025-XB-001"
* status = #completed
* medicationCodeableConcept = $NMPC#NMPC-SER50TAB "Sertraline 50mg tablets"
* medicationCodeableConcept.coding[+] = $SCT#372594008 "Sertraline"
* medicationCodeableConcept.coding[+].system = "http://www.infarmed.pt"
* medicationCodeableConcept.coding[=].code = #INF-00012345
* medicationCodeableConcept.coding[=].display = "Sertralina 50mg Comprimidos"
* medicationCodeableConcept.text = "Sertralina 50mg Comprimidos"
* subject = Reference(ie-core-patient-sean-murphy) "Seán Murphy"
* performer[0].actor = Reference(ie-org-pt-farmacia-central-lisbon) "Farmácia Central"
* authorizingPrescription = Reference(ie-rx-sean-pt-sertraline) "PCRS-RX-2025-IE-PT-001"
* type = http://terminology.hl7.org/CodeSystem/v3-ActCode#DF "Daily Fill"
* quantity = 28 '{tablet}' "tablets"
* daysSupply = 28 'd' "days"
* whenHandedOver = "2025-06-20T10:30:00+01:00"
* dosageInstruction[0].text = "Tomar um comprimido de 50mg uma vez ao dia de manhã (Take one 50mg tablet once daily in the morning)"
* substitution.wasSubstituted = false


// ====================================================================
// SCENARIO 7 (IE→DK) – Warfarin 5mg in Denmark
// ====================================================================

Instance: ie-org-dk-apoteket-copenhagen
InstanceOf: IECoreOrganization
Usage: #example
Title: "Pharmacy – Apoteket, Copenhagen (DK)"
Description: "Danish pharmacy in Copenhagen where Seán Murphy's Irish ePrescription for Warfarin 5mg was dispensed (1 July 2025)."

* identifier[0].system = "http://www.dkma.dk/fhir/sid/apotek"
* identifier[=].value = "DK-APO-CPH-001"
* active = true
* type = http://terminology.hl7.org/CodeSystem/organization-type#prov "Healthcare Provider"
* name = "Apoteket"
* address[0].use = #work
* address[=].city = "Copenhagen"
* address[=].country = "DK"


Instance: ie-rx-sean-dk-warfarin
InstanceOf: IECoreMedicationRequestEPrescription
Usage: #example
Title: "Scenario 7 (IE→DK) – Prescription: Warfarin 5mg for Denmark"
Description: "Irish ePrescription for Warfarin 5mg for Seán Murphy, transmitted via MyHealth@EU to Denmark. Includes critical INR monitoring note."

* identifier[0].system = "https://hl7-ie.github.io/fhir/ie/core/sid/pcrs-rx"
* identifier[=].value = "PCRS-RX-2025-IE-DK-001"
* identifier[+].system = "http://eidas.europa.eu/attributes/naturalperson/PersonIdentifier"
* identifier[=].value = "IE/DK/1234567T"

* status = #active
* intent = #order
* category = http://terminology.hl7.org/CodeSystem/medicationrequest-category#community "Community"
* medicationReference = Reference(ie-medication-warfarin-5)
* subject = Reference(ie-core-patient-sean-murphy) "Seán Murphy"
* requester = Reference(ie-core-practitioner-aoife-obrien) "Dr. Aoife O'Brien"
* authoredOn = "2025-06-25"
* reasonCode = $SCT#49436004 "Atrial fibrillation"

* dosageInstruction[0].text = "Take one 5mg tablet once daily. INR target 2.0-3.0. Requires INR monitoring — contact local anticoagulation service."
* dosageInstruction[=].timing.repeat.frequency = 1
* dosageInstruction[=].timing.repeat.period = 1
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].route = $SCT#26643006 "Oral route"
* dosageInstruction[=].patientInstruction = "⚠️ Requires regular INR blood tests. Target INR 2.0–3.0. Consult local anticoagulation clinic."

* dispenseRequest.validityPeriod.start = "2025-06-25"
* dispenseRequest.validityPeriod.end = "2025-09-25"
* dispenseRequest.quantity = 28 '{tablet}' "tablets"
* substitution.allowedBoolean = false


// ====================================================================
// SCENARIO 8 (IE→SE) – Insulin Glargine + Aspart in Sweden
// ====================================================================

Instance: ie-org-se-apoteket-hjartat
InstanceOf: IECoreOrganization
Usage: #example
Title: "Pharmacy – Apoteket Hjärtat, Stockholm (SE)"
Description: "Swedish pharmacy in Stockholm where Seán Murphy's Irish ePrescription for insulin was dispensed (10 July 2025)."

* identifier[0].system = "http://www.lakemedelsverket.se/fhir/sid/apotek"
* identifier[=].value = "SE-APT-STO-001"
* active = true
* type = http://terminology.hl7.org/CodeSystem/organization-type#prov "Healthcare Provider"
* name = "Apoteket Hjärtat"
* address[0].use = #work
* address[=].city = "Stockholm"
* address[=].country = "SE"


Instance: ie-rx-sean-se-insulin-glargine
InstanceOf: IECoreMedicationRequestEPrescription
Usage: #example
Title: "Scenario 8 (IE→SE) – Prescription: Insulin Glargine for Sweden"
Description: "Irish ePrescription for Insulin Glargine 100u/ml for Seán Murphy, transmitted via MyHealth@EU to Sweden."

* identifier[0].system = "https://hl7-ie.github.io/fhir/ie/core/sid/pcrs-rx"
* identifier[=].value = "PCRS-RX-2025-IE-SE-001"
* identifier[+].system = "http://eidas.europa.eu/attributes/naturalperson/PersonIdentifier"
* identifier[=].value = "IE/SE/1234567T"

* groupIdentifier.system = "https://hl7-ie.github.io/fhir/ie/core/sid/prescription-group"
* groupIdentifier.value = "IE-GP-RX-GROUP-20250710-SE"

* status = #active
* intent = #order
* category = http://terminology.hl7.org/CodeSystem/medicationrequest-category#community "Community"
* medicationReference = Reference(ie-medication-insulin-glargine)
* subject = Reference(ie-core-patient-sean-murphy) "Seán Murphy"
* requester = Reference(ie-core-practitioner-aoife-obrien) "Dr. Aoife O'Brien"
* authoredOn = "2025-07-05"
* reasonCode = $SCT#44054006 "Diabetes mellitus type 2"
* dosageInstruction[0].text = "Inject 20 units subcutaneously once daily at bedtime"
* dosageInstruction[=].timing.repeat.frequency = 1
* dosageInstruction[=].timing.repeat.period = 1
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].timing.repeat.when = #HS
* dosageInstruction[=].route = $SCT#34206005 "Subcutaneous route"
* dispenseRequest.validityPeriod.start = "2025-07-05"
* dispenseRequest.validityPeriod.end = "2025-10-05"
* dispenseRequest.quantity = 5 '{cartridge}' "cartridges"
* substitution.allowedBoolean = false


// ====================================================================
// SCENARIO 9 (IE→AT) – Atorvastatin 80mg + Ramipril 10mg in Austria
// ====================================================================

Instance: ie-org-at-apotheke-goldene-kugel
InstanceOf: IECoreOrganization
Usage: #example
Title: "Pharmacy – Apotheke zur goldenen Kugel, Vienna (AT)"
Description: "Austrian pharmacy in Vienna where Seán Murphy's Irish ePrescription was dispensed (15 July 2025)."

* identifier[0].system = "http://www.basg.gv.at/fhir/sid/apotheke"
* identifier[=].value = "AT-APO-WIE-001"
* active = true
* type = http://terminology.hl7.org/CodeSystem/organization-type#prov "Healthcare Provider"
* name = "Apotheke zur goldenen Kugel"
* address[0].use = #work
* address[=].city = "Vienna"
* address[=].country = "AT"


Instance: ie-rx-sean-at-atorvastatin80
InstanceOf: IECoreMedicationRequestEPrescription
Usage: #example
Title: "Scenario 9 (IE→AT) – Prescription: Atorvastatin 80mg for Austria"
Description: "Irish ePrescription for Atorvastatin 80mg for Seán Murphy, transmitted via MyHealth@EU to Austria."

* identifier[0].system = "https://hl7-ie.github.io/fhir/ie/core/sid/pcrs-rx"
* identifier[=].value = "PCRS-RX-2025-IE-AT-001"
* identifier[+].system = "http://eidas.europa.eu/attributes/naturalperson/PersonIdentifier"
* identifier[=].value = "IE/AT/1234567T"

* groupIdentifier.system = "https://hl7-ie.github.io/fhir/ie/core/sid/prescription-group"
* groupIdentifier.value = "IE-GP-RX-GROUP-20250715-AT"

* status = #active
* intent = #order
* category = http://terminology.hl7.org/CodeSystem/medicationrequest-category#community "Community"
* medicationReference = Reference(ie-medication-atorvastatin-80)
* subject = Reference(ie-core-patient-sean-murphy) "Seán Murphy"
* requester = Reference(ie-core-practitioner-aoife-obrien) "Dr. Aoife O'Brien"
* authoredOn = "2025-07-10"
* reasonCode = $SCT#13644009 "Hypercholesterolemia"
* dosageInstruction[0].text = "Take one 80mg tablet once daily at night"
* dosageInstruction[=].timing.repeat.frequency = 1
* dosageInstruction[=].timing.repeat.period = 1
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].timing.repeat.when = #CV
* dosageInstruction[=].route = $SCT#26643006 "Oral route"
* dispenseRequest.validityPeriod.start = "2025-07-10"
* dispenseRequest.validityPeriod.end = "2025-10-10"
* dispenseRequest.quantity = 28 '{tablet}' "tablets"
* substitution.allowedBoolean = true


// ====================================================================
// INBOUND SCENARIO 10 – FINLAND → IRELAND (Mikko Korhonen via NePS)
// ====================================================================

Instance: ie-patient-fi-mikko-korhonen
InstanceOf: IECorePatient
Usage: #example
Title: "Patient – Mikko Korhonen (Finnish citizen visiting Ireland)"
Description: "Finnish patient Mikko Korhonen visiting Dublin. His Finnish prescription for Metformin 500mg is dispensed at Hickey's Pharmacy, O'Connell Street via NePS."

* identifier[0].system = "http://www.kela.fi/fhir/sid/sotu"
* identifier[=].type = $V2-0203#NI "National unique individual identifier"
* identifier[=].value = "FI-123456-7890"
* identifier[+].system = "http://eidas.europa.eu/attributes/naturalperson/PersonIdentifier"
* identifier[=].value = "FI/IE/123456-7890"

* active = true
* name[0].use = #official
* name[=].family = "Korhonen"
* name[=].given[0] = "Mikko"
* name[=].given[+] = "Tapani"
* gender = #male
* birthDate = "1982-07-20"
* address[0].use = #home
* address[=].city = "Helsinki"
* address[=].country = "FI"
* communication[0].language = urn:ietf:bcp:47#fi "Finnish"
* communication[=].preferred = true
* communication[+].language = urn:ietf:bcp:47#en "English"


Instance: ie-org-ie-hickeys-pharmacy
InstanceOf: IECoreOrganization
Usage: #example
Title: "Pharmacy – Hickey's Pharmacy, O'Connell Street, Dublin"
Description: "Irish community pharmacy dispensing a Finnish cross-border prescription for Mikko Korhonen via NePS."

* identifier[0].system = $CRN
* identifier[=].value = "IE-PHARM-HCK-001"
* active = true
* type = http://terminology.hl7.org/CodeSystem/organization-type#prov "Healthcare Provider"
* name = "Hickey's Pharmacy"
* address[0].use = #work
* address[=].line = "O'Connell Street"
* address[=].city = "Dublin"
* address[=].country = "IE"


Instance: ie-rx-fi-metformin-neps
InstanceOf: IECoreMedicationRequestEPrescription
Usage: #example
Title: "Scenario 10 (FI→IE via NePS) – Finnish Prescription: Metformin 500mg"
Description: "Finnish ePrescription for Metformin 500mg for Mikko Korhonen, received via NePS for cross-border dispensation in Ireland."

* identifier[0].system = "http://www.kela.fi/fhir/sid/prescription"
* identifier[=].value = "FI-RX-2025-NEPS-001"
* status = #active
* intent = #order
* category = http://terminology.hl7.org/CodeSystem/medicationrequest-category#community "Community"
* medicationCodeableConcept = $NMPC#NMPC-MET500TAB "Metformin hydrochloride 500mg film-coated tablets"
* medicationCodeableConcept.coding[+] = $SCT#372567009 "Metformin"
* subject = Reference(ie-patient-fi-mikko-korhonen) "Mikko Korhonen"
* requester = Reference(ie-core-practitioner-aoife-obrien) "Dr. Aoife O'Brien"
* authoredOn = "2025-07-20"
* reasonCode = $SCT#44054006 "Diabetes mellitus type 2"
* dosageInstruction[0].text = "Take one 500mg tablet twice daily with meals"
* dosageInstruction[=].timing.repeat.frequency = 2
* dosageInstruction[=].timing.repeat.period = 1
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].route = $SCT#26643006 "Oral route"
* dosageInstruction[=].doseAndRate[0].doseQuantity = 500 'mg' "mg"
* dispenseRequest.validityPeriod.start = "2025-07-20"
* dispenseRequest.validityPeriod.end = "2025-10-20"
* dispenseRequest.quantity = 60 '{tablet}' "tablets"
* substitution.allowedBoolean = true


Instance: ie-dispense-fi-to-ie-neps
InstanceOf: IECoreMedicationDispenseEDispensation
Usage: #example
Title: "Scenario 10 (FI→IE via NePS) – Irish Dispensation for Finnish Patient"
Description: "Hickey's Pharmacy, Dublin dispenses Metformin 500mg for Finnish patient Mikko Korhonen against a Finnish prescription received via NePS. The Finnish medication code (Kela/FIN) is mapped to an Irish NMPC code."

* identifier[0].system = "https://hl7-ie.github.io/fhir/ie/core/sid/dispense-id"
* identifier[=].value = "DISP-IE-NEPS-2025-FI-001"
* identifier[+].system = "http://www.kela.fi/fhir/sid/prescription"
* identifier[=].value = "FI-RX-2025-NEPS-001"
* status = #completed

* medicationCodeableConcept = $NMPC#NMPC-MET500TAB "Metformin hydrochloride 500mg film-coated tablets"
* medicationCodeableConcept.coding[+] = $SCT#372567009 "Metformin"
* medicationCodeableConcept.coding[+].system = "http://www.kela.fi"
* medicationCodeableConcept.coding[=].code = #FIN-XXXX
* medicationCodeableConcept.coding[=].display = "Metformin 500mg tablets (Kela/FIN)"
* medicationCodeableConcept.text = "Metformin 500mg tablets"

* subject = Reference(ie-patient-fi-mikko-korhonen) "Mikko Korhonen"
* performer[0].actor = Reference(ie-org-ie-hickeys-pharmacy) "Hickey's Pharmacy"
* authorizingPrescription = Reference(ie-rx-fi-metformin-neps) "FI-RX-2025-NEPS-001"

* type = http://terminology.hl7.org/CodeSystem/v3-ActCode#DF "Daily Fill"
* quantity = 60 '{tablet}' "tablets"
* daysSupply = 30 'd' "days"
* whenHandedOver = "2025-08-01T14:00:00+01:00"
* dosageInstruction[0].text = "Take one 500mg tablet twice daily with meals"
* substitution.wasSubstituted = false


// ====================================================================
// INBOUND SCENARIO 11 – BELGIUM → IRELAND (Lars Janssen via NePS)
// ====================================================================

Instance: ie-patient-be-lars-janssen
InstanceOf: IECorePatient
Usage: #example
Title: "Patient – Lars Janssen (Belgian citizen visiting Ireland)"
Description: "Belgian patient Lars Janssen visiting Dublin. His Belgian prescription for Atorvastatin 40mg is dispensed at McCauley's Pharmacy via NePS."

* identifier[0].system = "http://www.cnpv.be/fhir/sid/niss"
* identifier[=].type = $V2-0203#NI "National unique individual identifier"
* identifier[=].value = "BE-12345678901"
* identifier[+].system = "http://eidas.europa.eu/attributes/naturalperson/PersonIdentifier"
* identifier[=].value = "BE/IE/12345678901"

* active = true
* name[0].use = #official
* name[=].family = "Janssen"
* name[=].given = "Lars"
* name[=].prefix = "Mr."
* gender = #male
* birthDate = "1970-05-10"
* address[0].use = #home
* address[=].city = "Brussels"
* address[=].country = "BE"
* communication[0].language = urn:ietf:bcp:47#nl "Dutch"
* communication[=].preferred = true
* communication[+].language = urn:ietf:bcp:47#en "English"


Instance: ie-org-ie-mccauleys-pharmacy
InstanceOf: IECoreOrganization
Usage: #example
Title: "Pharmacy – McCauley's Pharmacy, Grafton Street, Dublin"
Description: "Irish community pharmacy dispensing a Belgian cross-border prescription for Lars Janssen via NePS."

* identifier[0].system = $CRN
* identifier[=].value = "IE-PHARM-MCC-001"
* active = true
* type = http://terminology.hl7.org/CodeSystem/organization-type#prov "Healthcare Provider"
* name = "McCauley's Pharmacy"
* address[0].use = #work
* address[=].line = "Grafton Street"
* address[=].city = "Dublin 2"
* address[=].country = "IE"


Instance: ie-rx-be-atorvastatin-neps
InstanceOf: IECoreMedicationRequestEPrescription
Usage: #example
Title: "Scenario 11 (BE→IE via NePS) – Belgian Prescription: Atorvastatin 40mg"
Description: "Belgian ePrescription for Atorvastatin 40mg for Lars Janssen, received via NePS for cross-border dispensation in Ireland."

* identifier[0].system = "http://www.cnpv.be/fhir/sid/prescription"
* identifier[=].value = "BE-RX-2025-NEPS-001"
* status = #active
* intent = #order
* category = http://terminology.hl7.org/CodeSystem/medicationrequest-category#community "Community"
* medicationCodeableConcept = $NMPC#NMPC-ATV40TAB "Atorvastatin 40mg tablets"
* medicationCodeableConcept.coding[+] = $SCT#373444002 "Atorvastatin"
* subject = Reference(ie-patient-be-lars-janssen) "Lars Janssen"
* requester = Reference(ie-core-practitioner-aoife-obrien) "Dr. Aoife O'Brien"
* authoredOn = "2025-07-25"
* reasonCode = $SCT#13644009 "Hypercholesterolemia"
* dosageInstruction[0].text = "Take one 40mg tablet once daily at night"
* dosageInstruction[=].timing.repeat.frequency = 1
* dosageInstruction[=].timing.repeat.period = 1
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].timing.repeat.when = #CV
* dosageInstruction[=].route = $SCT#26643006 "Oral route"
* dosageInstruction[=].doseAndRate[0].doseQuantity = 40 'mg' "mg"
* dispenseRequest.validityPeriod.start = "2025-07-25"
* dispenseRequest.validityPeriod.end = "2025-10-25"
* dispenseRequest.quantity = 28 '{tablet}' "tablets"
* substitution.allowedBoolean = true


Instance: ie-dispense-be-to-ie-neps
InstanceOf: IECoreMedicationDispenseEDispensation
Usage: #example
Title: "Scenario 11 (BE→IE via NePS) – Irish Dispensation for Belgian Patient"
Description: "McCauley's Pharmacy, Dublin dispenses Atorvastatin 40mg for Belgian patient Lars Janssen against a Belgian prescription received via NePS. Belgian CNPV medication code is mapped to an Irish NMPC code."

* identifier[0].system = "https://hl7-ie.github.io/fhir/ie/core/sid/dispense-id"
* identifier[=].value = "DISP-IE-NEPS-2025-BE-001"
* identifier[+].system = "http://www.cnpv.be/fhir/sid/prescription"
* identifier[=].value = "BE-RX-2025-NEPS-001"
* status = #completed

* medicationCodeableConcept = $NMPC#NMPC-ATV40TAB "Atorvastatin 40mg tablets"
* medicationCodeableConcept.coding[+] = $SCT#373444002 "Atorvastatin"
* medicationCodeableConcept.coding[+].system = "http://www.cnpv.be"
* medicationCodeableConcept.coding[=].code = #BE-CNPV-XXXX
* medicationCodeableConcept.coding[=].display = "Atorvastatin 40mg tablets (CNPV)"
* medicationCodeableConcept.text = "Atorvastatin 40mg tablets"

* subject = Reference(ie-patient-be-lars-janssen) "Lars Janssen"
* performer[0].actor = Reference(ie-org-ie-mccauleys-pharmacy) "McCauley's Pharmacy"
* authorizingPrescription = Reference(ie-rx-be-atorvastatin-neps) "BE-RX-2025-NEPS-001"

* type = http://terminology.hl7.org/CodeSystem/v3-ActCode#DF "Daily Fill"
* quantity = 28 '{tablet}' "tablets"
* daysSupply = 28 'd' "days"
* whenHandedOver = "2025-08-05T11:30:00+01:00"
* dosageInstruction[0].text = "Take one 40mg tablet once daily at night"
* substitution.wasSubstituted = false
