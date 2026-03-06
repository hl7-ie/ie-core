// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Example Instances                                         │
// ╰──────────────────────────────────────────────────────────────────────╯

// ====================================================================
// 1. Patient – John Murphy (Adult, Dublin)
// ====================================================================

Instance: ie-core-patient-example
InstanceOf: IECorePatient
Usage: #example
Title: "IE Core Patient Example"
Description: "An example IE Core Patient representing a male adult living in Dublin with IHI and GMS identifiers."

* identifier[IHI].system = $IHI
* identifier[IHI].type = $V2-0203#NI "National unique individual identifier"
* identifier[IHI].value = "210000000012345678"

* identifier[GMS].system = $GMS
* identifier[GMS].type = $V2-0203#MC "Patient's Medicare number"
* identifier[GMS].value = "1234567A"

* identifier[MRN].system = $MRN
* identifier[MRN].type = $V2-0203#MR "Medical record number"
* identifier[MRN].value = "SJH-2024-001234"

* active = true
* name[0].use = #official
* name[=].family = "Murphy"
* name[=].given[0] = "John"
* name[=].given[+] = "Patrick"
* name[=].prefix = "Mr."
* gender = #male
* birthDate = "1978-05-15"

* address[0].use = #home
* address[=].type = #physical
* address[=].line[0] = "42 Pearse Street"
* address[=].city = "Dublin"
* address[=].state = "Dublin"
* address[=].postalCode = "D02 XY12"
* address[=].country = "IE"

* telecom[0].system = #phone
* telecom[=].value = "+353 1 555 0123"
* telecom[=].use = #home
* telecom[+].system = #email
* telecom[=].value = "john.murphy@example.ie"
* telecom[=].use = #home
* telecom[+].system = #phone
* telecom[=].value = "+353 87 123 4567"
* telecom[=].use = #mobile

* communication[0].language = urn:ietf:bcp:47#en "English"
* communication[=].preferred = true
* communication[+].language = urn:ietf:bcp:47#ga "Irish"

* generalPractitioner = Reference(ie-core-practitioner-example) "Dr. Sarah O'Brien"
* managingOrganization = Reference(ie-core-organization-example) "St. James's Hospital"


// ====================================================================
// 2. Patient – Pediatric (Aoife Kelly, Cork)
// ====================================================================

Instance: ie-core-patient-child-example
InstanceOf: IECorePatient
Usage: #example
Title: "IE Core Patient Child Example"
Description: "An example IE Core Patient representing a paediatric patient in Cork."

* identifier[IHI].system = $IHI
* identifier[IHI].type = $V2-0203#NI "National unique individual identifier"
* identifier[IHI].value = "210000000087654321"

* identifier[IMN].system = $IMN
* identifier[IMN].type = $V2-0203#NI "National unique individual identifier"
* identifier[IMN].value = "IMN-2021-098765"

* active = true
* name[0].use = #official
* name[=].family = "Kelly"
* name[=].given = "Aoife"
* gender = #female
* birthDate = "2021-09-23"

* address[0].use = #home
* address[=].type = #physical
* address[=].line = "8 St. Patrick's Hill"
* address[=].city = "Cork"
* address[=].state = "Cork"
* address[=].postalCode = "T12 AB34"
* address[=].country = "IE"

* telecom[0].system = #phone
* telecom[=].value = "+353 21 555 0456"
* telecom[=].use = #home

* communication[0].language = urn:ietf:bcp:47#en "English"
* communication[=].preferred = true

* contact[0].relationship = http://terminology.hl7.org/CodeSystem/v2-0131#N "Next-of-Kin"
* contact[=].name.family = "Kelly"
* contact[=].name.given = "Siobhán"
* contact[=].telecom.system = #phone
* contact[=].telecom.value = "+353 86 555 0789"
* contact[=].telecom.use = #mobile


// ====================================================================
// 3. Patient – Deceased (Seán O'Connor, Galway)
// ====================================================================

