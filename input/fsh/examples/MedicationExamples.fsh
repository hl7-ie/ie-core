// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Medication Scenario Examples                               │
// │  Covers: Local IE dispensing (full/partial/repeat/multiple Rx),     │
// │  Cross-border IE→ES, Cross-border ES→IE (MyHealth@EU / EHDS)        │
// ╰──────────────────────────────────────────────────────────────────────╯


// ====================================================================
// SUPPORTING RESOURCES – MEDICATIONS
// ====================================================================

Instance: ie-core-medication-metformin-500
InstanceOf: IECoreMedicationEPrescription
Usage: #example
Title: "Medication – Metformin 500mg Tablets"
Description: "Metformin hydrochloride 500mg film-coated tablets (generic), coded with NMPC as the primary code and SNOMED CT as a secondary code."

* code = $NMPC#NMPC-MET500TAB "Metformin hydrochloride 500mg film-coated tablets"
* code.coding[+] = $SCT#372567009 "Metformin"
* code.text = "Metformin 500mg tablets"
* form = $SCT#385055001 "Tablet"
* amount.numerator = 60 '{tablet}' "tablets"
* amount.denominator = 1 '{pack}' "pack"
* ingredient[0].itemCodeableConcept = $SCT#372567009 "Metformin"
* ingredient[=].isActive = true
* ingredient[=].strength.numerator = 500 'mg' "mg"
* ingredient[=].strength.denominator = 1 '{tablet}' "tablet"


Instance: ie-core-medication-atorvastatin-20
InstanceOf: IECoreMedicationEPrescription
Usage: #example
Title: "Medication – Atorvastatin 20mg Tablets"
Description: "Atorvastatin 20mg film-coated tablets (generic), coded with NMPC as the primary code and SNOMED CT as a secondary code."

* code = $NMPC#NMPC-ATV20TAB "Atorvastatin 20mg film-coated tablets"
* code.coding[+] = $SCT#373444002 "Atorvastatin"
* code.text = "Atorvastatin 20mg tablets"
* form = $SCT#385055001 "Tablet"
* amount.numerator = 30 '{tablet}' "tablets"
* amount.denominator = 1 '{pack}' "pack"
* ingredient[0].itemCodeableConcept = $SCT#373444002 "Atorvastatin"
* ingredient[=].isActive = true
* ingredient[=].strength.numerator = 20 'mg' "mg"
* ingredient[=].strength.denominator = 1 '{tablet}' "tablet"


Instance: ie-core-medication-ramipril-5
InstanceOf: IECoreMedicationEPrescription
Usage: #example
Title: "Medication – Ramipril 5mg Capsules"
Description: "Ramipril 5mg capsules (generic), coded with NMPC as the primary code and SNOMED CT as a secondary code."

* code = $NMPC#NMPC-RAM5CAP "Ramipril 5mg capsules"
* code.coding[+] = $SCT#386872004 "Ramipril"
* code.text = "Ramipril 5mg capsules"
* form = $SCT#385049006 "Capsule"
* amount.numerator = 28 '{capsule}' "capsules"
* amount.denominator = 1 '{pack}' "pack"
* ingredient[0].itemCodeableConcept = $SCT#386872004 "Ramipril"
* ingredient[=].isActive = true
* ingredient[=].strength.numerator = 5 'mg' "mg"
* ingredient[=].strength.denominator = 1 '{capsule}' "capsule"


Instance: ie-core-medication-amlodipine-5
InstanceOf: IECoreMedicationEPrescription
Usage: #example
Title: "Medication – Amlodipine 5mg Tablets"
Description: "Amlodipine 5mg tablets (generic), coded with NMPC as the primary code and SNOMED CT as a secondary code. Used in cross-border dispensing scenario."

* code = $NMPC#NMPC-AML5TAB "Amlodipine 5mg tablets"
* code.coding[+] = $SCT#386864001 "Amlodipine"
* code.text = "Amlodipine 5mg tablets"
* form = $SCT#385055001 "Tablet"
* amount.numerator = 30 '{tablet}' "tablets"
* amount.denominator = 1 '{pack}' "pack"
* ingredient[0].itemCodeableConcept = $SCT#386864001 "Amlodipine"
* ingredient[=].isActive = true
* ingredient[=].strength.numerator = 5 'mg' "mg"
* ingredient[=].strength.denominator = 1 '{tablet}' "tablet"


// ====================================================================
// SUPPORTING RESOURCES – IRISH PHARMACY
// ====================================================================

Instance: ie-core-organization-pharmacy-example
InstanceOf: IECoreOrganization
Usage: #example
Title: "Irish Pharmacy – Boots Pharmacy Grafton Street"
Description: "An example Irish community pharmacy (Boots Pharmacy, Dublin), acting as dispenser."

* identifier[0].system = $CRN
* identifier[=].value = "IE-PHARM-BTS-001"
* identifier[+].system = $HPI
* identifier[=].value = "HPI-IE-ORG-PHARM-001"

* active = true
* type = http://terminology.hl7.org/CodeSystem/organization-type#prov "Healthcare Provider"
* name = "Boots Pharmacy – Grafton Street"

* telecom[0].system = #phone
* telecom[=].value = "+353 1 677 6462"
* telecom[=].use = #work
* telecom[+].system = #email
* telecom[=].value = "grafton@boots.ie"
* telecom[=].use = #work

* address[0].use = #work
* address[=].type = #physical
* address[=].line[0] = "14 Grafton Street"
* address[=].city = "Dublin"
* address[=].state = "Dublin"
* address[=].postalCode = "D02 HH74"
* address[=].country = "IE"


Instance: ie-core-practitioner-pharmacist-example
InstanceOf: IECorePractitioner
Usage: #example
Title: "IE Core Practitioner – Pharmacist Niamh Brennan"
Description: "An example Irish registered pharmacist dispensing medication in Dublin."

