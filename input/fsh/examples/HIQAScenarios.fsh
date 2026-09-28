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