Instance: ie-core-patient-deceased-example
InstanceOf: IECorePatient
Usage: #example
Title: "IE Core Patient Deceased Example"
Description: "An example IE Core Patient representing a deceased patient from Galway with a deceasedDateTime."

* identifier[IHI].system = $IHI
* identifier[IHI].type = $V2-0203#NI "National unique individual identifier"
* identifier[IHI].value = "210000000011223344"

* identifier[GMS].system = $GMS
* identifier[GMS].type = $V2-0203#MC "Patient's Medicare number"
* identifier[GMS].value = "7654321B"

* active = false
* name[0].use = #official
* name[=].family = "O'Connor"
* name[=].given[0] = "Seán"
* name[=].given[+] = "Michael"
* name[=].prefix = "Mr."
* gender = #male
* birthDate = "1945-03-12"
* deceasedDateTime = "2024-11-15T10:30:00+00:00"

* address[0].use = #home
* address[=].type = #physical
* address[=].line = "15 Shop Street"
* address[=].city = "Galway"
* address[=].state = "Galway"
* address[=].postalCode = "H91 CD56"
* address[=].country = "IE"

* telecom[0].system = #phone
* telecom[=].value = "+353 91 555 0234"
* telecom[=].use = #home

* communication[0].language = urn:ietf:bcp:47#en "English"


// ====================================================================
// 4. Practitioner – Dr. Sarah O'Brien
// ====================================================================

Instance: ie-core-practitioner-example
InstanceOf: IECorePractitioner
Usage: #example
Title: "IE Core Practitioner Example"
Description: "An example IE Core Practitioner representing a General Practitioner with IMC registration and HPI identifier."

* identifier[IMC].system = $IMC
* identifier[IMC].type = $V2-0203#MD "Medical License number"
* identifier[IMC].value = "IMC-12345"

* identifier[HPI].system = $HPI
* identifier[HPI].type = $V2-0203#NPI "National provider identifier"
* identifier[HPI].value = "HPI-IE-001234"

* active = true
* name[0].use = #official
* name[=].family = "O'Brien"
* name[=].given = "Sarah"
* name[=].prefix = "Dr."
* gender = #female

* telecom[0].system = #phone
* telecom[=].value = "+353 1 410 3456"
* telecom[=].use = #work
* telecom[+].system = #email
* telecom[=].value = "sarah.obrien@sjh.ie"
* telecom[=].use = #work

* address[0].use = #work
* address[=].line = "James's Street"
* address[=].city = "Dublin"
* address[=].state = "Dublin"
* address[=].postalCode = "D08 NHY1"
* address[=].country = "IE"

* qualification[0].code = $SCT#309343006 "Physician"
* qualification[=].issuer.display = "Irish Medical Council"


// ====================================================================
// 5. PractitionerRole – General Practitioner
// ====================================================================

Instance: ie-core-practitionerrole-example
InstanceOf: IECorePractitionerRole
Usage: #example
Title: "IE Core PractitionerRole Example"
Description: "An example IE Core PractitionerRole linking Dr. Sarah O'Brien to St. James's Hospital as a General Practitioner."

* active = true
* period.start = "2018-01-01"
* practitioner = Reference(ie-core-practitioner-example) "Dr. Sarah O'Brien"
* organization = Reference(ie-core-organization-example) "St. James's Hospital"
* code = $SCT#62247001 "General practitioner"
* specialty = $SCT#394814009 "General practice (specialty)"

* telecom[0].system = #phone
* telecom[=].value = "+353 1 410 3456"
* telecom[=].use = #work

* location = Reference(ie-core-location-example) "St. James's Hospital – GP Clinic"
* availableTime[0].daysOfWeek[0] = #mon
* availableTime[=].daysOfWeek[+] = #tue
* availableTime[=].daysOfWeek[+] = #wed
* availableTime[=].daysOfWeek[+] = #thu
* availableTime[=].daysOfWeek[+] = #fri
* availableTime[=].availableStartTime = "09:00:00"
* availableTime[=].availableEndTime = "17:00:00"


