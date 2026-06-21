// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Search Parameters                                         │
// ╰──────────────────────────────────────────────────────────────────────╯

// ====================================================================
// Patient Search Parameters
// ====================================================================

Instance: ie-core-patient-name
InstanceOf: SearchParameter
Usage: #definition
Title: "IE Core Patient Name"
Description: "Search for a Patient by name (given, family, or full name). Servers SHALL support searching by patient name."

* url = "https://hl7-ie.github.io/hl7-ie-fhir-draft-ig/fhir/ie/core/SearchParameter/ie-core-patient-name"
* version = "0.1.0"
* name = "IECorePatientName"
* status = #draft
* experimental = false
* date = "2025-01-01"
* publisher = "IE Core (Proof of Concept by Nithin Mohan T K)"
* description = "Search for a Patient by name (given, family, or full name)."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* code = #name
* base = #Patient
* type = #string
* expression = "Patient.name"
* multipleOr = true
* multipleAnd = true
* modifier[0] = #exact
* modifier[+] = #contains


Instance: ie-core-patient-gender
InstanceOf: SearchParameter
Usage: #definition
Title: "IE Core Patient Gender"
Description: "Search for a Patient by administrative gender. Servers SHALL support searching by patient gender."

* url = "https://hl7-ie.github.io/hl7-ie-fhir-draft-ig/fhir/ie/core/SearchParameter/ie-core-patient-gender"
* version = "0.1.0"
* name = "IECorePatientGender"
* status = #draft
* experimental = false
* date = "2025-01-01"
* publisher = "IE Core (Proof of Concept by Nithin Mohan T K)"
* description = "Search for a Patient by administrative gender."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* code = #gender
* base = #Patient
* type = #token
* expression = "Patient.gender"


Instance: ie-core-patient-birthdate
InstanceOf: SearchParameter
Usage: #definition
Title: "IE Core Patient Birthdate"
Description: "Search for a Patient by date of birth. Servers SHALL support searching by patient birthdate."

* url = "https://hl7-ie.github.io/hl7-ie-fhir-draft-ig/fhir/ie/core/SearchParameter/ie-core-patient-birthdate"
* version = "0.1.0"
* name = "IECorePatientBirthdate"
* status = #draft
* experimental = false
* date = "2025-01-01"
* publisher = "IE Core (Proof of Concept by Nithin Mohan T K)"
* description = "Search for a Patient by date of birth."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* code = #birthdate
* base = #Patient
* type = #date
* expression = "Patient.birthDate"
* comparator[0] = #eq
* comparator[+] = #lt
* comparator[+] = #le
* comparator[+] = #gt
* comparator[+] = #ge
* comparator[+] = #sa
* comparator[+] = #eb


Instance: ie-core-patient-identifier
InstanceOf: SearchParameter
Usage: #definition
Title: "IE Core Patient Identifier"
Description: "Search for a Patient by identifier such as IHI, MRN, GMS number, DPS number, or LTI number. Servers SHALL support searching by patient identifier."

* url = "https://hl7-ie.github.io/hl7-ie-fhir-draft-ig/fhir/ie/core/SearchParameter/ie-core-patient-identifier"
* version = "0.1.0"
* name = "IECorePatientIdentifier"
* status = #draft
* experimental = false
* date = "2025-01-01"
* publisher = "IE Core (Proof of Concept by Nithin Mohan T K)"
* description = "Search for a Patient by identifier (IHI, MRN, GMS, DPS, LTI, HAA, IMN)."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* code = #identifier
* base = #Patient
* type = #token
* expression = "Patient.identifier"
* multipleOr = true
* multipleAnd = true


// ====================================================================
// Encounter Search Parameters
// ====================================================================

Instance: ie-core-encounter-patient
InstanceOf: SearchParameter
Usage: #definition
Title: "IE Core Encounter Patient"
Description: "Search for Encounters by patient reference. Servers SHALL support searching encounters by patient."

* url = "https://hl7-ie.github.io/hl7-ie-fhir-draft-ig/fhir/ie/core/SearchParameter/ie-core-encounter-patient"
* version = "0.1.0"
* name = "IECoreEncounterPatient"
* status = #draft
* experimental = false
* date = "2025-01-01"
* publisher = "IE Core (Proof of Concept by Nithin Mohan T K)"
* description = "Search for Encounters by patient reference."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* code = #patient
* base = #Encounter
* type = #reference
* expression = "Encounter.subject.where(resolve() is Patient)"
* target = #Patient


