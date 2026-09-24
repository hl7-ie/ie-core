// ╭──────────────────────────────────────────────────────────────────────╮
// │  HIQA 2026 scenario examples (Phase 8)                               │
// │  Eight synthetic Irish scenarios that exercise the HIQA Draft        │
// │  National Standards (Sept 2026) for ePrescription/eDispensation and  │
// │  the Patient Summary:                                                │
// │    1. Acute adult prescription + dispense                            │
// │    2. Paediatric (under 12) prescription with age and weight         │
// │    3. Repeat prescription with a part fill, balance and a repeat     │
// │    4. Controlled drug (Schedule 2) with instalments                  │
// │    5. Non-dispensation (declined, with reason)                       │
// │    6. Cross-border IE → EU with prescriber signature                 │
// │    7. Full Patient Summary                                           │
// │    8. Patient Summary with empty sections (emptyReason)              │
// │  All people, organisations and identifiers are FICTIONAL. Identifier │
// │  values use 9-prefixed ranges. Every external code was verified on   │
// │  tx.fhir.org (scripts/terminology/verify_codes.py). ePrescription    │
// │  patients carry no ethnicity, nationality or mother's maiden name    │
// │  (ADR-002).                                                          │
// ╰──────────────────────────────────────────────────────────────────────╯

// Bundle entry with a resolvable fullUrl. References inside the Bundle are relative (Type/id).
RuleSet: HIQAEntry(type, id)
* entry[+].fullUrl = "http://example.org/fhir/{type}/{id}"
* entry[=].resource = {id}

// Section narrative (EPS: section.text 1..1)
RuleSet: HIQASectionText(section, text)
* section[{section}].text.status = #generated
* section[{section}].text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\"><p>{text}</p></div>"

RuleSet: HIQAEmptySection(section, reason, reasonDisplay, text)
* insert HIQASectionText({section}, {text})
* section[{section}].emptyReason = http://terminology.hl7.org/CodeSystem/list-empty-reason#{reason} "{reasonDisplay}"


// ====================================================================
// SHARED ACTORS: GP practice, prescriber, pharmacy, pharmacist
// ====================================================================

Instance: hiqa-prac-gp-nolan
InstanceOf: IECorePractitioner
Usage: #example
Title: "HIQA scenarios – Dr Clodagh Nolan (GP, fictional)"
Description: "Fictional general practitioner, the prescriber in the HIQA scenarios (HIQA EP Section 2)."
* identifier[IMC].value = "999001"
* active = true
* name[0].use = #official
* name[=].family = "Nolan"
* name[=].given = "Clodagh"
* name[=].prefix = "Dr"
* telecom[0].system = #phone
* telecom[=].value = "+353 90 000 0001"
* telecom[=].use = #work

Instance: hiqa-org-gp-practice
InstanceOf: IECoreOrganization
Usage: #example
Title: "HIQA scenarios – Riverside Family Practice (fictional)"
Description: "Fictional GP practice: the prescriber's facility (HIQA EP 2.7–2.12), with a GMS Panel ID (EP 2.12)."
* identifier[GMSPanel].value = "99001"
* active = true
* type = http://terminology.hl7.org/CodeSystem/organization-type#prov "Healthcare Provider"
* name = "Riverside Family Practice"
* telecom[0].system = #phone
* telecom[=].value = "+353 90 000 0000"
* telecom[=].use = #work
* telecom[+].system = #email
* telecom[=].value = "prescriptions@riverside-practice.example.org"
* telecom[=].use = #work
* address[0].use = #work
* address[=].type = #physical
* address[=].line = "1 River Road"
* address[=].city = "Athlone"
* address[=].state = "Westmeath"
* address[=].postalCode = "N37 XX01"
* address[=].country = "IE"

Instance: hiqa-role-gp-nolan
InstanceOf: IECorePractitionerRole
Usage: #example
Title: "HIQA scenarios – Dr Clodagh Nolan at Riverside Family Practice"
Description: "The prescriber's role and contact details (HIQA EP 2.5, 2.10.1 telephone, 2.10.2 secure email)."
* active = true
* practitioner = Reference(hiqa-prac-gp-nolan) "Dr Clodagh Nolan"
* organization = Reference(hiqa-org-gp-practice) "Riverside Family Practice"
* telecom[0].system = #phone
* telecom[=].value = "+353 90 000 0001"
* telecom[=].use = #work
* telecom[+].system = #email
* telecom[=].value = "clodagh.nolan@riverside-practice.example.org"
* telecom[=].use = #work

Instance: hiqa-org-pharmacy
InstanceOf: IECoreOrganization
Usage: #example
Title: "HIQA scenarios – Bridge Street Pharmacy (fictional)"
Description: "Fictional community pharmacy with a PSI Retail Pharmacy Business registration number (HIQA EP 2.8)."
* identifier[PSIRPB].value = "9991"
* active = true
* type = http://terminology.hl7.org/CodeSystem/organization-type#prov "Healthcare Provider"
* name = "Bridge Street Pharmacy"
* telecom[0].system = #phone
* telecom[=].value = "+353 90 000 0100"
* telecom[=].use = #work
* address[0].use = #work
* address[=].line = "5 Bridge Street"
* address[=].city = "Athlone"
* address[=].state = "Westmeath"
* address[=].postalCode = "N37 XX02"
* address[=].country = "IE"

Instance: hiqa-prac-pharmacist-farrell
InstanceOf: IECorePractitioner
Usage: #example
Title: "HIQA scenarios – Eoin Farrell (pharmacist, fictional)"
Description: "Fictional registered pharmacist with a PSI registration number (HIQA EP 2.6.2)."
* identifier[PSI].value = "99901"
* active = true
* name[0].use = #official
* name[=].family = "Farrell"
* name[=].given = "Eoin"
* telecom[0].system = #phone
* telecom[=].value = "+353 90 000 0100"
* telecom[=].use = #work


// ====================================================================
// PATIENTS (ePrescription dataset only: ADR-002)
// ====================================================================

Instance: hiqa-patient-tomas-quinn
InstanceOf: IECorePatientEPrescription
Usage: #example
Title: "HIQA scenarios – Tomás Quinn (adult, fictional)"
Description: "Adult patient for scenario 1 (acute prescription). Only the HIQA EP Section 1 dataset: no ethnicity, nationality or mother's maiden name."
* identifier[0].system = $IHI
* identifier[=].type = $V2-0203#NI "National unique individual identifier"
* identifier[=].value = "999000000000000001"
* insert PCRSIdentifier($GMS, medical-card, Medical card scheme number, 9900001A)
* name[0].use = #official
* name[=].family = "Quinn"
* name[=].given = "Tomás"
* gender = #male
* insert SexAssignedAtBirth(male, Male)
* birthDate = "1979-06-21"
* address[0].use = #home
* address[=].line = "12 Shannon View"
* address[=].city = "Athlone"
* address[=].state = "Westmeath"
* address[=].postalCode = "N37 XX10"
* address[=].country = "IE"

Instance: hiqa-patient-oisin-brady
InstanceOf: IECorePatientEPrescription
Usage: #example
Title: "HIQA scenarios – Oisín Brady (5 years old, fictional)"
Description: "Paediatric patient for scenario 2. Under 12 at the date of prescribing, so the prescription must state the age (HIQA EP 1.4.2)."
* identifier[0].system = $IHI
* identifier[=].type = $V2-0203#NI "National unique individual identifier"
* identifier[=].value = "999000000000000002"
* name[0].use = #official
* name[=].family = "Brady"
* name[=].given = "Oisín"
* gender = #male
* insert SexAssignedAtBirth(male, Male)
* birthDate = "2021-03-02"
* address[0].use = #home
* address[=].line = "3 Church Lane"
* address[=].city = "Moate"
* address[=].state = "Westmeath"
* address[=].postalCode = "N37 XX11"
* address[=].country = "IE"