* identifier[0].system = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/sid/psi"
* identifier[=].type = $V2-0203#MD "Medical License number"
* identifier[=].value = "PSI-54321"

* active = true
* name[0].use = #official
* name[=].family = "Brennan"
* name[=].given = "Niamh"
* name[=].prefix = "Ms."
* gender = #female

* telecom[0].system = #phone
* telecom[=].value = "+353 1 677 6462"
* telecom[=].use = #work
* telecom[+].system = #email
* telecom[=].value = "niamh.brennan@boots.ie"
* telecom[=].use = #work

* address[0].use = #work
* address[=].line = "14 Grafton Street"
* address[=].city = "Dublin"
* address[=].postalCode = "D02 HH74"
* address[=].country = "IE"

* qualification[0].code = $SCT#46255001 "Pharmacist"
* qualification[=].issuer.display = "Pharmaceutical Society of Ireland"


// ====================================================================
// SUPPORTING RESOURCES – CROSS-BORDER (SPAIN)
// ====================================================================

Instance: ie-core-patient-es-maria-garcia
InstanceOf: IECorePatient
Usage: #example
Title: "Spanish Patient – María García López (visiting Ireland)"
Description: "A Spanish patient visiting Ireland. Carries a Spanish CIP identifier and European Health Insurance Card (EHIC). Holds a prescription from a Spanish GP to be dispensed in Ireland."

* identifier[0].system = "http://www.mscbs.gob.es/fhir/sid/cip"
* identifier[=].type = $V2-0203#NI "National unique individual identifier"
* identifier[=].value = "ES280000000000000012"

* identifier[+].system = "urn:oid:1.3.6.1.4.1.36764"
* identifier[=].type = $V2-0203#PN "Person number"
* identifier[=].value = "ES-28-12345678X"

* active = true
* name[0].use = #official
* name[=].family = "García López"
* name[=].given[0] = "María"
* name[=].given[+] = "Concepción"
* name[=].prefix = "Sra."
* gender = #female
* birthDate = "1975-08-22"

* address[0].use = #home
* address[=].type = #physical
* address[=].line = "Calle Gran Vía 45, 2º A"
* address[=].city = "Madrid"
* address[=].state = "Madrid"
* address[=].postalCode = "28013"
* address[=].country = "ES"

* telecom[0].system = #phone
* telecom[=].value = "+34 91 555 1234"
* telecom[=].use = #home
* telecom[+].system = #email
* telecom[=].value = "maria.garcia@example.es"
* telecom[=].use = #home

* communication[0].language = urn:ietf:bcp:47#es "Spanish"
* communication[=].preferred = true
* communication[+].language = urn:ietf:bcp:47#en "English"


Instance: ie-core-practitioner-es-example
InstanceOf: IECorePractitioner
Usage: #example
Title: "Spanish Practitioner – Dr. Alejandro Martínez Ruiz"
Description: "A Spanish GP who issued a prescription for a Spanish patient, to be dispensed cross-border in Ireland via MyHealth@EU."

* identifier[0].system = "http://www.mscbs.gob.es/fhir/sid/colegiadoMedico"
* identifier[=].type = $V2-0203#MD "Medical License number"
* identifier[=].value = "ES-COL-28-001234"

* active = true
* name[0].use = #official
* name[=].family = "Martínez Ruiz"
* name[=].given[0] = "Alejandro"
* name[=].prefix = "Dr."
* gender = #male

* telecom[0].system = #phone
* telecom[=].value = "+34 91 555 6789"
* telecom[=].use = #work

* address[0].use = #work
* address[=].line = "Centro de Salud Las Águilas, Calle Serrano 12"
* address[=].city = "Madrid"
* address[=].postalCode = "28006"
* address[=].country = "ES"

* qualification[0].code = $SCT#62247001 "General practitioner"
* qualification[=].issuer.display = "Consejo General de Colegios Oficiales de Médicos de España"


Instance: ie-core-organization-es-health-centre
InstanceOf: IECoreOrganization
Usage: #example
Title: "Spanish Health Centre – Centro de Salud Las Águilas, Madrid"
Description: "The Spanish primary care centre where the Spanish GP practises and issued the cross-border prescription."

* identifier[0].system = "http://www.mscbs.gob.es/fhir/sid/centroSanitario"
* identifier[=].value = "ES-CS-28-001234"

* active = true
* type = http://terminology.hl7.org/CodeSystem/organization-type#prov "Healthcare Provider"
* name = "Centro de Salud Las Águilas"

* telecom[0].system = #phone
* telecom[=].value = "+34 91 555 6789"
* telecom[=].use = #work

* address[0].use = #work
* address[=].type = #physical
* address[=].line = "Calle Serrano 12"
* address[=].city = "Madrid"
* address[=].postalCode = "28006"
* address[=].country = "ES"


Instance: ie-core-organization-es-pharmacy
InstanceOf: IECoreOrganization
Usage: #example
Title: "Spanish Pharmacy – Farmacia Avenida de América, Madrid"
Description: "A Spanish community pharmacy in Madrid that dispenses a cross-border prescription for an Irish patient traveling in Spain."

* identifier[0].system = "http://www.mscbs.gob.es/fhir/sid/oficinaDeFarmacia"
* identifier[=].value = "ES-OF-28-009876"

* active = true
* type = http://terminology.hl7.org/CodeSystem/organization-type#prov "Healthcare Provider"
* name = "Farmacia Avenida de América"

* telecom[0].system = #phone
* telecom[=].value = "+34 91 555 3456"
* telecom[=].use = #work

* address[0].use = #work
* address[=].type = #physical
* address[=].line = "Avenida de América 34"
* address[=].city = "Madrid"
* address[=].postalCode = "28028"
* address[=].country = "ES"