Instance: ie-core-encounter-date
InstanceOf: SearchParameter
Usage: #definition
Title: "IE Core Encounter Date"
Description: "Search for Encounters by date or period. Servers SHALL support searching encounters by date."

* url = "https://hl7-ie.github.io/hl7-ie-fhir-draft-ig/fhir/ie/core/SearchParameter/ie-core-encounter-date"
* version = "0.1.0"
* name = "IECoreEncounterDate"
* status = #draft
* experimental = false
* date = "2025-01-01"
* publisher = "IE Core (Proof of Concept by Nithin Mohan T K)"
* description = "Search for Encounters by date or period."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* code = #date
* base = #Encounter
* type = #date
* expression = "Encounter.period"
* comparator[0] = #eq
* comparator[+] = #lt
* comparator[+] = #le
* comparator[+] = #gt
* comparator[+] = #ge
* comparator[+] = #sa
* comparator[+] = #eb


Instance: ie-core-encounter-type
InstanceOf: SearchParameter
Usage: #definition
Title: "IE Core Encounter Type"
Description: "Search for Encounters by type. Servers SHOULD support searching encounters by type."

* url = "https://hl7-ie.github.io/hl7-ie-fhir-draft-ig/fhir/ie/core/SearchParameter/ie-core-encounter-type"
* version = "0.1.0"
* name = "IECoreEncounterType"
* status = #draft
* experimental = false
* date = "2025-01-01"
* publisher = "IE Core (Proof of Concept by Nithin Mohan T K)"
* description = "Search for Encounters by type."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* code = #type
* base = #Encounter
* type = #token
* expression = "Encounter.type"
* multipleOr = true
* multipleAnd = true


// ====================================================================
// Condition Search Parameters
// ====================================================================

Instance: ie-core-condition-patient
InstanceOf: SearchParameter
Usage: #definition
Title: "IE Core Condition Patient"
Description: "Search for Conditions by patient reference. Servers SHALL support searching conditions by patient."

* url = "https://hl7-ie.github.io/hl7-ie-fhir-draft-ig/fhir/ie/core/SearchParameter/ie-core-condition-patient"
* version = "0.1.0"
* name = "IECoreConditionPatient"
* status = #draft
* experimental = false
* date = "2025-01-01"
* publisher = "IE Core (Proof of Concept by Nithin Mohan T K)"
* description = "Search for Conditions by patient reference."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* code = #patient
* base = #Condition
* type = #reference
* expression = "Condition.subject.where(resolve() is Patient)"
* target = #Patient


Instance: ie-core-condition-code
InstanceOf: SearchParameter
Usage: #definition
Title: "IE Core Condition Code"
Description: "Search for Conditions by code (e.g. SNOMED CT or ICD-10). Servers SHALL support searching conditions by code."

* url = "https://hl7-ie.github.io/hl7-ie-fhir-draft-ig/fhir/ie/core/SearchParameter/ie-core-condition-code"
* version = "0.1.0"
* name = "IECoreConditionCode"
* status = #draft
* experimental = false
* date = "2025-01-01"
* publisher = "IE Core (Proof of Concept by Nithin Mohan T K)"
* description = "Search for Conditions by code (e.g. SNOMED CT or ICD-10)."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* code = #code
* base = #Condition
* type = #token
* expression = "Condition.code"
* multipleOr = true


Instance: ie-core-condition-onset-date
InstanceOf: SearchParameter
Usage: #definition
Title: "IE Core Condition Onset Date"
Description: "Search for Conditions by onset date. Servers SHOULD support searching conditions by onset date."

* url = "https://hl7-ie.github.io/hl7-ie-fhir-draft-ig/fhir/ie/core/SearchParameter/ie-core-condition-onset-date"
* version = "0.1.0"
* name = "IECoreConditionOnsetDate"
* status = #draft
* experimental = false
* date = "2025-01-01"
* publisher = "IE Core (Proof of Concept by Nithin Mohan T K)"
* description = "Search for Conditions by onset date."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* code = #onset-date
* base = #Condition
* type = #date
* expression = "Condition.onset.as(dateTime)"
* comparator[0] = #eq
* comparator[+] = #lt
* comparator[+] = #le
* comparator[+] = #gt
* comparator[+] = #ge
* comparator[+] = #sa
* comparator[+] = #eb