Instance: hiqa-patient-niamh-keane
InstanceOf: IECorePatientEPrescription
Usage: #example
Title: "HIQA scenarios – Niamh Keane (adult with asthma and penicillin allergy, fictional)"
Description: "Adult patient for scenarios 3 (repeat) and 5 (non-dispensation)."
* identifier[0].system = $IHI
* identifier[=].type = $V2-0203#NI "National unique individual identifier"
* identifier[=].value = "999000000000000003"
* name[0].use = #official
* name[=].family = "Keane"
* name[=].given = "Niamh"
* gender = #female
* insert SexAssignedAtBirth(female, Female)
* birthDate = "1990-11-08"
* address[0].use = #home
* address[=].line = "27 Abbey Road"
* address[=].city = "Athlone"
* address[=].state = "Westmeath"
* address[=].postalCode = "N37 XX12"
* address[=].country = "IE"
* telecom[0].system = #phone
* telecom[=].value = "+353 87 000 0003"
* telecom[=].use = #mobile

Instance: hiqa-patient-declan-walsh
InstanceOf: IECorePatientEPrescription
Usage: #example
Title: "HIQA scenarios – Declan Walsh (adult, fictional)"
Description: "Adult patient for scenarios 4 (controlled drug) and 6 (cross-border)."
* identifier[0].system = $IHI
* identifier[=].type = $V2-0203#NI "National unique individual identifier"
* identifier[=].value = "999000000000000004"
* name[0].use = #official
* name[=].family = "Walsh"
* name[=].given = "Declan"
* gender = #male
* insert SexAssignedAtBirth(male, Male)
* birthDate = "1961-11-30"
* address[0].use = #home
* address[=].line = "8 Mill Street"
* address[=].city = "Athlone"
* address[=].state = "Westmeath"
* address[=].postalCode = "N37 XX13"
* address[=].country = "IE"


// ====================================================================
// MEDICINAL PRODUCTS (HIQA EP Section 4)
// ====================================================================

Instance: hiqa-med-amoxicillin-500-caps
InstanceOf: IECoreMedicationEPrescription
Usage: #example
Title: "HIQA scenarios – Amoxicillin 500 mg oral capsule"
Description: "SNOMED CT product code; ATC classification and supply legal status (HIQA EP 4.2)."
* code = $SCT#323510009 "Amoxicillin 500 mg oral capsule"
* code.text = "Amoxicillin 500 mg capsules"
* extension[classification][0].valueCodeableConcept = $ATC#J01CA04 "amoxicillin"
* extension[classification][+].valueCodeableConcept = IECoreSupplyLegalStatus#prescription-only "Prescription only medicine"
* form = $SCT#385049006 "Capsule"
* ingredient[0].itemCodeableConcept = $SCT#372687004 "Amoxicillin"
* ingredient[=].isActive = true
* ingredient[=].strength.numerator = 500 'mg' "mg"
* ingredient[=].strength.denominator = 1 '{capsule}' "capsule"

Instance: hiqa-med-amoxicillin-50mgml-susp
InstanceOf: IECoreMedicationEPrescription
Usage: #example
Title: "HIQA scenarios – Amoxicillin 50 mg/mL oral suspension"
Description: "Paediatric oral suspension (scenario 2)."
* code = $SCT#1148466008 "Amoxicillin 50 mg/mL oral suspension"
* code.text = "Amoxicillin 250 mg/5 mL oral suspension"
* extension[classification][0].valueCodeableConcept = $ATC#J01CA04 "amoxicillin"
* extension[classification][+].valueCodeableConcept = IECoreSupplyLegalStatus#prescription-only "Prescription only medicine"
* form = $SCT#385024007 "Oral suspension"
* ingredient[0].itemCodeableConcept = $SCT#372687004 "Amoxicillin"
* ingredient[=].isActive = true
* ingredient[=].strength.numerator = 50 'mg' "mg"
* ingredient[=].strength.denominator = 1 'mL' "mL"

Instance: hiqa-med-salbutamol-inhaler
InstanceOf: IECoreMedicationEPrescription
Usage: #example
Title: "HIQA scenarios – Salbutamol 100 micrograms/actuation pressurised inhaler"
Description: "Repeat medication (scenarios 3 and 7). SNOMED CT uses the USAN name albuterol."
* code = $SCT#770300007 "Albuterol (as albuterol sulfate) 100 microgram/actuation pressurized suspension for inhalation"
* code.text = "Salbutamol 100 micrograms/dose pressurised inhalation suspension"
* extension[classification][0].valueCodeableConcept = $ATC#R03AC02 "salbutamol"
* form = $SCT#385205001 "Pressurized suspension for inhalation"
* amount.numerator = 200 '{actuation}' "actuations"
* amount.denominator = 1 '{inhaler}' "inhaler"
* ingredient[0].itemCodeableConcept = $SCT#372897005 "Albuterol"
* ingredient[=].isActive = true
* ingredient[=].strength.numerator = 100 'ug' "microgram"
* ingredient[=].strength.denominator = 1 '{actuation}' "actuation"

Instance: hiqa-med-oxycodone-10-pr
InstanceOf: IECoreMedicationEPrescription
Usage: #example
Title: "HIQA scenarios – Oxycodone hydrochloride 10 mg prolonged-release tablet (Schedule 2)"
Description: "Controlled drug (scenario 4). The MDA schedule (HIQA EP 4.2.3) uses the IECoreMDASchedule placeholder code system (Requires Clarification, OI-007); it drives invariants ie-rx-cd-1 and ie-rx-cd-2."
* code = $SCT#765706002 "Oxycodone hydrochloride 10 mg prolonged-release oral tablet"
* code.text = "Oxycodone hydrochloride 10 mg prolonged-release tablets"
* extension[classification][0].valueCodeableConcept = $ATC#N02AA05 "oxycodone"
* extension[classification][+].valueCodeableConcept = IECoreMDASchedule#schedule-2 "Schedule 2"
* extension[classification][+].valueCodeableConcept = IECoreSupplyLegalStatus#prescription-only "Prescription only medicine"
* form = $SCT#385060002 "Prolonged-release oral tablet"
* ingredient[0].itemCodeableConcept = $SCT#387024006 "Oxycodone hydrochloride"
* ingredient[=].isActive = true
* ingredient[=].strength.numerator = 10 'mg' "mg"
* ingredient[=].strength.denominator = 1 '{tablet}' "tablet"


// ====================================================================
// ALLERGY STATEMENTS (HIQA EP 1.6.1 / 1.6.2)
// ====================================================================

Instance: hiqa-allergies-tomas-nilknown
InstanceOf: IECoreListAllergiesAtPrescribing
Usage: #example
Title: "HIQA scenarios – Allergy statement: no known allergies (Tomás Quinn)"
Description: "HIQA EP 1.6.1: no allergies recorded because the patient has none known (nilknown), which is different from 'not asked'."
* status = #current
* mode = #snapshot
* subject = Reference(hiqa-patient-tomas-quinn)
* date = "2026-09-21T09:40:00+01:00"
* source = Reference(hiqa-role-gp-nolan)
* emptyReason = http://terminology.hl7.org/CodeSystem/list-empty-reason#nilknown "Nil Known"

Instance: hiqa-allergies-oisin-nilknown
InstanceOf: IECoreListAllergiesAtPrescribing
Usage: #example
Title: "HIQA scenarios – Allergy statement: no known allergies (Oisín Brady)"
Description: "HIQA EP 1.6.1, confirmed with the child's parent at the consultation."
* status = #current
* mode = #snapshot
* subject = Reference(hiqa-patient-oisin-brady)
* date = "2026-09-20T10:05:00+01:00"
* source = Reference(hiqa-role-gp-nolan)
* emptyReason = http://terminology.hl7.org/CodeSystem/list-empty-reason#nilknown "Nil Known"

Instance: hiqa-allergy-niamh-penicillin
InstanceOf: IECoreAllergyIntolerance
Usage: #example
Title: "HIQA scenarios – Allergy to penicillin (Niamh Keane)"
Description: "HIQA EP 1.6.2 / PS 5.3: confirmed penicillin allergy with anaphylaxis."
* clinicalStatus = http://terminology.hl7.org/CodeSystem/allergyintolerance-clinical#active "Active"
* verificationStatus = http://terminology.hl7.org/CodeSystem/allergyintolerance-verification#confirmed "Confirmed"
* type = #allergy
* category = #medication
* criticality = #high
* code = $SCT#91936005 "Allergy to penicillin"
* patient = Reference(hiqa-patient-niamh-keane)
* recordedDate = "2015-04-10"
* reaction[0].manifestation = $SCT#39579001 "Anaphylaxis"
* reaction[=].severity = #severe