Instance: ie-core-practitioner-es-pharmacist
InstanceOf: IECorePractitioner
Usage: #example
Title: "Spanish Pharmacist – Dra. Carmen Vega Soto"
Description: "A Spanish pharmacist dispensing a cross-border prescription from Ireland (Scenario 4: IE→ES)."

* identifier[0].system = "http://www.mscbs.gob.es/fhir/sid/colegiadoFarmaceutico"
* identifier[=].type = $V2-0203#MD "Medical License number"
* identifier[=].value = "ES-CF-28-005678"

* active = true
* name[0].use = #official
* name[=].family = "Vega Soto"
* name[=].given = "Carmen"
* name[=].prefix = "Dra."
* gender = #female

* qualification[0].code = $SCT#46255001 "Pharmacist"
* qualification[=].issuer.display = "Consejo General de Colegios Oficiales de Farmacéuticos"


// ====================================================================
// SCENARIO 1 – Local IE: Full Dispensing of a Single Prescription
// Patient: John Murphy | Rx: Metformin 500mg (60 tabs, 30-day supply)
// ====================================================================

Instance: ie-prescription-scenario1-full
InstanceOf: IECoreMedicationRequestEPrescription
Usage: #example
Title: "Scenario 1 – IE Local Prescription: Metformin (Full Dispense)"
Description: "A standard Irish GP prescription for Metformin 500mg tablets. Authorised via PCRS. Intended for a single full dispensation."

* identifier[0].system = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/sid/pcrs-rx"
* identifier[=].value = "PCRS-RX-2024-001001"

* status = #active
* intent = #order
* category = http://terminology.hl7.org/CodeSystem/medicationrequest-category#community "Community"

* medicationReference = Reference(ie-core-medication-metformin-500)

* subject = Reference(ie-core-patient-example) "John Murphy"
* encounter = Reference(ie-core-encounter-example) "Ambulatory encounter 2024-06-15"
* authoredOn = "2024-06-15"
* requester = Reference(ie-core-practitioner-example) "Dr. Sarah O'Brien"

* reasonCode = $SCT#44054006 "Diabetes mellitus type 2"

* dosageInstruction[0].sequence = 1
* dosageInstruction[=].text = "Take one 500mg tablet twice daily with meals"
* dosageInstruction[=].timing.repeat.frequency = 2
* dosageInstruction[=].timing.repeat.period = 1
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].route = $SCT#26643006 "Oral route"
* dosageInstruction[=].doseAndRate[0].doseQuantity = 500 'mg' "mg"

* dispenseRequest.validityPeriod.start = "2024-06-15"
* dispenseRequest.validityPeriod.end = "2024-07-15"
* dispenseRequest.numberOfRepeatsAllowed = 0
* dispenseRequest.quantity = 60 '{tablet}' "tablets"
* dispenseRequest.expectedSupplyDuration = 30 'd' "days"

* substitution.allowedBoolean = true


Instance: ie-dispense-scenario1-full
InstanceOf: IECoreMedicationDispenseEDispensation
Usage: #example
Title: "Scenario 1 – IE Local Dispense: Metformin Full Dispensation"
Description: "Full dispensation of 60 Metformin 500mg tablets against Scenario 1 prescription. Dispensed in full at Boots Pharmacy Dublin."

* identifier[0].system = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/sid/dispense-id"
* identifier[=].value = "DISP-IE-2024-001001"

* status = #completed
* medicationReference = Reference(ie-core-medication-metformin-500)

* subject = Reference(ie-core-patient-example) "John Murphy"
* context = Reference(ie-core-encounter-example) "Ambulatory encounter 2024-06-15"

* performer[0].actor = Reference(ie-core-practitioner-pharmacist-example) "Niamh Brennan"

* authorizingPrescription = Reference(ie-prescription-scenario1-full) "PCRS-RX-2024-001001"

* type = http://terminology.hl7.org/CodeSystem/v3-ActCode#DF "Daily Fill"
* quantity = 60 '{tablet}' "tablets"
* daysSupply = 30 'd' "days"

* whenPrepared = "2024-06-15T14:00:00+01:00"
* whenHandedOver = "2024-06-15T14:15:00+01:00"

* dosageInstruction[0].text = "Take one 500mg tablet twice daily with meals"
* dosageInstruction[=].timing.repeat.frequency = 2
* dosageInstruction[=].timing.repeat.period = 1
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].route = $SCT#26643006 "Oral route"

* substitution.wasSubstituted = false


// ====================================================================
// SCENARIO 2 – Local IE: Partial Dispensing (Atorvastatin 20mg, 90 tabs)
// 3 dispensations of 30 tabs each over 3 months
// ====================================================================

Instance: ie-prescription-scenario2-partial
InstanceOf: IECoreMedicationRequestEPrescription
Usage: #example
Title: "Scenario 2 – IE Local Prescription: Atorvastatin (Partial Dispense)"
Description: "An Irish GP prescription for Atorvastatin 20mg tablets (90 days supply). Intended to be dispensed in three partial dispensations of 30 tablets each, reflecting typical Irish community pharmacy dispensing for long-term medication."

* identifier[0].system = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/sid/pcrs-rx"
* identifier[=].value = "PCRS-RX-2024-002001"

* status = #active
* intent = #order
* category = http://terminology.hl7.org/CodeSystem/medicationrequest-category#community "Community"

* medicationReference = Reference(ie-core-medication-atorvastatin-20)

* subject = Reference(ie-core-patient-example) "John Murphy"
* encounter = Reference(ie-core-encounter-example) "Ambulatory encounter 2024-06-15"
* authoredOn = "2024-06-15"
* requester = Reference(ie-core-practitioner-example) "Dr. Sarah O'Brien"

* reasonCode = $SCT#55822004 "Hyperlipidemia"