// ====================================================================
// Observation Search Parameters
// ====================================================================

Instance: ie-core-observation-patient
InstanceOf: SearchParameter
Usage: #definition
Title: "IE Core Observation Patient"
Description: "Search for Observations by patient reference. Servers SHALL support searching observations by patient."

* url = "https://hl7-ie.github.io/hl7-ie-fhir-draft-ig/fhir/ie/core/SearchParameter/ie-core-observation-patient"
* version = "0.1.0"
* name = "IECoreObservationPatient"
* status = #draft
* experimental = false
* date = "2025-01-01"
* publisher = "IE Core (Proof of Concept by Nithin Mohan T K)"
* description = "Search for Observations by patient reference."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* code = #patient
* base = #Observation
* type = #reference
* expression = "Observation.subject.where(resolve() is Patient)"
* target = #Patient


Instance: ie-core-observation-category
InstanceOf: SearchParameter
Usage: #definition
Title: "IE Core Observation Category"
Description: "Search for Observations by category (e.g. vital-signs, laboratory, social-history). Servers SHALL support searching observations by category."

* url = "https://hl7-ie.github.io/hl7-ie-fhir-draft-ig/fhir/ie/core/SearchParameter/ie-core-observation-category"
* version = "0.1.0"
* name = "IECoreObservationCategory"
* status = #draft
* experimental = false
* date = "2025-01-01"
* publisher = "IE Core (Proof of Concept by Nithin Mohan T K)"
* description = "Search for Observations by category (e.g. vital-signs, laboratory, social-history)."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* code = #category
* base = #Observation
* type = #token
* expression = "Observation.category"
* multipleOr = true
* multipleAnd = true


Instance: ie-core-observation-code
InstanceOf: SearchParameter
Usage: #definition
Title: "IE Core Observation Code"
Description: "Search for Observations by code (e.g. LOINC, SNOMED CT). Servers SHALL support searching observations by code."

* url = "https://hl7-ie.github.io/hl7-ie-fhir-draft-ig/fhir/ie/core/SearchParameter/ie-core-observation-code"
* version = "0.1.0"
* name = "IECoreObservationCode"
* status = #draft
* experimental = false
* date = "2025-01-01"
* publisher = "IE Core (Proof of Concept by Nithin Mohan T K)"
* description = "Search for Observations by code (e.g. LOINC, SNOMED CT)."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* code = #code
* base = #Observation
* type = #token
* expression = "Observation.code"
* multipleOr = true


Instance: ie-core-observation-date
InstanceOf: SearchParameter
Usage: #definition
Title: "IE Core Observation Date"
Description: "Search for Observations by effective date. Servers SHALL support searching observations by date."

* url = "https://hl7-ie.github.io/hl7-ie-fhir-draft-ig/fhir/ie/core/SearchParameter/ie-core-observation-date"
* version = "0.1.0"
* name = "IECoreObservationDate"
* status = #draft
* experimental = false
* date = "2025-01-01"
* publisher = "IE Core (Proof of Concept by Nithin Mohan T K)"
* description = "Search for Observations by effective date."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* code = #date
* base = #Observation
* type = #date
* expression = "Observation.effective"
* comparator[0] = #eq
* comparator[+] = #lt
* comparator[+] = #le
* comparator[+] = #gt
* comparator[+] = #ge
* comparator[+] = #sa
* comparator[+] = #eb


// ====================================================================
// MedicationRequest Search Parameters
// ====================================================================

Instance: ie-core-medicationrequest-patient
InstanceOf: SearchParameter
Usage: #definition
Title: "IE Core MedicationRequest Patient"
Description: "Search for MedicationRequests by patient reference. Servers SHALL support searching medication requests by patient."

* url = "https://hl7-ie.github.io/hl7-ie-fhir-draft-ig/fhir/ie/core/SearchParameter/ie-core-medicationrequest-patient"
* version = "0.1.0"
* name = "IECoreMedicationRequestPatient"
* status = #draft
* experimental = false
* date = "2025-01-01"
* publisher = "IE Core (Proof of Concept by Nithin Mohan T K)"
* description = "Search for MedicationRequests by patient reference."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* code = #patient
* base = #MedicationRequest
* type = #reference
* expression = "MedicationRequest.subject.where(resolve() is Patient)"
* target = #Patient


// ====================================================================
// DiagnosticReport Search Parameters
// ====================================================================