Instance: hiqa-allergies-niamh
InstanceOf: IECoreListAllergiesAtPrescribing
Usage: #example
Title: "HIQA scenarios – Allergy statement listing penicillin allergy (Niamh Keane)"
Description: "HIQA EP 1.6.2: the allergy statement lists the recorded allergies."
* status = #current
* mode = #snapshot
* subject = Reference(hiqa-patient-niamh-keane)
* date = "2026-09-01T11:00:00+01:00"
* source = Reference(hiqa-role-gp-nolan)
* entry[0].item = Reference(hiqa-allergy-niamh-penicillin)

Instance: hiqa-allergies-declan-nilknown
InstanceOf: IECoreListAllergiesAtPrescribing
Usage: #example
Title: "HIQA scenarios – Allergy statement: no known allergies (Declan Walsh)"
Description: "HIQA EP 1.6.1."
* status = #current
* mode = #snapshot
* subject = Reference(hiqa-patient-declan-walsh)
* date = "2026-09-15T15:00:00+01:00"
* source = Reference(hiqa-role-gp-nolan)
* emptyReason = http://terminology.hl7.org/CodeSystem/list-empty-reason#nilknown "Nil Known"


// ====================================================================
// SCENARIO 1: acute adult prescription and dispense
// ====================================================================

Instance: hiqa-rx-s1-amoxicillin
InstanceOf: IECoreMedicationRequestEPrescription
Usage: #example
Title: "Scenario 1 – Acute prescription: amoxicillin 500 mg for acute sinusitis"
Description: "Single-item acute prescription (HIQA EP Section 3)."
* identifier[0].system = $NePS
* identifier[=].value = "9-RX-2026-000001-1"
* groupIdentifier.system = $NePS
* groupIdentifier.value = "9-RX-2026-000001"
* status = #active
* intent = #order
* courseOfTherapyType = http://terminology.hl7.org/CodeSystem/medicationrequest-course-of-therapy#acute "Short course (acute) therapy"
* medicationReference = Reference(hiqa-med-amoxicillin-500-caps)
* subject = Reference(hiqa-patient-tomas-quinn)
* supportingInformation = Reference(hiqa-allergies-tomas-nilknown)
* authoredOn = "2026-09-21T09:45:00+01:00"
* requester = Reference(hiqa-role-gp-nolan)
* reasonCode = $SCT#15805002 "Acute sinusitis"
* dosageInstruction[0].text = "Take one capsule three times a day for 7 days"
* dosageInstruction[=].timing.repeat.frequency = 3
* dosageInstruction[=].timing.repeat.period = 1
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].timing.repeat.boundsDuration = 7 'd' "days"
* dosageInstruction[=].route = $SCT#26643006 "Oral route"
* dosageInstruction[=].doseAndRate[0].doseQuantity = 1 '{capsule}' "capsule"
* dispenseRequest.quantity = 21 '{capsule}' "capsules"
* dispenseRequest.validityPeriod.start = "2026-09-21"
* dispenseRequest.validityPeriod.end = "2026-10-21"
* dispenseRequest.numberOfRepeatsAllowed = 0
* substitution.allowedBoolean = true

Instance: hiqa-md-s1-amoxicillin
InstanceOf: IECoreMedicationDispenseEDispensation
Usage: #example
Title: "Scenario 1 – Dispense: amoxicillin 500 mg, completed"
Description: "Completed dispensation (HIQA EP Section 6) handed to the patient."
* identifier[0].system = "urn:ietf:rfc:3986"
* identifier[=].value = "urn:uuid:180c4a4b-b747-5d0d-8816-2323dc03cc87"
* extension[recorded].valueDateTime = "2026-09-21T11:20:00+01:00"
* status = #completed
* medicationReference = Reference(hiqa-med-amoxicillin-500-caps)
* subject = Reference(hiqa-patient-tomas-quinn)
* performer[0].actor = Reference(hiqa-prac-pharmacist-farrell)
* performer[+].actor = Reference(hiqa-org-pharmacy)
* authorizingPrescription = Reference(hiqa-rx-s1-amoxicillin)
* type = http://terminology.hl7.org/CodeSystem/v3-ActCode#FF "First Fill"
* quantity = 21 '{capsule}' "capsules"
* whenHandedOver = "2026-09-21T11:15:00+01:00"
* receiver = Reference(hiqa-patient-tomas-quinn)
* dosageInstruction[0].text = "Take one capsule three times a day for 7 days"
* substitution.wasSubstituted = false

Instance: hiqa-bundle-s1-acute-adult
InstanceOf: IECoreBundleEPrescription
Usage: #example
Title: "Scenario 1 – ePrescription Bundle: acute adult prescription"
Description: "HIQA EP: patient, prescriber, facility, medicinal product, allergy statement (nilknown) and one prescription item."
* identifier.system = $NePS
* identifier.value = "9-RX-2026-000001"
* type = #collection
* timestamp = "2026-09-21T09:45:00+01:00"
* insert HIQAEntry(Patient, hiqa-patient-tomas-quinn)
* insert HIQAEntry(MedicationRequest, hiqa-rx-s1-amoxicillin)
* insert HIQAEntry(List, hiqa-allergies-tomas-nilknown)
* insert HIQAEntry(PractitionerRole, hiqa-role-gp-nolan)
* insert HIQAEntry(Practitioner, hiqa-prac-gp-nolan)
* insert HIQAEntry(Organization, hiqa-org-gp-practice)
* insert HIQAEntry(Medication, hiqa-med-amoxicillin-500-caps)


// ====================================================================
// SCENARIO 2: paediatric (under 12) prescription
// ====================================================================

Instance: hiqa-weight-oisin
InstanceOf: IECoreBodyWeight
Usage: #example
Title: "Scenario 2 – Body weight 19 kg (Oisín Brady)"
Description: "HIQA EP 1.6.3 Weight: supports weight-based paediatric dosing."
* status = #final
* subject = Reference(hiqa-patient-oisin-brady)
* effectiveDateTime = "2026-09-20T10:00:00+01:00"
* valueQuantity = 19 'kg' "kg"

Instance: hiqa-rx-s2-amoxicillin-paeds
InstanceOf: IECoreMedicationRequestEPrescription
Usage: #example
Title: "Scenario 2 – Paediatric prescription: amoxicillin suspension for acute otitis media"
Description: "The patient is 5 years old: the age at prescribing is recorded (HIQA EP 1.4.2; legal requirement under 12; invariants ie-rx-age-1 and ie-bnd-rx-3). The weight is referenced as supporting information (EP 1.6.3)."
* identifier[0].system = $NePS
* identifier[=].value = "9-RX-2026-000002-1"
* groupIdentifier.system = $NePS
* groupIdentifier.value = "9-RX-2026-000002"
* extension[ageAtPrescribing].valueAge = 5 'a' "years"
* status = #active
* intent = #order
* courseOfTherapyType = http://terminology.hl7.org/CodeSystem/medicationrequest-course-of-therapy#acute "Short course (acute) therapy"
* medicationReference = Reference(hiqa-med-amoxicillin-50mgml-susp)
* subject = Reference(hiqa-patient-oisin-brady)
* supportingInformation[0] = Reference(hiqa-allergies-oisin-nilknown)
* supportingInformation[+] = Reference(hiqa-weight-oisin)
* authoredOn = "2026-09-20T10:10:00+01:00"
* requester = Reference(hiqa-role-gp-nolan)
* reasonCode = $SCT#3110003 "Acute otitis media"
* dosageInstruction[0].text = "Give 5 mL (250 mg) three times a day for 5 days"
* dosageInstruction[=].patientInstruction = "Shake the bottle well. Use the oral syringe provided."
* dosageInstruction[=].timing.repeat.frequency = 3
* dosageInstruction[=].timing.repeat.period = 1
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].timing.repeat.boundsDuration = 5 'd' "days"
* dosageInstruction[=].route = $SCT#26643006 "Oral route"
* dosageInstruction[=].doseAndRate[0].doseQuantity = 5 'mL' "mL"
* dispenseRequest.quantity = 100 'mL' "mL"
* dispenseRequest.validityPeriod.start = "2026-09-20"
* dispenseRequest.validityPeriod.end = "2026-10-20"
* substitution.allowedBoolean = true