// ====================================================================
// 6. Organization – St. James's Hospital
// ====================================================================

Instance: ie-core-organization-example
InstanceOf: IECoreOrganization
Usage: #example
Title: "IE Core Organization Example"
Description: "An example IE Core Organization representing St. James's Hospital, Dublin — a major acute hospital under the HSE."

* identifier[0].system = $CRN
* identifier[=].value = "IE-SJH-001"

* identifier[+].system = $HPI
* identifier[=].value = "HPI-IE-ORG-SJH"

* active = true
* type = http://terminology.hl7.org/CodeSystem/organization-type#prov "Healthcare Provider"
* name = "St. James's Hospital"

* telecom[0].system = #phone
* telecom[=].value = "+353 1 410 3000"
* telecom[=].use = #work
* telecom[+].system = #email
* telecom[=].value = "info@stjames.ie"
* telecom[=].use = #work

* address[0].use = #work
* address[=].type = #physical
* address[=].line = "James's Street"
* address[=].city = "Dublin"
* address[=].state = "Dublin"
* address[=].postalCode = "D08 NHY1"
* address[=].country = "IE"


// ====================================================================
// Supporting: Location for PractitionerRole reference
// ====================================================================

Instance: ie-core-location-example
InstanceOf: IECoreLocation
Usage: #example
Title: "IE Core Location Example"
Description: "An example IE Core Location representing the GP Clinic at St. James's Hospital."

* status = #active
* name = "St. James's Hospital – GP Clinic"
* mode = #instance
* type = http://terminology.hl7.org/CodeSystem/v3-RoleCode#HOSP "Hospital"
* telecom[0].system = #phone
* telecom[=].value = "+353 1 410 3456"
* telecom[=].use = #work
* address.use = #work
* address.line = "James's Street"
* address.city = "Dublin"
* address.state = "Dublin"
* address.postalCode = "D08 NHY1"
* address.country = "IE"
* managingOrganization = Reference(ie-core-organization-example) "St. James's Hospital"


// ====================================================================
// 7. Encounter – Ambulatory
// ====================================================================

Instance: ie-core-encounter-example
InstanceOf: IECoreEncounter
Usage: #example
Title: "IE Core Encounter Example"
Description: "An example IE Core Encounter representing a completed ambulatory consultation at St. James's Hospital."

* identifier[0].system = "http://stjames.ie/encounters"
* identifier[=].value = "ENC-2024-005678"

* status = #finished
* class = $V3-ActCode#AMB "ambulatory"
* type = $SCT#11429006 "Consultation"

* subject = Reference(ie-core-patient-example) "John Murphy"
* participant[0].type = http://terminology.hl7.org/CodeSystem/v3-ParticipationType#ATND "attender"
* participant[=].individual = Reference(ie-core-practitioner-example) "Dr. Sarah O'Brien"

* period.start = "2024-06-15T09:00:00+01:00"
* period.end = "2024-06-15T09:30:00+01:00"

* reasonCode = $SCT#185347001 "Encounter for problem"
* serviceProvider = Reference(ie-core-organization-example) "St. James's Hospital"
* location[0].location = Reference(ie-core-location-example) "St. James's Hospital – GP Clinic"
* location[=].status = #completed


// ====================================================================
// 8. Condition – Diabetes Mellitus Type 2
// ====================================================================

Instance: ie-core-condition-example
InstanceOf: IECoreConditionProblemsHealthConcerns
Usage: #example
Title: "IE Core Condition Example"
Description: "An example IE Core Condition representing a confirmed diagnosis of Type 2 Diabetes Mellitus."