* dosageInstruction[0].sequence = 1
* dosageInstruction[=].text = "Take one 20mg tablet once daily at night"
* dosageInstruction[=].timing.repeat.frequency = 1
* dosageInstruction[=].timing.repeat.period = 1
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].timing.repeat.when = #CV
* dosageInstruction[=].route = $SCT#26643006 "Oral route"
* dosageInstruction[=].doseAndRate[0].doseQuantity = 20 'mg' "mg"

* dispenseRequest.validityPeriod.start = "2024-06-15"
* dispenseRequest.validityPeriod.end = "2024-09-15"
* dispenseRequest.numberOfRepeatsAllowed = 2
* dispenseRequest.quantity = 90 '{tablet}' "tablets"
* dispenseRequest.expectedSupplyDuration = 90 'd' "days"

* substitution.allowedBoolean = true


Instance: ie-dispense-scenario2-partial-1
InstanceOf: IECoreMedicationDispenseEDispensation
Usage: #example
Title: "Scenario 2 – Partial Dispense 1 of 3: Atorvastatin 30 tabs (Month 1)"
Description: "First partial dispensation of 30 Atorvastatin 20mg tablets (of 90 prescribed) on 15 June 2024."

* identifier[0].system = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/sid/dispense-id"
* identifier[=].value = "DISP-IE-2024-002001-1"

* status = #completed
* medicationReference = Reference(ie-core-medication-atorvastatin-20)
* subject = Reference(ie-core-patient-example) "John Murphy"

* performer[0].actor = Reference(ie-core-practitioner-pharmacist-example) "Niamh Brennan"

* authorizingPrescription = Reference(ie-prescription-scenario2-partial) "PCRS-RX-2024-002001"

* type = http://terminology.hl7.org/CodeSystem/v3-ActCode#FFP "First Fill - Part Fill"
* quantity = 30 '{tablet}' "tablets"
* daysSupply = 30 'd' "days"

* whenPrepared = "2024-06-15T14:30:00+01:00"
* whenHandedOver = "2024-06-15T14:45:00+01:00"

* dosageInstruction[0].text = "Take one 20mg tablet once daily at night"
* substitution.wasSubstituted = false


Instance: ie-dispense-scenario2-partial-2
InstanceOf: IECoreMedicationDispenseEDispensation
Usage: #example
Title: "Scenario 2 – Partial Dispense 2 of 3: Atorvastatin 30 tabs (Month 2)"
Description: "Second partial dispensation of 30 Atorvastatin 20mg tablets on 15 July 2024."

* identifier[0].system = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/sid/dispense-id"
* identifier[=].value = "DISP-IE-2024-002001-2"

* status = #completed
* medicationReference = Reference(ie-core-medication-atorvastatin-20)
* subject = Reference(ie-core-patient-example) "John Murphy"

* performer[0].actor = Reference(ie-core-practitioner-pharmacist-example) "Niamh Brennan"

* authorizingPrescription = Reference(ie-prescription-scenario2-partial) "PCRS-RX-2024-002001"

* type = http://terminology.hl7.org/CodeSystem/v3-ActCode#FFP "First Fill - Part Fill"
* quantity = 30 '{tablet}' "tablets"
* daysSupply = 30 'd' "days"

* whenPrepared = "2024-07-15T10:00:00+01:00"
* whenHandedOver = "2024-07-15T10:10:00+01:00"

* dosageInstruction[0].text = "Take one 20mg tablet once daily at night"
* substitution.wasSubstituted = false


Instance: ie-dispense-scenario2-partial-3
InstanceOf: IECoreMedicationDispenseEDispensation
Usage: #example
Title: "Scenario 2 – Partial Dispense 3 of 3: Atorvastatin 30 tabs (Month 3 – Final)"
Description: "Third and final partial dispensation of 30 Atorvastatin 20mg tablets on 15 August 2024. Completes the full 90-tablet prescription."

* identifier[0].system = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/sid/dispense-id"
* identifier[=].value = "DISP-IE-2024-002001-3"

* status = #completed
* medicationReference = Reference(ie-core-medication-atorvastatin-20)
* subject = Reference(ie-core-patient-example) "John Murphy"

* performer[0].actor = Reference(ie-core-practitioner-pharmacist-example) "Niamh Brennan"

* authorizingPrescription = Reference(ie-prescription-scenario2-partial) "PCRS-RX-2024-002001"

* type = http://terminology.hl7.org/CodeSystem/v3-ActCode#FFP "First Fill - Part Fill"
* quantity = 30 '{tablet}' "tablets"
* daysSupply = 30 'd' "days"

* whenPrepared = "2024-08-15T11:00:00+01:00"
* whenHandedOver = "2024-08-15T11:10:00+01:00"

* dosageInstruction[0].text = "Take one 20mg tablet once daily at night"
* substitution.wasSubstituted = false


// ====================================================================
// SCENARIO 3 – Multiple Prescriptions in a Single Bundle
// Patient: John Murphy | Rx: Metformin + Atorvastatin + Ramipril
// ====================================================================

Instance: ie-prescription-scenario3-multi-metformin
InstanceOf: IECoreMedicationRequestEPrescription
Usage: #example
Title: "Scenario 3 – Multi-Rx Bundle: Metformin 500mg"
Description: "First of three prescriptions in a multi-prescription bundle for John Murphy. Metformin for Type 2 Diabetes."

* identifier[0].system = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/sid/pcrs-rx"
* identifier[=].value = "PCRS-RX-2024-003001"

* groupIdentifier.system = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/sid/prescription-group"
* groupIdentifier.value = "IE-GP-RX-GROUP-20240620"

* status = #active
* intent = #order
* category = http://terminology.hl7.org/CodeSystem/medicationrequest-category#community "Community"

* medicationReference = Reference(ie-core-medication-metformin-500)

* subject = Reference(ie-core-patient-example) "John Murphy"
* authoredOn = "2024-06-20"
* requester = Reference(ie-core-practitioner-example) "Dr. Sarah O'Brien"