Instance: hiqa-bundle-s2-paediatric
InstanceOf: IECoreBundleEPrescription
Usage: #example
Title: "Scenario 2 – ePrescription Bundle: paediatric prescription (under 12)"
Description: "Enforces the legal requirement to state the age of a child under 12 (ie-bnd-rx-3)."
* identifier.system = $NePS
* identifier.value = "9-RX-2026-000002"
* type = #collection
* timestamp = "2026-09-20T10:10:00+01:00"
* insert HIQAEntry(Patient, hiqa-patient-oisin-brady)
* insert HIQAEntry(MedicationRequest, hiqa-rx-s2-amoxicillin-paeds)
* insert HIQAEntry(List, hiqa-allergies-oisin-nilknown)
* insert HIQAEntry(Observation, hiqa-weight-oisin)
* insert HIQAEntry(PractitionerRole, hiqa-role-gp-nolan)
* insert HIQAEntry(Practitioner, hiqa-prac-gp-nolan)
* insert HIQAEntry(Organization, hiqa-org-gp-practice)
* insert HIQAEntry(Medication, hiqa-med-amoxicillin-50mgml-susp)


// ====================================================================
// SCENARIO 3: repeat prescription with part fill, balance and repeat
// ====================================================================

Instance: hiqa-rx-s3-salbutamol-repeat
InstanceOf: IECoreMedicationRequestEPrescription
Usage: #example
Title: "Scenario 3 – Repeat prescription: salbutamol inhaler (5 repeats)"
Description: "Continuous therapy with repeats (HIQA EP 3.5.11), a minimum dispense interval (EP 3.5.13) and the overall prescribed quantity (EP 3.5.7.1). Repeats already dispensed are derived from the MedicationDispense records (ADR-003)."
* identifier[0].system = $NePS
* identifier[=].value = "9-RX-2026-000003-1"
* groupIdentifier.system = $NePS
* groupIdentifier.value = "9-RX-2026-000003"
* status = #active
* intent = #order
* courseOfTherapyType = http://terminology.hl7.org/CodeSystem/medicationrequest-course-of-therapy#continuous "Continuous long term therapy"
* medicationReference = Reference(hiqa-med-salbutamol-inhaler)
* subject = Reference(hiqa-patient-niamh-keane)
* supportingInformation = Reference(hiqa-allergies-niamh)
* authoredOn = "2026-09-01T11:05:00+01:00"
* requester = Reference(hiqa-role-gp-nolan)
* reasonCode = $SCT#195967001 "Asthma"
* extension[effectiveDosePeriod].valuePeriod.start = "2026-09-01"
* extension[effectiveDosePeriod].valuePeriod.end = "2027-02-28"
* dosageInstruction[0].text = "Inhale two puffs when required for breathlessness. Maximum 8 puffs in 24 hours"
* dosageInstruction[=].asNeededBoolean = true
* dosageInstruction[=].route = $SCT#447694001 "Respiratory tract route"
* dosageInstruction[=].doseAndRate[0].doseQuantity = 2 '{puff}' "puffs"
* dosageInstruction[=].maxDosePerPeriod.numerator = 8 '{puff}' "puffs"
* dosageInstruction[=].maxDosePerPeriod.denominator = 24 'h' "hours"
* dispenseRequest.extension[prescribedQuantity].valueQuantity = 12 '{inhaler}' "inhalers"
* dispenseRequest.quantity = 2 '{inhaler}' "inhalers"
* dispenseRequest.numberOfRepeatsAllowed = 5
* dispenseRequest.dispenseInterval = 21 'd' "days"
* dispenseRequest.validityPeriod.start = "2026-09-01"
* dispenseRequest.validityPeriod.end = "2027-02-28"
* substitution.allowedBoolean = true

Instance: hiqa-md-s3-part-fill
InstanceOf: IECoreMedicationDispenseEDispensation
Usage: #example
Title: "Scenario 3 – Dispense 1: part fill (1 of 2 inhalers)"
Description: "First supply, part filled because of stock (v3-ActCode FFP)."
* identifier[0].system = "urn:ietf:rfc:3986"
* identifier[=].value = "urn:uuid:9c2571bf-6251-50cd-9a49-d5e545fdc6ae"
* extension[recorded].valueDateTime = "2026-09-01T16:00:00+01:00"
* status = #completed
* medicationReference = Reference(hiqa-med-salbutamol-inhaler)
* subject = Reference(hiqa-patient-niamh-keane)
* performer[0].actor = Reference(hiqa-prac-pharmacist-farrell)
* authorizingPrescription = Reference(hiqa-rx-s3-salbutamol-repeat)
* type = http://terminology.hl7.org/CodeSystem/v3-ActCode#FFP "First Fill - Part Fill"
* quantity = 1 '{inhaler}' "inhaler"
* whenHandedOver = "2026-09-01T15:55:00+01:00"
* dosageInstruction[0].text = "Inhale two puffs when required for breathlessness. Maximum 8 puffs in 24 hours"
* note.text = "Part supply: 1 of 2 inhalers. Balance owed to the patient."

Instance: hiqa-md-s3-balance
InstanceOf: IECoreMedicationDispenseEDispensation
Usage: #example
Title: "Scenario 3 – Dispense 2: balance of the first supply"
Description: "Completes the first supply (v3-ActCode FFC)."
* identifier[0].system = "urn:ietf:rfc:3986"
* identifier[=].value = "urn:uuid:b5ed5f15-a819-5839-943f-9ad861c2e7ae"
* extension[recorded].valueDateTime = "2026-09-03T10:30:00+01:00"
* status = #completed
* medicationReference = Reference(hiqa-med-salbutamol-inhaler)
* subject = Reference(hiqa-patient-niamh-keane)
* performer[0].actor = Reference(hiqa-prac-pharmacist-farrell)
* authorizingPrescription = Reference(hiqa-rx-s3-salbutamol-repeat)
* type = http://terminology.hl7.org/CodeSystem/v3-ActCode#FFC "First Fill - Complete"
* quantity = 1 '{inhaler}' "inhaler"
* whenHandedOver = "2026-09-03T10:25:00+01:00"
* dosageInstruction[0].text = "Inhale two puffs when required for breathlessness. Maximum 8 puffs in 24 hours"

Instance: hiqa-md-s3-repeat-1
InstanceOf: IECoreMedicationDispenseEDispensation
Usage: #example
Title: "Scenario 3 – Dispense 3: first repeat"
Description: "First repeat, after the minimum dispense interval (v3-ActCode RF). Repeats dispensed so far: 1 of 5 (derived)."
* identifier[0].system = "urn:ietf:rfc:3986"
* identifier[=].value = "urn:uuid:18dc416f-384b-51b4-a91d-b688c67c9840"
* extension[recorded].valueDateTime = "2026-09-23T12:00:00+01:00"
* status = #completed
* medicationReference = Reference(hiqa-med-salbutamol-inhaler)
* subject = Reference(hiqa-patient-niamh-keane)
* performer[0].actor = Reference(hiqa-prac-pharmacist-farrell)
* authorizingPrescription = Reference(hiqa-rx-s3-salbutamol-repeat)
* type = http://terminology.hl7.org/CodeSystem/v3-ActCode#RF "Refill"
* quantity = 2 '{inhaler}' "inhalers"
* whenHandedOver = "2026-09-23T11:55:00+01:00"
* dosageInstruction[0].text = "Inhale two puffs when required for breathlessness. Maximum 8 puffs in 24 hours"