* clinicalStatus = http://terminology.hl7.org/CodeSystem/condition-clinical#active "Active"
* verificationStatus = $CondVerStatus#confirmed "Confirmed"
* category[ProblemListItem] = $CondCat#problem-list-item "Problem List Item"
* code = $SCT#44054006 "Diabetes mellitus type 2"
* code.text = "Type 2 Diabetes Mellitus"

* subject = Reference(ie-core-patient-example) "John Murphy"
* onsetDateTime = "2020-03-15"
* recordedDate = "2020-03-15"


// ====================================================================
// 9. Observation – Blood Pressure
// ====================================================================

Instance: ie-core-observation-bp-example
InstanceOf: IECoreBloodPressure
Usage: #example
Title: "IE Core Blood Pressure Observation Example"
Description: "An example IE Core Blood Pressure Observation with systolic 120 mmHg and diastolic 80 mmHg."

* status = #final
* category[VSCat] = $ObsCat#vital-signs "Vital Signs"
* code = $LOINC#85354-9 "Blood pressure panel with all children optional"
* code.text = "Blood Pressure"

* subject = Reference(ie-core-patient-example) "John Murphy"
* encounter = Reference(ie-core-encounter-example) "Ambulatory encounter 2024-06-15"
* effectiveDateTime = "2024-06-15T09:15:00+01:00"
* performer = Reference(ie-core-practitioner-example) "Dr. Sarah O'Brien"

* component[systolic].code = $LOINC#8480-6 "Systolic blood pressure"
* component[systolic].valueQuantity = 120 'mm[Hg]' "mmHg"
* component[diastolic].code = $LOINC#8462-4 "Diastolic blood pressure"
* component[diastolic].valueQuantity = 80 'mm[Hg]' "mmHg"


// ====================================================================
// 10. Observation – HbA1c Laboratory Result
// ====================================================================

Instance: ie-core-observation-lab-example
InstanceOf: IECoreLaboratoryResultObservation
Usage: #example
Title: "IE Core Laboratory Observation Example"
Description: "An example IE Core Laboratory Observation representing an HbA1c test result of 7.2%, which is above the normal reference range."

* status = #final
* category[ie-laboratory] = $ObsCat#laboratory "Laboratory"

* code = $LOINC#4548-4 "Hemoglobin A1c/Hemoglobin.total in Blood"
* code.text = "HbA1c"

* subject = Reference(ie-core-patient-example) "John Murphy"
* encounter = Reference(ie-core-encounter-example) "Ambulatory encounter 2024-06-15"
* effectiveDateTime = "2024-06-15T08:00:00+01:00"
* issued = "2024-06-15T14:00:00+01:00"
* performer = Reference(ie-core-organization-example) "St. James's Hospital"

* valueQuantity = 7.2 '%' "%"
* interpretation = http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation#H "High"

* referenceRange[0].low = 4.0 '%' "%"
* referenceRange[=].high = 5.6 '%' "%"
* referenceRange[=].text = "Normal: 4.0% – 5.6%"


// ====================================================================
// 11. AllergyIntolerance – Penicillin Allergy
// ====================================================================

Instance: ie-core-allergy-example
InstanceOf: IECoreAllergyIntolerance
Usage: #example
Title: "IE Core AllergyIntolerance Example"
Description: "An example IE Core AllergyIntolerance representing a confirmed penicillin allergy with urticaria as a reaction."

* clinicalStatus = http://terminology.hl7.org/CodeSystem/allergyintolerance-clinical#active "Active"
* verificationStatus = http://terminology.hl7.org/CodeSystem/allergyintolerance-verification#confirmed "Confirmed"
* type = #allergy
* category = #medication
* criticality = #high

* code = $SCT#764146007 "Penicillin"
* code.text = "Penicillin"

* patient = Reference(ie-core-patient-example) "John Murphy"
* onsetDateTime = "2010-06-01"
* recordedDate = "2010-06-05"
* recorder = Reference(ie-core-practitioner-example) "Dr. Sarah O'Brien"