* reasonCode = $SCT#44054006 "Diabetes mellitus type 2"

* dosageInstruction[0].text = "Take one 500mg tablet twice daily with meals"
* dosageInstruction[=].timing.repeat.frequency = 2
* dosageInstruction[=].timing.repeat.period = 1
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].route = $SCT#26643006 "Oral route"
* dosageInstruction[=].doseAndRate[0].doseQuantity = 500 'mg' "mg"

* dispenseRequest.validityPeriod.start = "2024-06-20"
* dispenseRequest.validityPeriod.end = "2024-07-20"
* dispenseRequest.numberOfRepeatsAllowed = 5
* dispenseRequest.quantity = 60 '{tablet}' "tablets"
* dispenseRequest.expectedSupplyDuration = 30 'd' "days"

* substitution.allowedBoolean = true


Instance: ie-prescription-scenario3-multi-atorvastatin
InstanceOf: IECoreMedicationRequestEPrescription
Usage: #example
Title: "Scenario 3 – Multi-Rx Bundle: Atorvastatin 20mg"
Description: "Second of three prescriptions in a multi-prescription bundle for John Murphy. Atorvastatin for hyperlipidaemia."

* identifier[0].system = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/sid/pcrs-rx"
* identifier[=].value = "PCRS-RX-2024-003002"

* groupIdentifier.system = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/sid/prescription-group"
* groupIdentifier.value = "IE-GP-RX-GROUP-20240620"

* status = #active
* intent = #order
* category = http://terminology.hl7.org/CodeSystem/medicationrequest-category#community "Community"

* medicationReference = Reference(ie-core-medication-atorvastatin-20)

* subject = Reference(ie-core-patient-example) "John Murphy"
* authoredOn = "2024-06-20"
* requester = Reference(ie-core-practitioner-example) "Dr. Sarah O'Brien"

* reasonCode = $SCT#55822004 "Hyperlipidemia"

* dosageInstruction[0].text = "Take one 20mg tablet once daily at night"
* dosageInstruction[=].timing.repeat.frequency = 1
* dosageInstruction[=].timing.repeat.period = 1
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].route = $SCT#26643006 "Oral route"
* dosageInstruction[=].doseAndRate[0].doseQuantity = 20 'mg' "mg"

* dispenseRequest.validityPeriod.start = "2024-06-20"
* dispenseRequest.validityPeriod.end = "2024-09-20"
* dispenseRequest.numberOfRepeatsAllowed = 2
* dispenseRequest.quantity = 30 '{tablet}' "tablets"
* dispenseRequest.expectedSupplyDuration = 30 'd' "days"

* substitution.allowedBoolean = true


Instance: ie-prescription-scenario3-multi-ramipril
InstanceOf: IECoreMedicationRequestEPrescription
Usage: #example
Title: "Scenario 3 – Multi-Rx Bundle: Ramipril 5mg"
Description: "Third of three prescriptions in a multi-prescription bundle for John Murphy. Ramipril for hypertension/cardiac protection."

* identifier[0].system = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/sid/pcrs-rx"
* identifier[=].value = "PCRS-RX-2024-003003"

* groupIdentifier.system = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/sid/prescription-group"
* groupIdentifier.value = "IE-GP-RX-GROUP-20240620"

* status = #active
* intent = #order
* category = http://terminology.hl7.org/CodeSystem/medicationrequest-category#community "Community"

* medicationReference = Reference(ie-core-medication-ramipril-5)

* subject = Reference(ie-core-patient-example) "John Murphy"
* authoredOn = "2024-06-20"
* requester = Reference(ie-core-practitioner-example) "Dr. Sarah O'Brien"

* reasonCode = $SCT#38341003 "Hypertensive disorder"

* dosageInstruction[0].text = "Take one 5mg capsule once daily in the morning"
* dosageInstruction[=].timing.repeat.frequency = 1
* dosageInstruction[=].timing.repeat.period = 1
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].timing.repeat.when = #MORN
* dosageInstruction[=].route = $SCT#26643006 "Oral route"
* dosageInstruction[=].doseAndRate[0].doseQuantity = 5 'mg' "mg"

* dispenseRequest.validityPeriod.start = "2024-06-20"
* dispenseRequest.validityPeriod.end = "2024-07-20"
* dispenseRequest.numberOfRepeatsAllowed = 5
* dispenseRequest.quantity = 28 '{capsule}' "capsules"
* dispenseRequest.expectedSupplyDuration = 28 'd' "days"

* substitution.allowedBoolean = true


Instance: ie-dispense-scenario3-metformin
InstanceOf: IECoreMedicationDispenseEDispensation
Usage: #example
Title: "Scenario 3 – Multi-Rx Bundle Dispense: Metformin"
Description: "Full dispensation of Metformin 60 tablets from the multi-prescription bundle."

* identifier[0].system = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/sid/dispense-id"
* identifier[=].value = "DISP-IE-2024-003001"

* status = #completed
* medicationReference = Reference(ie-core-medication-metformin-500)
* subject = Reference(ie-core-patient-example) "John Murphy"
* performer[0].actor = Reference(ie-core-practitioner-pharmacist-example) "Niamh Brennan"
* authorizingPrescription = Reference(ie-prescription-scenario3-multi-metformin)
* type = http://terminology.hl7.org/CodeSystem/v3-ActCode#DF "Daily Fill"
* quantity = 60 '{tablet}' "tablets"
* daysSupply = 30 'd' "days"
* whenPrepared = "2024-06-20T16:00:00+01:00"
* whenHandedOver = "2024-06-20T16:15:00+01:00"
* dosageInstruction[0].text = "Take one 500mg tablet twice daily with meals"
* substitution.wasSubstituted = false