Instance: hiqa-bundle-s3-repeat
InstanceOf: IECoreBundleEPrescription
Usage: #example
Title: "Scenario 3 – ePrescription Bundle: repeat prescription"
Description: "The allergy statement lists a confirmed penicillin allergy (EP 1.6.2)."
* identifier.system = $NePS
* identifier.value = "9-RX-2026-000003"
* type = #collection
* timestamp = "2026-09-01T11:05:00+01:00"
* insert HIQAEntry(Patient, hiqa-patient-niamh-keane)
* insert HIQAEntry(MedicationRequest, hiqa-rx-s3-salbutamol-repeat)
* insert HIQAEntry(List, hiqa-allergies-niamh)
* insert HIQAEntry(AllergyIntolerance, hiqa-allergy-niamh-penicillin)
* insert HIQAEntry(PractitionerRole, hiqa-role-gp-nolan)
* insert HIQAEntry(Practitioner, hiqa-prac-gp-nolan)
* insert HIQAEntry(Organization, hiqa-org-gp-practice)
* insert HIQAEntry(Medication, hiqa-med-salbutamol-inhaler)


// ====================================================================
// SCENARIO 4: controlled drug (Schedule 2), instalments
// ====================================================================

Instance: hiqa-rx-s4-oxycodone
InstanceOf: IECoreMedicationRequestEPrescription
Usage: #example
Title: "Scenario 4 – Controlled drug: oxycodone 10 mg prolonged-release (Schedule 2)"
Description: "Misuse of Drugs Regulations 2017 requirements as cited by HIQA: quantity in words and figures (EP 3.5.7.2), number of instalments (EP 3.5.12) and validity of no more than 14 days (EP 3.5.9.1). Invariants ie-rx-cd-1 and ie-rx-cd-2. 'Do Not Substitute' with a reason (EP 3.5.10.2/3)."
* identifier[0].system = $NePS
* identifier[=].value = "9-RX-2026-000004-1"
* groupIdentifier.system = $NePS
* groupIdentifier.value = "9-RX-2026-000004"
* extension[quantityInWordsAndFigures].valueString = "Twenty-eight (28) tablets"
* status = #active
* intent = #order
* courseOfTherapyType = http://terminology.hl7.org/CodeSystem/medicationrequest-course-of-therapy#continuous "Continuous long term therapy"
* medicationReference = Reference(hiqa-med-oxycodone-10-pr)
* subject = Reference(hiqa-patient-declan-walsh)
* supportingInformation = Reference(hiqa-allergies-declan-nilknown)
* authoredOn = "2026-09-15T15:10:00+01:00"
* requester = Reference(hiqa-role-gp-nolan)
* reasonCode = $SCT#82423001 "Chronic pain"
* dosageInstruction[0].text = "Take one tablet every 12 hours. Swallow whole; do not crush or chew"
* dosageInstruction[=].timing.repeat.frequency = 1
* dosageInstruction[=].timing.repeat.period = 12
* dosageInstruction[=].timing.repeat.periodUnit = #h
* dosageInstruction[=].route = $SCT#26643006 "Oral route"
* dosageInstruction[=].doseAndRate[0].doseQuantity = 1 '{tablet}' "tablet"
* dispenseRequest.extension[prescribedQuantity].valueQuantity = 28 '{tablet}' "tablets"
* dispenseRequest.extension[numberOfInstalments].valuePositiveInt = 2
* dispenseRequest.quantity = 14 '{tablet}' "tablets"
* dispenseRequest.dispenseInterval = 7 'd' "days"
* dispenseRequest.validityPeriod.start = "2026-09-15"
* dispenseRequest.validityPeriod.end = "2026-09-29"
* dispenseRequest.numberOfRepeatsAllowed = 0
* substitution.allowedBoolean = false
* substitution.reason.text = "Prolonged-release opioid: keep the same brand to avoid differences in release profile"

Instance: hiqa-md-s4-instalment-1
InstanceOf: IECoreMedicationDispenseEDispensation
Usage: #example
Title: "Scenario 4 – Dispense: instalment 1 of 2 (14 tablets)"
Description: "First instalment of a Schedule 2 controlled drug."
* identifier[0].system = "urn:ietf:rfc:3986"
* identifier[=].value = "urn:uuid:d8cf455d-96e1-501f-bc6e-c77571385620"
* extension[recorded].valueDateTime = "2026-09-15T17:30:00+01:00"
* status = #completed
* medicationReference = Reference(hiqa-med-oxycodone-10-pr)
* subject = Reference(hiqa-patient-declan-walsh)
* performer[0].actor = Reference(hiqa-prac-pharmacist-farrell)
* authorizingPrescription = Reference(hiqa-rx-s4-oxycodone)
* type = http://terminology.hl7.org/CodeSystem/v3-ActCode#FFP "First Fill - Part Fill"
* quantity = 14 '{tablet}' "tablets"
* whenHandedOver = "2026-09-15T17:25:00+01:00"
* dosageInstruction[0].text = "Take one tablet every 12 hours. Swallow whole; do not crush or chew"
* substitution.wasSubstituted = false
* note.text = "Instalment 1 of 2. Next instalment due on or after 22/09/2026."

Instance: hiqa-bundle-s4-controlled-drug
InstanceOf: IECoreBundleEPrescription
Usage: #example
Title: "Scenario 4 – ePrescription Bundle: controlled drug"
Description: "Schedule 2 controlled-drug prescription."
* identifier.system = $NePS
* identifier.value = "9-RX-2026-000004"
* type = #collection
* timestamp = "2026-09-15T15:10:00+01:00"
* insert HIQAEntry(Patient, hiqa-patient-declan-walsh)
* insert HIQAEntry(MedicationRequest, hiqa-rx-s4-oxycodone)
* insert HIQAEntry(List, hiqa-allergies-declan-nilknown)
* insert HIQAEntry(PractitionerRole, hiqa-role-gp-nolan)
* insert HIQAEntry(Practitioner, hiqa-prac-gp-nolan)
* insert HIQAEntry(Organization, hiqa-org-gp-practice)
* insert HIQAEntry(Medication, hiqa-med-oxycodone-10-pr)


// ====================================================================
// SCENARIO 5: non-dispensation (declined, with reason)
// ====================================================================

Instance: hiqa-rx-s5-amoxicillin
InstanceOf: IECoreMedicationRequestEPrescription
Usage: #example
Title: "Scenario 5 – Prescription the pharmacist declines: amoxicillin for a patient with penicillin allergy"
Description: "The allergy statement sent with the prescription records a penicillin allergy. The pharmacist declines to dispense (scenario 5)."
* identifier[0].system = $NePS
* identifier[=].value = "9-RX-2026-000005-1"
* groupIdentifier.system = $NePS
* groupIdentifier.value = "9-RX-2026-000005"
* status = #active
* intent = #order
* courseOfTherapyType = http://terminology.hl7.org/CodeSystem/medicationrequest-course-of-therapy#acute "Short course (acute) therapy"
* medicationReference = Reference(hiqa-med-amoxicillin-500-caps)
* subject = Reference(hiqa-patient-niamh-keane)
* supportingInformation = Reference(hiqa-allergies-niamh)
* authoredOn = "2026-09-22T09:30:00+01:00"
* requester = Reference(hiqa-role-gp-nolan)
* reasonCode = $SCT#15805002 "Acute sinusitis"
* dosageInstruction[0].text = "Take one capsule three times a day for 7 days"
* dosageInstruction[=].timing.repeat.frequency = 3
* dosageInstruction[=].timing.repeat.period = 1
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].route = $SCT#26643006 "Oral route"
* dosageInstruction[=].doseAndRate[0].doseQuantity = 1 '{capsule}' "capsule"
* dispenseRequest.quantity = 21 '{capsule}' "capsules"
* dispenseRequest.validityPeriod.start = "2026-09-22"
* dispenseRequest.validityPeriod.end = "2026-10-22"
* substitution.allowedBoolean = true