Instance: ie-core-diagnosticreport-patient
InstanceOf: SearchParameter
Usage: #definition
Title: "IE Core DiagnosticReport Patient"
Description: "Search for DiagnosticReports by patient reference. Servers SHALL support searching diagnostic reports by patient."

* url = "https://hl7-ie.github.io/hl7-ie-fhir-draft-ig/fhir/ie/core/SearchParameter/ie-core-diagnosticreport-patient"
* version = "0.1.0"
* name = "IECoreDiagnosticReportPatient"
* status = #draft
* experimental = false
* date = "2025-01-01"
* publisher = "IE Core (Proof of Concept by Nithin Mohan T K)"
* description = "Search for DiagnosticReports by patient reference."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* code = #patient
* base = #DiagnosticReport
* type = #reference
* expression = "DiagnosticReport.subject.where(resolve() is Patient)"
* target = #Patient


Instance: ie-core-diagnosticreport-category
InstanceOf: SearchParameter
Usage: #definition
Title: "IE Core DiagnosticReport Category"
Description: "Search for DiagnosticReports by category (e.g. LAB, RAD). Servers SHALL support searching diagnostic reports by category."

* url = "https://hl7-ie.github.io/hl7-ie-fhir-draft-ig/fhir/ie/core/SearchParameter/ie-core-diagnosticreport-category"
* version = "0.1.0"
* name = "IECoreDiagnosticReportCategory"
* status = #draft
* experimental = false
* date = "2025-01-01"
* publisher = "IE Core (Proof of Concept by Nithin Mohan T K)"
* description = "Search for DiagnosticReports by category (e.g. LAB, RAD)."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* code = #category
* base = #DiagnosticReport
* type = #token
* expression = "DiagnosticReport.category"
* multipleOr = true
* multipleAnd = true


// ====================================================================
// DocumentReference Search Parameters
// ====================================================================

Instance: ie-core-documentreference-patient
InstanceOf: SearchParameter
Usage: #definition
Title: "IE Core DocumentReference Patient"
Description: "Search for DocumentReferences by patient reference. Servers SHALL support searching document references by patient."

* url = "https://hl7-ie.github.io/hl7-ie-fhir-draft-ig/fhir/ie/core/SearchParameter/ie-core-documentreference-patient"
* version = "0.1.0"
* name = "IECoreDocumentReferencePatient"
* status = #draft
* experimental = false
* date = "2025-01-01"
* publisher = "IE Core (Proof of Concept by Nithin Mohan T K)"
* description = "Search for DocumentReferences by patient reference."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* code = #patient
* base = #DocumentReference
* type = #reference
* expression = "DocumentReference.subject.where(resolve() is Patient)"
* target = #Patient


Instance: ie-core-documentreference-type
InstanceOf: SearchParameter
Usage: #definition
Title: "IE Core DocumentReference Type"
Description: "Search for DocumentReferences by document type. Servers SHALL support searching document references by type."

* url = "https://hl7-ie.github.io/hl7-ie-fhir-draft-ig/fhir/ie/core/SearchParameter/ie-core-documentreference-type"
* version = "0.1.0"
* name = "IECoreDocumentReferenceType"
* status = #draft
* experimental = false
* date = "2025-01-01"
* publisher = "IE Core (Proof of Concept by Nithin Mohan T K)"
* description = "Search for DocumentReferences by document type."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* code = #type
* base = #DocumentReference
* type = #token
* expression = "DocumentReference.type"
* multipleOr = true


// ====================================================================
// AllergyIntolerance Search Parameters
// ====================================================================

Instance: ie-core-allergyintolerance-patient
InstanceOf: SearchParameter
Usage: #definition
Title: "IE Core AllergyIntolerance Patient"
Description: "Search for AllergyIntolerances by patient reference. Servers SHALL support searching allergy records by patient."

* url = "https://hl7-ie.github.io/hl7-ie-fhir-draft-ig/fhir/ie/core/SearchParameter/ie-core-allergyintolerance-patient"
* version = "0.1.0"
* name = "IECoreAllergyIntolerancePatient"
* status = #draft
* experimental = false
* date = "2025-01-01"
* publisher = "IE Core (Proof of Concept by Nithin Mohan T K)"
* description = "Search for AllergyIntolerances by patient reference."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* code = #patient
* base = #AllergyIntolerance
* type = #reference
* expression = "AllergyIntolerance.patient"
* target = #Patient