Instance: ie-dispense-scenario3-atorvastatin
InstanceOf: IECoreMedicationDispenseEDispensation
Usage: #example
Title: "Scenario 3 – Multi-Rx Bundle Dispense: Atorvastatin"
Description: "Full dispensation of Atorvastatin 30 tablets from the multi-prescription bundle."

* identifier[0].system = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/sid/dispense-id"
* identifier[=].value = "DISP-IE-2024-003002"

* status = #completed
* medicationReference = Reference(ie-core-medication-atorvastatin-20)
* subject = Reference(ie-core-patient-example) "John Murphy"
* performer[0].actor = Reference(ie-core-practitioner-pharmacist-example) "Niamh Brennan"
* authorizingPrescription = Reference(ie-prescription-scenario3-multi-atorvastatin)
* type = http://terminology.hl7.org/CodeSystem/v3-ActCode#DF "Daily Fill"
* quantity = 30 '{tablet}' "tablets"
* daysSupply = 30 'd' "days"
* whenPrepared = "2024-06-20T16:00:00+01:00"
* whenHandedOver = "2024-06-20T16:15:00+01:00"
* dosageInstruction[0].text = "Take one 20mg tablet once daily at night"
* substitution.wasSubstituted = false


Instance: ie-dispense-scenario3-ramipril
InstanceOf: IECoreMedicationDispenseEDispensation
Usage: #example
Title: "Scenario 3 – Multi-Rx Bundle Dispense: Ramipril"
Description: "Full dispensation of Ramipril 28 capsules from the multi-prescription bundle."

* identifier[0].system = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/sid/dispense-id"
* identifier[=].value = "DISP-IE-2024-003003"

* status = #completed
* medicationReference = Reference(ie-core-medication-ramipril-5)
* subject = Reference(ie-core-patient-example) "John Murphy"
* performer[0].actor = Reference(ie-core-practitioner-pharmacist-example) "Niamh Brennan"
* authorizingPrescription = Reference(ie-prescription-scenario3-multi-ramipril)
* type = http://terminology.hl7.org/CodeSystem/v3-ActCode#DF "Daily Fill"
* quantity = 28 '{capsule}' "capsules"
* daysSupply = 28 'd' "days"
* whenPrepared = "2024-06-20T16:00:00+01:00"
* whenHandedOver = "2024-06-20T16:15:00+01:00"
* dosageInstruction[0].text = "Take one 5mg capsule once daily in the morning"
* substitution.wasSubstituted = false


// ====================================================================
// SCENARIO 4 – Cross-border IE → ES
// Irish patient Ciarán Walsh travels to Spain, presents his Irish
// repeat prescription for Amlodipine to a Spanish pharmacy.
// Cross-border via MyHealth@EU / eHDSI NCP
// ====================================================================

Instance: ie-core-patient-ciaran-walsh
InstanceOf: IECorePatient
Usage: #example
Title: "Irish Patient – Ciarán Walsh (traveling in Spain)"
Description: "An Irish patient with a chronic prescription for Amlodipine who is visiting Spain and seeks dispensation at a Spanish pharmacy via MyHealth@EU."

* identifier[IHI].system = $IHI
* identifier[IHI].type = $V2-0203#NI "National unique individual identifier"
* identifier[IHI].value = "210000000055667788"

* identifier[GMS].system = $GMS
* identifier[GMS].type = $V2-0203#MC "Patient's Medicare number"
* identifier[GMS].value = "8765432C"

* active = true
* name[0].use = #official
* name[=].family = "Walsh"
* name[=].given[0] = "Ciarán"
* name[=].given[+] = "Seamus"
* name[=].prefix = "Mr."
* gender = #male
* birthDate = "1968-11-03"

* address[0].use = #home
* address[=].type = #physical
* address[=].line = "22 Clontarf Road"
* address[=].city = "Dublin"
* address[=].state = "Dublin"
* address[=].postalCode = "D03 YP78"
* address[=].country = "IE"

* telecom[0].system = #phone
* telecom[=].value = "+353 87 654 3210"
* telecom[=].use = #mobile

* communication[0].language = urn:ietf:bcp:47#en "English"
* communication[=].preferred = true
* communication[+].language = urn:ietf:bcp:47#ga "Irish"


Instance: ie-prescription-scenario4-ie-to-es
InstanceOf: IECoreMedicationRequestEPrescription
Usage: #example
Title: "Scenario 4 – Cross-border IE→ES: Amlodipine Repeat Prescription"
Description: "An Irish ePrescription for Amlodipine 5mg (chronic hypertension, repeat prescription) issued by an Irish GP. This prescription is transmitted via the MyHealth@EU infrastructure (IE NCP → ES NCP) for dispensation at a Spanish pharmacy. The prescription is tagged as cross-border eligible."

* identifier[0].system = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/sid/pcrs-rx"
* identifier[=].value = "PCRS-RX-2024-004001"

* identifier[+].system = "urn:oid:2.16.840.1.113883.2.16.1.4.1"
* identifier[=].value = "IE-EHIC-XB-2024-004001"

* status = #active
* intent = #order
* category[0] = http://terminology.hl7.org/CodeSystem/medicationrequest-category#community "Community"

* medicationReference = Reference(ie-core-medication-amlodipine-5)

* subject = Reference(ie-core-patient-ciaran-walsh) "Ciarán Walsh"
* authoredOn = "2024-07-10"
* requester = Reference(ie-core-practitioner-example) "Dr. Sarah O'Brien"

* reasonCode = $SCT#38341003 "Hypertensive disorder"

* dosageInstruction[0].text = "Take one 5mg tablet once daily"
* dosageInstruction[=].timing.repeat.frequency = 1
* dosageInstruction[=].timing.repeat.period = 1
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].route = $SCT#26643006 "Oral route"
* dosageInstruction[=].doseAndRate[0].doseQuantity = 5 'mg' "mg"