Instance: hiqa-md-s5-declined
InstanceOf: IECoreMedicationDispenseEDispensation
Usage: #example
Title: "Scenario 5 – Non-dispensation: declined because of a recorded penicillin allergy"
Description: "HIQA EP 6.3.1 status (declined) and 6.3.2.2 reason (free text); invariant ie-md-status-1. No medication is handed over, so the dispensed quantity (EP 6.7, Mandatory) is zero."
* identifier[0].system = "urn:ietf:rfc:3986"
* identifier[=].value = "urn:uuid:2df5c229-1bc6-55d4-aa2e-7fa0b6ae1adf"
* extension[recorded].valueDateTime = "2026-09-22T12:10:00+01:00"
* status = #declined
* statusReasonCodeableConcept.text = "Not dispensed: the patient has a confirmed penicillin allergy (anaphylaxis). Prescriber contacted to cancel and review."
* medicationReference = Reference(hiqa-med-amoxicillin-500-caps)
* subject = Reference(hiqa-patient-niamh-keane)
* performer[0].actor = Reference(hiqa-prac-pharmacist-farrell)
* authorizingPrescription = Reference(hiqa-rx-s5-amoxicillin)
* quantity = 0 '{capsule}' "capsules"

Instance: hiqa-bundle-s5-non-dispensation
InstanceOf: IECoreBundleEPrescription
Usage: #example
Title: "Scenario 5 – ePrescription Bundle: prescription later declined"
Description: "The prescription as sent. The declined dispense is hiqa-md-s5-declined."
* identifier.system = $NePS
* identifier.value = "9-RX-2026-000005"
* type = #collection
* timestamp = "2026-09-22T09:30:00+01:00"
* insert HIQAEntry(Patient, hiqa-patient-niamh-keane)
* insert HIQAEntry(MedicationRequest, hiqa-rx-s5-amoxicillin)
* insert HIQAEntry(List, hiqa-allergies-niamh)
* insert HIQAEntry(AllergyIntolerance, hiqa-allergy-niamh-penicillin)
* insert HIQAEntry(PractitionerRole, hiqa-role-gp-nolan)
* insert HIQAEntry(Practitioner, hiqa-prac-gp-nolan)
* insert HIQAEntry(Organization, hiqa-org-gp-practice)
* insert HIQAEntry(Medication, hiqa-med-amoxicillin-500-caps)


// ====================================================================
// SCENARIO 6: cross-border IE → EU with prescriber signature
// ====================================================================

Instance: hiqa-rx-s6-metformin
InstanceOf: IECoreMedicationRequestEPrescription
Usage: #example
Title: "Scenario 6 – Cross-border item 1: metformin 500 mg"
Description: "Item 1 of a two-item prescription to be dispensed in another EU Member State."
* identifier[0].system = $NePS
* identifier[=].value = "9-RX-2026-000006-1"
* groupIdentifier.system = $NePS
* groupIdentifier.value = "9-RX-2026-000006"
* status = #active
* intent = #order
* courseOfTherapyType = http://terminology.hl7.org/CodeSystem/medicationrequest-course-of-therapy#continuous "Continuous long term therapy"
* medicationReference = Reference(ie-core-medication-metformin-500)
* subject = Reference(hiqa-patient-declan-walsh)
* supportingInformation = Reference(hiqa-allergies-declan-nilknown)
* authoredOn = "2026-09-16T10:00:00+01:00"
* requester = Reference(hiqa-role-gp-nolan)
* reasonCode = $SCT#44054006 "Type 2 diabetes mellitus"
* dosageInstruction[0].text = "Take one tablet twice a day with meals"
* dosageInstruction[=].timing.repeat.frequency = 2
* dosageInstruction[=].timing.repeat.period = 1
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].route = $SCT#26643006 "Oral route"
* dosageInstruction[=].doseAndRate[0].doseQuantity = 1 '{tablet}' "tablet"
* dispenseRequest.quantity = 56 '{tablet}' "tablets"
* dispenseRequest.validityPeriod.start = "2026-09-16"
* dispenseRequest.validityPeriod.end = "2027-03-15"
* substitution.allowedBoolean = true

Instance: hiqa-rx-s6-atorvastatin
InstanceOf: IECoreMedicationRequestEPrescription
Usage: #example
Title: "Scenario 6 – Cross-border item 2: atorvastatin 20 mg"
Description: "Item 2 of the cross-border prescription; same group identifier (EP 3.1)."
* identifier[0].system = $NePS
* identifier[=].value = "9-RX-2026-000006-2"
* groupIdentifier.system = $NePS
* groupIdentifier.value = "9-RX-2026-000006"
* status = #active
* intent = #order
* courseOfTherapyType = http://terminology.hl7.org/CodeSystem/medicationrequest-course-of-therapy#continuous "Continuous long term therapy"
* medicationReference = Reference(ie-core-medication-atorvastatin-20)
* subject = Reference(hiqa-patient-declan-walsh)
* supportingInformation = Reference(hiqa-allergies-declan-nilknown)
* authoredOn = "2026-09-16T10:00:00+01:00"
* requester = Reference(hiqa-role-gp-nolan)
* dosageInstruction[0].text = "Take one tablet once a day at night"
* dosageInstruction[=].timing.repeat.frequency = 1
* dosageInstruction[=].timing.repeat.period = 1
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].route = $SCT#26643006 "Oral route"
* dosageInstruction[=].doseAndRate[0].doseQuantity = 1 '{tablet}' "tablet"
* dispenseRequest.quantity = 28 '{tablet}' "tablets"
* dispenseRequest.validityPeriod.start = "2026-09-16"
* dispenseRequest.validityPeriod.end = "2027-03-15"
* substitution.allowedBoolean = true

Instance: hiqa-provenance-s6-signature
InstanceOf: IECoreProvenanceEPrescriptionSignature
Usage: #example
Title: "Scenario 6 – Prescriber signature over both items"
Description: "HIQA EP 2.13 Signature. The signature value is a SYNTHETIC placeholder, not a real signature. The format (e.g. JAdES) and eIDAS assurance level are Requires Clarification (OI-009)."
* target[0] = Reference(hiqa-rx-s6-metformin)
* target[+] = Reference(hiqa-rx-s6-atorvastatin)
* recorded = "2026-09-16T10:01:00+01:00"
* agent[0].who = Reference(hiqa-role-gp-nolan)
* signature[0].type = urn:iso-astm:E1762-95:2013#1.2.840.10065.1.12.1.1 "Author's Signature"
* signature[=].when = "2026-09-16T10:01:00+01:00"
* signature[=].who = Reference(hiqa-role-gp-nolan)
* signature[=].sigFormat = #application/jose
// base64 of "SYNTHETIC-EXAMPLE-SIGNATURE-NOT-VALID"
* signature[=].data = "U1lOVEhFVElDLUVYQU1QTEUtU0lHTkFUVVJFLU5PVC1WQUxJRA=="

Instance: hiqa-bundle-s6-crossborder
InstanceOf: IECoreBundleEPrescriptionCrossBorder
Usage: #example
Title: "Scenario 6 – Cross-border ePrescription Bundle (IE → EU) with signature"
Description: "Claims IECoreBundleEPrescriptionCrossBorder (no invented tag; ADR-003): patient date of birth, prescriber telephone and secure email (EP 2.10.1/2.10.2; ie-bnd-xb-1) and a signature covering every item (EP 2.13; ie-bnd-xb-2)."
* identifier.system = $NePS
* identifier.value = "9-RX-2026-000006"
* type = #collection
* timestamp = "2026-09-16T10:01:00+01:00"
* insert HIQAEntry(Patient, hiqa-patient-declan-walsh)
* insert HIQAEntry(MedicationRequest, hiqa-rx-s6-metformin)
* insert HIQAEntry(MedicationRequest, hiqa-rx-s6-atorvastatin)
* insert HIQAEntry(List, hiqa-allergies-declan-nilknown)
* insert HIQAEntry(Provenance, hiqa-provenance-s6-signature)
* insert HIQAEntry(PractitionerRole, hiqa-role-gp-nolan)
* insert HIQAEntry(Practitioner, hiqa-prac-gp-nolan)
* insert HIQAEntry(Organization, hiqa-org-gp-practice)
* insert HIQAEntry(Medication, ie-core-medication-metformin-500)
* insert HIQAEntry(Medication, ie-core-medication-atorvastatin-20)