* reaction[0].substance = $SCT#764146007 "Penicillin"
* reaction[=].manifestation = $SCT#126485001 "Urticaria"
* reaction[=].severity = #moderate


// ====================================================================
// 12. MedicationRequest – Metformin Prescription
// ====================================================================

Instance: ie-core-medicationrequest-example
InstanceOf: IECoreMedicationRequest
Usage: #example
Title: "IE Core MedicationRequest Example"
Description: "An example IE Core MedicationRequest representing a prescription for Metformin 500mg tablets for the management of Type 2 Diabetes."

* status = #active
* intent = #order

* medicationCodeableConcept = $SCT#372567009 "Metformin"
* medicationCodeableConcept.text = "Metformin 500mg tablets"

* subject = Reference(ie-core-patient-example) "John Murphy"
* encounter = Reference(ie-core-encounter-example) "Ambulatory encounter 2024-06-15"
* authoredOn = "2024-06-15"
* requester = Reference(ie-core-practitioner-example) "Dr. Sarah O'Brien"

* dosageInstruction[0].sequence = 1
* dosageInstruction[=].text = "Take one 500mg tablet twice daily with meals"
* dosageInstruction[=].timing.repeat.frequency = 2
* dosageInstruction[=].timing.repeat.period = 1
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].route = $SCT#26643006 "Oral route"
* dosageInstruction[=].doseAndRate[0].doseQuantity = 500 'mg' "mg"

* dispenseRequest.numberOfRepeatsAllowed = 6
* dispenseRequest.quantity = 60 '{tablet}' "tablets"
* dispenseRequest.expectedSupplyDuration = 30 'd' "days"


// ====================================================================
// 13. Immunization – COVID-19 Vaccination
// ====================================================================

Instance: ie-core-immunization-example
InstanceOf: IECoreImmunization
Usage: #example
Title: "IE Core Immunization Example"
Description: "An example IE Core Immunization representing a Pfizer-BioNTech COVID-19 vaccine administration recorded within the Irish national immunisation programme."

* status = #completed

* vaccineCode = $CVX#208 "SARS-COV-2 (COVID-19) vaccine, mRNA, spike protein, LNP, preservative free, 30 mcg/0.3mL dose"
* vaccineCode.text = "Pfizer-BioNTech COVID-19 Vaccine (Comirnaty)"

* patient = Reference(ie-core-patient-example) "John Murphy"
* occurrenceDateTime = "2021-05-20T10:00:00+01:00"
* recorded = "2021-05-20T10:15:00+01:00"
* primarySource = true

* lotNumber = "EW8183"
* expirationDate = "2021-08-31"

* site = $SCT#368208006 "Left upper arm structure"
* route = $SCT#78421000 "Intramuscular route"
* doseQuantity = 0.3 'mL' "mL"

* performer[0].function = http://terminology.hl7.org/CodeSystem/v2-0443#AP "Administering Provider"
* performer[=].actor = Reference(ie-core-practitioner-example) "Dr. Sarah O'Brien"

* protocolApplied[0].doseNumberPositiveInt = 1
* protocolApplied[=].seriesDosesPositiveInt = 2


// ====================================================================
// 14. Provenance – Patient Record
// ====================================================================

Instance: ie-core-provenance-example
InstanceOf: IECoreProvenance
Usage: #example
Title: "IE Core Provenance Example"
Description: "An example IE Core Provenance resource documenting that Dr. Sarah O'Brien authored the patient record at St. James's Hospital."

* target = Reference(ie-core-patient-example) "John Murphy"
* recorded = "2024-06-15T14:30:00.000+01:00"

* agent[0].type = $ProvenanceParticipant#author "Author"
* agent[=].who = Reference(ie-core-practitioner-example) "Dr. Sarah O'Brien"
* agent[=].onBehalfOf = Reference(ie-core-organization-example) "St. James's Hospital"