* dispenseRequest.validityPeriod.start = "2024-07-10"
* dispenseRequest.validityPeriod.end = "2024-10-10"
* dispenseRequest.numberOfRepeatsAllowed = 2
* dispenseRequest.quantity = 30 '{tablet}' "tablets"
* dispenseRequest.expectedSupplyDuration = 30 'd' "days"

* substitution.allowedBoolean = true
* substitution.reason = $SCT#373873005 "Pharmaceutical / biologic product"


Instance: ie-dispense-scenario4-es-pharmacy
InstanceOf: IECoreMedicationDispenseEDispensation
Usage: #example
Title: "Scenario 4 – Cross-border IE→ES: Spanish Dispensation of Irish Prescription"
Description: "A Spanish pharmacy dispenses Amlodipine 5mg (30 tablets) against the Irish cross-border ePrescription for Ciarán Walsh, via MyHealth@EU. The Spanish pharmacist substituted with a locally available generic equivalent (Norvasc generic, ES market)."

* identifier[0].system = "http://www.mscbs.gob.es/fhir/sid/dispensacion"
* identifier[=].value = "ES-DISP-2024-XB-004001"

* status = #completed
* medicationReference = Reference(ie-core-medication-amlodipine-5)

* subject = Reference(ie-core-patient-ciaran-walsh) "Ciarán Walsh"

* performer[0].actor = Reference(ie-core-practitioner-es-pharmacist) "Dra. Carmen Vega Soto"

* authorizingPrescription = Reference(ie-prescription-scenario4-ie-to-es) "PCRS-RX-2024-004001"

* type = http://terminology.hl7.org/CodeSystem/v3-ActCode#DF "Daily Fill"
* quantity = 30 '{tablet}' "tablets"
* daysSupply = 30 'd' "days"

* whenPrepared = "2024-07-28T11:30:00+02:00"
* whenHandedOver = "2024-07-28T11:45:00+02:00"

* dosageInstruction[0].text = "Tomar un comprimido de 5mg una vez al día (Take one 5mg tablet once daily)"

* substitution.wasSubstituted = true
* substitution.type = http://terminology.hl7.org/CodeSystem/v3-substanceAdminSubstitution#G "Generic composition"
* substitution.reason = $SCT#373873005 "Pharmaceutical / biologic product"
* substitution.responsibleParty = Reference(ie-core-practitioner-es-pharmacist) "Dra. Carmen Vega Soto"


// ====================================================================
// SCENARIO 5 – Cross-border ES → IE
// Spanish patient María García López visits Ireland and presents her
// Spanish prescription for Amlodipine to an Irish pharmacy.
// ====================================================================

Instance: ie-prescription-scenario5-es-to-ie
InstanceOf: IECoreMedicationRequestEPrescription
Usage: #example
Title: "Scenario 5 – Cross-border ES→IE: Spanish Prescription for Amlodipine"
Description: "A Spanish ePrescription for Amlodipine 5mg issued by a Spanish GP for María García López. This prescription has been converted to FHIR format by the Spanish NCP (Punto de Contacto Nacional) for cross-border dispensation in Ireland via MyHealth@EU."

* identifier[0].system = "http://www.mscbs.gob.es/fhir/sid/recetaElectronica"
* identifier[=].value = "ES-RX-2024-28-987654321"

* identifier[+].system = "urn:oid:2.16.840.1.113883.2.16.1.4.1"
* identifier[=].value = "ES-EHIC-XB-2024-005001"

* status = #active
* intent = #order
* category = http://terminology.hl7.org/CodeSystem/medicationrequest-category#community "Community"

* medicationReference = Reference(ie-core-medication-amlodipine-5)

* subject = Reference(ie-core-patient-es-maria-garcia) "María García López"
* authoredOn = "2024-08-01"
* requester = Reference(ie-core-practitioner-es-example) "Dr. Alejandro Martínez Ruiz"

* reasonCode = $SCT#38341003 "Hypertensive disorder"

* dosageInstruction[0].text = "Take one 5mg tablet once daily (Tomar un comprimido de 5mg una vez al día)"
* dosageInstruction[=].timing.repeat.frequency = 1
* dosageInstruction[=].timing.repeat.period = 1
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].route = $SCT#26643006 "Oral route"
* dosageInstruction[=].doseAndRate[0].doseQuantity = 5 'mg' "mg"

* dispenseRequest.validityPeriod.start = "2024-08-01"
* dispenseRequest.validityPeriod.end = "2024-11-01"
* dispenseRequest.numberOfRepeatsAllowed = 2
* dispenseRequest.quantity = 30 '{tablet}' "tablets"
* dispenseRequest.expectedSupplyDuration = 30 'd' "days"

* substitution.allowedBoolean = true


Instance: ie-dispense-scenario5-ie-pharmacy
InstanceOf: IECoreMedicationDispenseEDispensation
Usage: #example
Title: "Scenario 5 – Cross-border ES→IE: Irish Dispensation of Spanish Prescription"
Description: "An Irish pharmacy (Boots, Grafton St.) dispenses Amlodipine 5mg tablets against the Spanish cross-border ePrescription for María García López, via MyHealth@EU. Equivalent Irish-licensed generic dispensed."

* identifier[0].system = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/sid/dispense-id"
* identifier[=].value = "DISP-IE-2024-XB-005001"

* status = #completed
* medicationReference = Reference(ie-core-medication-amlodipine-5)

* subject = Reference(ie-core-patient-es-maria-garcia) "María García López"

* performer[0].actor = Reference(ie-core-practitioner-pharmacist-example) "Niamh Brennan"

* authorizingPrescription = Reference(ie-prescription-scenario5-es-to-ie) "ES-RX-2024-28-987654321"

* type = http://terminology.hl7.org/CodeSystem/v3-ActCode#DF "Daily Fill"
* quantity = 30 '{tablet}' "tablets"
* daysSupply = 30 'd' "days"

* whenPrepared = "2024-08-12T14:00:00+01:00"
* whenHandedOver = "2024-08-12T14:15:00+01:00"