// ====================================================================
// SCENARIO 7: full Patient Summary
// ====================================================================

Instance: hiqa-ps-patient-niamh
InstanceOf: IECorePatientSummaryPatient
Usage: #example
Title: "Scenario 7 – Patient Summary patient: Niamh Keane"
Description: "The Patient Summary patient carries the HIQA PS Section 1 dataset, including Required demographics that are NOT in the ePrescription dataset (ethnicity, nationality; HIQA PS 1.4), and a nominated contact person (PS Section 3)."
* identifier[0].system = $IHI
* identifier[=].type = $V2-0203#NI "National unique individual identifier"
* identifier[=].value = "999000000000000003"
* name[0].use = #official
* name[=].family = "Keane"
* name[=].given = "Niamh"
* gender = #female
* insert SexAssignedAtBirth(female, Female)
* birthDate = "1990-11-08"
* extension[ethnicity].valueCodeableConcept = IECoreEthnicityCodes#10 "White Irish"
* extension[patient-nationality].extension[code].valueCodeableConcept = urn:iso:std:iso:3166#IE "Ireland"
* address[0].use = #home
* address[=].line = "27 Abbey Road"
* address[=].city = "Athlone"
* address[=].state = "Westmeath"
* address[=].postalCode = "N37 XX12"
* address[=].country = "IE"
* telecom[0].system = #phone
* telecom[=].value = "+353 87 000 0003"
* telecom[=].use = #mobile
* communication[0].language = urn:ietf:bcp:47#en "English"
* communication[=].preferred = true
* contact[0].relationship = http://terminology.hl7.org/CodeSystem/v2-0131#C "Emergency Contact"
* contact[=].name.family = "Keane"
* contact[=].name.given = "Brendan"
* contact[=].telecom[0].system = #phone
* contact[=].telecom[=].value = "+353 87 000 0030"
* contact[=].address.line = "27 Abbey Road"
* contact[=].address.city = "Athlone"
* contact[=].address.state = "Westmeath"
* generalPractitioner = Reference(hiqa-role-gp-nolan)

Instance: hiqa-org-hse
InstanceOf: IECoreOrganization
Usage: #example
Title: "HIQA scenarios – Health Service Executive (payer)"
Description: "The public payer for PCRS schemes, used as Coverage.payor (HIQA PS 1.3.4.3)."
* active = true
* type = http://terminology.hl7.org/CodeSystem/organization-type#govt "Government"
* name = "Health Service Executive"

Instance: hiqa-ps-coverage-niamh
InstanceOf: IECoreCoverage
Usage: #example
Title: "Scenario 7 – Health insurance information: medical card (fictional number)"
Description: "HIQA PS 1.3.4: type (1.3.4.1), card number (1.3.4.2), insurer (1.3.4.3)."
* status = #active
* type = http://terminology.hl7.org/CodeSystem/v3-ActCode#PUBLICPOL "public healthcare"
* subscriberId = "9900003C"
* beneficiary = Reference(hiqa-ps-patient-niamh)
* relationship = http://terminology.hl7.org/CodeSystem/subscriber-relationship#self "Self"
* payor = Reference(hiqa-org-hse)

Instance: hiqa-ps-allergy-niamh
InstanceOf: IECoreAllergyIntolerance
Usage: #example
Title: "Scenario 7 – Allergy to penicillin"
Description: "HIQA PS 5.3."
* clinicalStatus = http://terminology.hl7.org/CodeSystem/allergyintolerance-clinical#active "Active"
* verificationStatus = http://terminology.hl7.org/CodeSystem/allergyintolerance-verification#confirmed "Confirmed"
* type = #allergy
* category = #medication
* criticality = #high
* code = $SCT#91936005 "Allergy to penicillin"
* patient = Reference(hiqa-ps-patient-niamh)
* recordedDate = "2015-04-10"
* reaction[0].manifestation = $SCT#39579001 "Anaphylaxis"
* reaction[=].severity = #severe

Instance: hiqa-ps-medstatement-niamh
InstanceOf: IECoreMedicationStatement
Usage: #example
Title: "Scenario 7 – Current medication: salbutamol inhaler"
Description: "HIQA PS 6.3."
* status = #active
* medicationCodeableConcept = $SCT#770300007 "Albuterol (as albuterol sulfate) 100 microgram/actuation pressurized suspension for inhalation"
* medicationCodeableConcept.text = "Salbutamol 100 micrograms/dose pressurised inhalation suspension"
* subject = Reference(hiqa-ps-patient-niamh)
* effectivePeriod.start = "2012-02-01"
* dosage[0].text = "Two puffs when required. Maximum 8 puffs in 24 hours"
* dosage[=].route = $SCT#447694001 "Respiratory tract route"

Instance: hiqa-ps-condition-asthma
InstanceOf: IECoreConditionProblemsHealthConcerns
Usage: #example
Title: "Scenario 7 – Health condition: asthma"
Description: "HIQA PS 7.3."
* clinicalStatus = http://terminology.hl7.org/CodeSystem/condition-clinical#active "Active"
* verificationStatus = http://terminology.hl7.org/CodeSystem/condition-ver-status#confirmed "Confirmed"
* category = http://terminology.hl7.org/CodeSystem/condition-category#problem-list-item "Problem List Item"
* code = $SCT#195967001 "Asthma"
* subject = Reference(hiqa-ps-patient-niamh)
* onsetDateTime = "2008"

Instance: hiqa-ps-procedure-appendectomy
InstanceOf: IECoreProcedure
Usage: #example
Title: "Scenario 7 – Past procedure: appendicectomy"
Description: "HIQA PS 9.3."
* status = #completed
* code = $SCT#80146002 "Appendectomy"
* code.text = "Appendicectomy"
* subject = Reference(hiqa-ps-patient-niamh)
* performedDateTime = "2005-07-14"

Instance: hiqa-ps-immunization-flu
InstanceOf: IECoreImmunization
Usage: #example
Title: "Scenario 7 – Immunisation: seasonal influenza vaccine"
Description: "HIQA PS 16.3."
* status = #completed
* vaccineCode = $SCT#1181000221105 "Influenza virus antigen only vaccine product"
* patient = Reference(hiqa-ps-patient-niamh)
* occurrenceDateTime = "2025-10-15"
* primarySource = true