* dosageInstruction[0].text = "Take one 5mg tablet once daily"
* dosageInstruction[=].timing.repeat.frequency = 1
* dosageInstruction[=].timing.repeat.period = 1
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].route = $SCT#26643006 "Oral route"

* substitution.wasSubstituted = false


// ====================================================================
// SCENARIO 6 – Repeat Prescription with Multiple Sequential Dispensations
// Patient: John Murphy | Rx: Metformin 500mg | 6-month GMS repeat
// ====================================================================

Instance: ie-prescription-scenario6-repeat
InstanceOf: IECoreMedicationRequestEPrescription
Usage: #example
Title: "Scenario 6 – Repeat Prescription: Metformin 500mg (6-month GMS)"
Description: "A GMS repeat prescription for Metformin 500mg tablets, valid for 6 months with up to 6 dispensation events (once monthly). Represents a typical Irish GMS chronic disease management prescription under the Drugs Payment Scheme."

* identifier[0].system = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/sid/pcrs-rx"
* identifier[=].value = "PCRS-RX-2024-006001"

* status = #active
* intent = #order
* category = http://terminology.hl7.org/CodeSystem/medicationrequest-category#community "Community"

* medicationReference = Reference(ie-core-medication-metformin-500)

* subject = Reference(ie-core-patient-example) "John Murphy"
* authoredOn = "2024-01-10"
* requester = Reference(ie-core-practitioner-example) "Dr. Sarah O'Brien"

* reasonCode = $SCT#44054006 "Diabetes mellitus type 2"

* dosageInstruction[0].text = "Take one 500mg tablet twice daily with meals"
* dosageInstruction[=].timing.repeat.frequency = 2
* dosageInstruction[=].timing.repeat.period = 1
* dosageInstruction[=].timing.repeat.periodUnit = #d
* dosageInstruction[=].route = $SCT#26643006 "Oral route"
* dosageInstruction[=].doseAndRate[0].doseQuantity = 500 'mg' "mg"

* dispenseRequest.validityPeriod.start = "2024-01-10"
* dispenseRequest.validityPeriod.end = "2024-07-10"
* dispenseRequest.numberOfRepeatsAllowed = 5
* dispenseRequest.quantity = 60 '{tablet}' "tablets"
* dispenseRequest.expectedSupplyDuration = 30 'd' "days"

* substitution.allowedBoolean = true


Instance: ie-dispense-scenario6-repeat-month1
InstanceOf: IECoreMedicationDispenseEDispensation
Usage: #example
Title: "Scenario 6 – Repeat Dispense Month 1: Metformin January 2024"
Description: "First monthly dispensation of Metformin under the 6-month GMS repeat prescription."

* identifier[0].system = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/sid/dispense-id"
* identifier[=].value = "DISP-IE-2024-006001-M1"
* status = #completed
* medicationReference = Reference(ie-core-medication-metformin-500)
* subject = Reference(ie-core-patient-example) "John Murphy"
* performer[0].actor = Reference(ie-core-practitioner-pharmacist-example) "Niamh Brennan"
* authorizingPrescription = Reference(ie-prescription-scenario6-repeat)
* type = http://terminology.hl7.org/CodeSystem/v3-ActCode#FF "First Fill"
* quantity = 60 '{tablet}' "tablets"
* daysSupply = 30 'd' "days"
* whenHandedOver = "2024-01-10T10:00:00+00:00"
* dosageInstruction[0].text = "Take one 500mg tablet twice daily with meals"
* substitution.wasSubstituted = false


Instance: ie-dispense-scenario6-repeat-month2
InstanceOf: IECoreMedicationDispenseEDispensation
Usage: #example
Title: "Scenario 6 – Repeat Dispense Month 2: Metformin February 2024"
Description: "Second monthly dispensation of Metformin under the 6-month GMS repeat prescription."

* identifier[0].system = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/sid/dispense-id"
* identifier[=].value = "DISP-IE-2024-006001-M2"
* status = #completed
* medicationReference = Reference(ie-core-medication-metformin-500)
* subject = Reference(ie-core-patient-example) "John Murphy"
* performer[0].actor = Reference(ie-core-practitioner-pharmacist-example) "Niamh Brennan"
* authorizingPrescription = Reference(ie-prescription-scenario6-repeat)
* type = http://terminology.hl7.org/CodeSystem/v3-ActCode#RF "Refill"
* quantity = 60 '{tablet}' "tablets"
* daysSupply = 30 'd' "days"
* whenHandedOver = "2024-02-10T10:30:00+00:00"
* dosageInstruction[0].text = "Take one 500mg tablet twice daily with meals"
* substitution.wasSubstituted = false


Instance: ie-dispense-scenario6-repeat-month3
InstanceOf: IECoreMedicationDispenseEDispensation
Usage: #example
Title: "Scenario 6 – Repeat Dispense Month 3: Metformin March 2024"
Description: "Third monthly dispensation of Metformin under the 6-month GMS repeat prescription."

* identifier[0].system = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/sid/dispense-id"
* identifier[=].value = "DISP-IE-2024-006001-M3"
* status = #completed
* medicationReference = Reference(ie-core-medication-metformin-500)
* subject = Reference(ie-core-patient-example) "John Murphy"
* performer[0].actor = Reference(ie-core-practitioner-pharmacist-example) "Niamh Brennan"
* authorizingPrescription = Reference(ie-prescription-scenario6-repeat)
* type = http://terminology.hl7.org/CodeSystem/v3-ActCode#RF "Refill"
* quantity = 60 '{tablet}' "tablets"
* daysSupply = 30 'd' "days"
* whenHandedOver = "2024-03-10T09:15:00+00:00"
* dosageInstruction[0].text = "Take one 500mg tablet twice daily with meals"
* substitution.wasSubstituted = false