Instance: hiqa-ps-composition-niamh
InstanceOf: IECoreCompositionPatientSummary
Usage: #example
Title: "Scenario 7 – Patient Summary Composition (full)"
Description: "Populated HIQA PS sections, with document provenance (PS 19.1) and professional attestation (PS 19.1.11)."
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:2f7f14c4-3907-53f5-908a-dfa7e064524d"
* status = #final
* type = $LOINC#60591-5 "Patient summary Document"
* subject = Reference(hiqa-ps-patient-niamh)
* date = "2026-09-24T09:00:00+01:00"
* author = Reference(hiqa-role-gp-nolan)
* title = "Patient Summary"
* language = #en-IE
* attester[0].mode = #professional
* attester[=].time = "2026-09-24T09:00:00+01:00"
* attester[=].party = Reference(hiqa-role-gp-nolan)
* custodian = Reference(hiqa-org-gp-practice)
* section[sectionAlert].title = "Alerts"
* section[sectionAlert].code = $LOINC#104605-1 "Alert"
* insert HIQAEmptySection(sectionAlert, nilknown, Nil Known, No alerts recorded.)
* section[sectionAllergies].title = "Allergies and Intolerances"
* section[sectionAllergies].code = $LOINC#48765-2 "Allergies and adverse reactions Document"
* insert HIQASectionText(sectionAllergies, Allergy to penicillin - anaphylaxis. Confirmed.)
* section[sectionAllergies].entry[0] = Reference(hiqa-ps-allergy-niamh)
* section[sectionMedications].title = "Medication Summary"
* section[sectionMedications].code = $LOINC#10160-0 "History of Medication use Narrative"
* insert HIQASectionText(sectionMedications, Salbutamol 100 micrograms/dose inhaler: two puffs when required.)
* section[sectionMedications].entry[0] = Reference(hiqa-ps-medstatement-niamh)
* section[sectionProblems].title = "Health Conditions"
* section[sectionProblems].code = $LOINC#11450-4 "Problem list - Reported"
* insert HIQASectionText(sectionProblems, Asthma - active since 2008.)
* section[sectionProblems].entry[0] = Reference(hiqa-ps-condition-asthma)
* section[sectionProceduresHx].title = "Procedures"
* section[sectionProceduresHx].code = $LOINC#47519-4 "History of Procedures Document"
* insert HIQASectionText(sectionProceduresHx, Appendicectomy - July 2005.)
* section[sectionProceduresHx].entry[0] = Reference(hiqa-ps-procedure-appendectomy)
* section[sectionMedicalDevices].title = "Medical Devices"
* section[sectionMedicalDevices].code = $LOINC#46264-8 "History of medical device use"
* insert HIQAEmptySection(sectionMedicalDevices, nilknown, Nil Known, No implanted or medical devices.)
* section[sectionImmunizations].title = "Immunisations"
* section[sectionImmunizations].code = $LOINC#11369-6 "History of Immunization note"
* insert HIQASectionText(sectionImmunizations, Seasonal influenza vaccine - October 2025.)
* section[sectionImmunizations].entry[0] = Reference(hiqa-ps-immunization-flu)
* section[sectionAdvanceDirectives].title = "Advance Healthcare Directive"
* section[sectionAdvanceDirectives].code = $LOINC#42348-3 "Advance healthcare directives"
* insert HIQAEmptySection(sectionAdvanceDirectives, notasked, Not Asked, Not discussed.)
* section[sectionSocialHistory].title = "Social Context"
* section[sectionSocialHistory].code = $LOINC#29762-2 "Social history note"
* insert HIQASectionText(sectionSocialHistory, Lives with partner. Works as a teacher. Non-smoker.)
* section[sectionPlanOfCare].title = "Care Plan"
* section[sectionPlanOfCare].code = $LOINC#18776-5 "Plan of care note"
* insert HIQASectionText(sectionPlanOfCare, Annual asthma review due March 2027.)

Instance: hiqa-bundle-s7-patient-summary-full
InstanceOf: IECoreBundlePatientSummary
Usage: #example
Title: "Scenario 7 – Patient Summary Bundle (full)"
Description: "A populated Irish Patient Summary document on HL7 Europe EPS (ADR-004)."
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:2f7f14c4-3907-53f5-908a-dfa7e064524d"
* type = #document
* timestamp = "2026-09-24T09:00:00+01:00"
* insert HIQAEntry(Composition, hiqa-ps-composition-niamh)
* insert HIQAEntry(Patient, hiqa-ps-patient-niamh)
* insert HIQAEntry(AllergyIntolerance, hiqa-ps-allergy-niamh)
* insert HIQAEntry(MedicationStatement, hiqa-ps-medstatement-niamh)
* insert HIQAEntry(Condition, hiqa-ps-condition-asthma)
* insert HIQAEntry(Procedure, hiqa-ps-procedure-appendectomy)
* insert HIQAEntry(Immunization, hiqa-ps-immunization-flu)
* insert HIQAEntry(Coverage, hiqa-ps-coverage-niamh)
* insert HIQAEntry(PractitionerRole, hiqa-role-gp-nolan)
* insert HIQAEntry(Practitioner, hiqa-prac-gp-nolan)
* insert HIQAEntry(Organization, hiqa-org-gp-practice)
* insert HIQAEntry(Organization, hiqa-org-hse)


// ====================================================================
// SCENARIO 8: Patient Summary with empty sections
// ====================================================================

Instance: hiqa-ps-patient-tomas
InstanceOf: IECorePatientSummaryPatient
Usage: #example
Title: "Scenario 8 – Patient Summary patient: Tomás Quinn"
Description: "Minimal Patient Summary demographics."
* identifier[0].system = $IHI
* identifier[=].type = $V2-0203#NI "National unique individual identifier"
* identifier[=].value = "999000000000000001"
* name[0].use = #official
* name[=].family = "Quinn"
* name[=].given = "Tomás"
* gender = #male
* insert SexAssignedAtBirth(male, Male)
* birthDate = "1979-06-21"
* address[0].use = #home
* address[=].line = "12 Shannon View"
* address[=].city = "Athlone"
* address[=].state = "Westmeath"
* address[=].postalCode = "N37 XX10"
* address[=].country = "IE"

Instance: hiqa-ps-composition-tomas-empty
InstanceOf: IECoreCompositionPatientSummary
Usage: #example
Title: "Scenario 8 – Patient Summary Composition with empty sections"
Description: "Each section HIQA gives an empty reason to carries an emptyReason instead of entries (HIQA PS 4.2, 5.2, 6.2, 7.2, 9.2, 10.2, 13.2, 16.2; invariant ie-ps-1). 'Nil known' and 'not asked' are different statements (clinical-safety hazard HZ-03)."
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:e56a3794-524c-5e03-92be-3f2513ced57f"
* status = #final
* type = $LOINC#60591-5 "Patient summary Document"
* subject = Reference(hiqa-ps-patient-tomas)
* date = "2026-09-24T10:00:00+01:00"
* author = Reference(hiqa-role-gp-nolan)
* title = "Patient Summary"
* section[sectionAlert].title = "Alerts"
* section[sectionAlert].code = $LOINC#104605-1 "Alert"
* insert HIQAEmptySection(sectionAlert, notasked, Not Asked, Not recorded.)
* section[sectionAllergies].title = "Allergies and Intolerances"
* section[sectionAllergies].code = $LOINC#48765-2 "Allergies and adverse reactions Document"
* insert HIQAEmptySection(sectionAllergies, nilknown, Nil Known, No known allergies.)
* section[sectionMedications].title = "Medication Summary"
* section[sectionMedications].code = $LOINC#10160-0 "History of Medication use Narrative"
* insert HIQAEmptySection(sectionMedications, nilknown, Nil Known, No current medication.)
* section[sectionProblems].title = "Health Conditions"
* section[sectionProblems].code = $LOINC#11450-4 "Problem list - Reported"
* insert HIQAEmptySection(sectionProblems, nilknown, Nil Known, No known health conditions.)
* section[sectionProceduresHx].title = "Procedures"
* section[sectionProceduresHx].code = $LOINC#47519-4 "History of Procedures Document"
* insert HIQAEmptySection(sectionProceduresHx, notasked, Not Asked, Not recorded.)
* section[sectionMedicalDevices].title = "Medical Devices"
* section[sectionMedicalDevices].code = $LOINC#46264-8 "History of medical device use"
* insert HIQAEmptySection(sectionMedicalDevices, unavailable, Unavailable, Information not available.)
* section[sectionImmunizations].title = "Immunisations"
* section[sectionImmunizations].code = $LOINC#11369-6 "History of Immunization note"
* insert HIQAEmptySection(sectionImmunizations, unavailable, Unavailable, Information not available.)
* section[sectionAdvanceDirectives].title = "Advance Healthcare Directive"
* section[sectionAdvanceDirectives].code = $LOINC#42348-3 "Advance healthcare directives"
* insert HIQAEmptySection(sectionAdvanceDirectives, notasked, Not Asked, Not discussed.)

Instance: hiqa-bundle-s8-patient-summary-empty
InstanceOf: IECoreBundlePatientSummary
Usage: #example
Title: "Scenario 8 – Patient Summary Bundle with empty sections"
Description: "A valid Patient Summary where nothing is recorded; every empty section says why."
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:e56a3794-524c-5e03-92be-3f2513ced57f"
* type = #document
* timestamp = "2026-09-24T10:00:00+01:00"
* insert HIQAEntry(Composition, hiqa-ps-composition-tomas-empty)
* insert HIQAEntry(Patient, hiqa-ps-patient-tomas)
* insert HIQAEntry(PractitionerRole, hiqa-role-gp-nolan)
* insert HIQAEntry(Practitioner, hiqa-prac-gp-nolan)
* insert HIQAEntry(Organization, hiqa-org-gp-practice)
