// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core CapabilityStatements                                      │
// ╰──────────────────────────────────────────────────────────────────────╯

// ====================================================================
// 1. IE Core Server CapabilityStatement
// ====================================================================

Instance: ie-core-server
InstanceOf: CapabilityStatement
Usage: #definition
Title: "IE Core Server CapabilityStatement"
Description: "This CapabilityStatement describes the expected capabilities of an IE Core FHIR Server which is responsible for providing responses to the queries submitted by IE Core FHIR Clients. The complete list of FHIR profiles, RESTful operations, and search parameters supported by IE Core FHIR Servers are defined in this CapabilityStatement."

* url = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/CapabilityStatement/ie-core-server"
* version = "0.1.0"
* name = "IECoreServerCapabilityStatement"
* title = "IE Core Server CapabilityStatement"
* status = #draft
* experimental = false
* date = "2025-01-01"
* publisher = "IE Core (Proof of Concept by Nithin Mohan T K)"
* description = "This CapabilityStatement describes the expected capabilities of a system that conforms to the IE Core Implementation Guide as a Server. It lists the RESTful interactions, supported profiles, and search parameters for each resource type."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* kind = #instance
* implementation.description = "IE Core FHIR Server"
* implementation.url = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core"
* fhirVersion = #4.0.1
* format[0] = #json
* format[+] = #xml

* rest.mode = #server
* rest.documentation = "The IE Core Server **SHALL** support the Patient resource and **SHOULD** support all other resources listed in this CapabilityStatement. The server **SHALL** implement REST behaviour according to the FHIR specification."

// ── Patient ──────────────────────────────────────────────────────────
* rest.resource[+].type = #Patient
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-patient"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].searchParam[0].name = "name"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Patient-name"
* rest.resource[=].searchParam[+].name = "family"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/individual-family"
* rest.resource[=].searchParam[+].name = "given"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/individual-given"
* rest.resource[=].searchParam[+].name = "gender"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/individual-gender"
* rest.resource[=].searchParam[+].name = "birthdate"
* rest.resource[=].searchParam[=].type = #date
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/individual-birthdate"
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Patient-identifier"
* rest.resource[=].searchParam[+].name = "_id"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Resource-id"

// ── Practitioner ─────────────────────────────────────────────────────
* rest.resource[+].type = #Practitioner
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-practitioner"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].searchParam[0].name = "name"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Practitioner-name"
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Practitioner-identifier"

// ── PractitionerRole ─────────────────────────────────────────────────
* rest.resource[+].type = #PractitionerRole
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-practitionerrole"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].searchParam[0].name = "practitioner"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/PractitionerRole-practitioner"
* rest.resource[=].searchParam[+].name = "organization"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/PractitionerRole-organization"
* rest.resource[=].searchParam[+].name = "specialty"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/PractitionerRole-specialty"

// ── Organization ─────────────────────────────────────────────────────
* rest.resource[+].type = #Organization
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-organization"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].searchParam[0].name = "name"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Organization-name"
* rest.resource[=].searchParam[+].name = "identifier"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Organization-identifier"
* rest.resource[=].searchParam[+].name = "address"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Organization-address"

// ── Location ─────────────────────────────────────────────────────────
* rest.resource[+].type = #Location
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-location"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].searchParam[0].name = "name"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Location-name"
* rest.resource[=].searchParam[+].name = "address"
* rest.resource[=].searchParam[=].type = #string
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Location-address"

// ── Encounter ────────────────────────────────────────────────────────
* rest.resource[+].type = #Encounter
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-encounter"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].searchParam[0].name = "patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[+].name = "date"
* rest.resource[=].searchParam[=].type = #date
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-date"
* rest.resource[=].searchParam[+].name = "type"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-type"
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Encounter-status"
* rest.resource[=].searchParam[+].name = "class"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Encounter-class"

// ── Condition ────────────────────────────────────────────────────────
* rest.resource[+].type = #Condition
* rest.resource[=].supportedProfile[0] = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-condition-encounter-diagnosis"
* rest.resource[=].supportedProfile[+] = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-condition-problems-health-concerns"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].searchParam[0].name = "patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[+].name = "code"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-code"
* rest.resource[=].searchParam[+].name = "onset-date"
* rest.resource[=].searchParam[=].type = #date
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Condition-onset-date"
* rest.resource[=].searchParam[+].name = "clinical-status"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Condition-clinical-status"
* rest.resource[=].searchParam[+].name = "category"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Condition-category"

// ── Procedure ────────────────────────────────────────────────────────
* rest.resource[+].type = #Procedure
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-procedure"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].searchParam[0].name = "patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[+].name = "date"
* rest.resource[=].searchParam[=].type = #date
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-date"
* rest.resource[=].searchParam[+].name = "code"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-code"
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Procedure-status"

// ── Observation ──────────────────────────────────────────────────────
* rest.resource[+].type = #Observation
* rest.resource[=].supportedProfile[0] = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-observation-clinical-result"
* rest.resource[=].supportedProfile[+] = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-laboratory-result-observation"
* rest.resource[=].supportedProfile[+] = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-simple-observation"
* rest.resource[=].supportedProfile[+] = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-vital-signs"
* rest.resource[=].supportedProfile[+] = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-blood-pressure"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].searchParam[0].name = "patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[+].name = "category"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Observation-category"
* rest.resource[=].searchParam[+].name = "code"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-code"
* rest.resource[=].searchParam[+].name = "date"
* rest.resource[=].searchParam[=].type = #date
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-date"
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Observation-status"

// ── DiagnosticReport ─────────────────────────────────────────────────
* rest.resource[+].type = #DiagnosticReport
* rest.resource[=].supportedProfile[0] = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-diagnosticreport-lab"
* rest.resource[=].supportedProfile[+] = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-diagnosticreport-note"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].searchParam[0].name = "patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[+].name = "category"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DiagnosticReport-category"
* rest.resource[=].searchParam[+].name = "code"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-code"
* rest.resource[=].searchParam[+].name = "date"
* rest.resource[=].searchParam[=].type = #date
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-date"
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DiagnosticReport-status"

// ── DocumentReference ────────────────────────────────────────────────
* rest.resource[+].type = #DocumentReference
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-documentreference"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].searchParam[0].name = "patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[+].name = "type"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-type"
* rest.resource[=].searchParam[+].name = "category"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/DocumentReference-category"
* rest.resource[=].searchParam[+].name = "date"
* rest.resource[=].searchParam[=].type = #date
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-date"

// ── MedicationRequest ────────────────────────────────────────────────
* rest.resource[+].type = #MedicationRequest
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-medicationrequest"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].searchParam[0].name = "patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/medications-status"
* rest.resource[=].searchParam[+].name = "intent"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/MedicationRequest-intent"
* rest.resource[=].searchParam[+].name = "authoredon"
* rest.resource[=].searchParam[=].type = #date
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/MedicationRequest-authoredon"

// ── MedicationDispense ───────────────────────────────────────────────
* rest.resource[+].type = #MedicationDispense
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-medicationdispense"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].searchParam[0].name = "patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/medications-status"

// ── Medication ───────────────────────────────────────────────────────
* rest.resource[+].type = #Medication
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-medication"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].searchParam[0].name = "code"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-code"

// ── Immunization ─────────────────────────────────────────────────────
* rest.resource[+].type = #Immunization
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-immunization"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].searchParam[0].name = "patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[+].name = "date"
* rest.resource[=].searchParam[=].type = #date
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-date"
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Immunization-status"

// ── AllergyIntolerance ───────────────────────────────────────────────
* rest.resource[+].type = #AllergyIntolerance
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-allergyintolerance"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].searchParam[0].name = "patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[+].name = "clinical-status"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/AllergyIntolerance-clinical-status"

// ── CarePlan ─────────────────────────────────────────────────────────
* rest.resource[+].type = #CarePlan
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-careplan"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].searchParam[0].name = "patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[+].name = "category"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/CarePlan-category"
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/CarePlan-status"
* rest.resource[=].searchParam[+].name = "date"
* rest.resource[=].searchParam[=].type = #date
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-date"

// ── CareTeam ─────────────────────────────────────────────────────────
* rest.resource[+].type = #CareTeam
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-careteam"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].searchParam[0].name = "patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/CareTeam-status"

// ── Goal ─────────────────────────────────────────────────────────────
* rest.resource[+].type = #Goal
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-goal"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].searchParam[0].name = "patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[+].name = "lifecycle-status"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Goal-lifecycle-status"

// ── ServiceRequest ───────────────────────────────────────────────────
* rest.resource[+].type = #ServiceRequest
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-servicerequest"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].searchParam[0].name = "patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/ServiceRequest-status"
* rest.resource[=].searchParam[+].name = "category"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/ServiceRequest-category"

// ── Coverage ─────────────────────────────────────────────────────────
* rest.resource[+].type = #Coverage
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-coverage"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].searchParam[0].name = "patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Coverage-patient"
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Coverage-status"

// ── Device ───────────────────────────────────────────────────────────
* rest.resource[+].type = #Device
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-implantable-device"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].searchParam[0].name = "patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Device-patient"
* rest.resource[=].searchParam[+].name = "type"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Device-type"

// ── Provenance ───────────────────────────────────────────────────────
* rest.resource[+].type = #Provenance
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-provenance"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].searchParam[0].name = "target"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Provenance-target"
* rest.resource[=].searchParam[+].name = "patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Provenance-patient"

// ── RelatedPerson ────────────────────────────────────────────────────
* rest.resource[+].type = #RelatedPerson
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-relatedperson"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].searchParam[0].name = "patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/clinical-patient"

// ── QuestionnaireResponse ────────────────────────────────────────────
* rest.resource[+].type = #QuestionnaireResponse
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-questionnaireresponse"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].searchParam[0].name = "patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/QuestionnaireResponse-patient"
* rest.resource[=].searchParam[+].name = "questionnaire"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/QuestionnaireResponse-questionnaire"
* rest.resource[=].searchParam[+].name = "status"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/QuestionnaireResponse-status"

// ── Specimen ─────────────────────────────────────────────────────────
* rest.resource[+].type = #Specimen
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-specimen"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type
* rest.resource[=].interaction[+].code = #create
* rest.resource[=].interaction[+].code = #update
* rest.resource[=].searchParam[0].name = "patient"
* rest.resource[=].searchParam[=].type = #reference
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Specimen-patient"
* rest.resource[=].searchParam[+].name = "type"
* rest.resource[=].searchParam[=].type = #token
* rest.resource[=].searchParam[=].definition = "http://hl7.org/fhir/SearchParameter/Specimen-type"


// ====================================================================
// 2. IE Core Client CapabilityStatement
// ====================================================================

Instance: ie-core-client
InstanceOf: CapabilityStatement
Usage: #definition
Title: "IE Core Client CapabilityStatement"
Description: "This CapabilityStatement describes the expected capabilities of an IE Core FHIR Client which is responsible for creating and initiating the queries for information. The complete list of FHIR profiles, RESTful operations, and search parameters supported by IE Core FHIR Clients are defined in this CapabilityStatement."

* url = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/CapabilityStatement/ie-core-client"
* version = "0.1.0"
* name = "IECoreClientCapabilityStatement"
* title = "IE Core Client CapabilityStatement"
* status = #draft
* experimental = false
* date = "2025-01-01"
* publisher = "IE Core (Proof of Concept by Nithin Mohan T K)"
* description = "This CapabilityStatement describes the expected capabilities of a system that conforms to the IE Core Implementation Guide as a Client. It lists the RESTful interactions and supported profiles for each resource type that a client application can use to query an IE Core Server."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* kind = #instance
* implementation.description = "IE Core FHIR Client"
* implementation.url = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core"
* fhirVersion = #4.0.1
* format[0] = #json
* format[+] = #xml

* rest.mode = #client
* rest.documentation = "The IE Core Client **SHALL** be capable of querying for Patient resources and **SHOULD** be capable of querying for all resources listed in this CapabilityStatement."

// ── Patient ──────────────────────────────────────────────────────────
* rest.resource[+].type = #Patient
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-patient"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type

// ── Practitioner ─────────────────────────────────────────────────────
* rest.resource[+].type = #Practitioner
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-practitioner"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type

// ── PractitionerRole ─────────────────────────────────────────────────
* rest.resource[+].type = #PractitionerRole
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-practitionerrole"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type

// ── Organization ─────────────────────────────────────────────────────
* rest.resource[+].type = #Organization
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-organization"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type

// ── Location ─────────────────────────────────────────────────────────
* rest.resource[+].type = #Location
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-location"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type

// ── Encounter ────────────────────────────────────────────────────────
* rest.resource[+].type = #Encounter
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-encounter"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type

// ── Condition ────────────────────────────────────────────────────────
* rest.resource[+].type = #Condition
* rest.resource[=].supportedProfile[0] = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-condition-encounter-diagnosis"
* rest.resource[=].supportedProfile[+] = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-condition-problems-health-concerns"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type

// ── Procedure ────────────────────────────────────────────────────────
* rest.resource[+].type = #Procedure
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-procedure"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type

// ── Observation ──────────────────────────────────────────────────────
* rest.resource[+].type = #Observation
* rest.resource[=].supportedProfile[0] = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-observation-clinical-result"
* rest.resource[=].supportedProfile[+] = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-laboratory-result-observation"
* rest.resource[=].supportedProfile[+] = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-simple-observation"
* rest.resource[=].supportedProfile[+] = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-vital-signs"
* rest.resource[=].supportedProfile[+] = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-blood-pressure"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type

// ── DiagnosticReport ─────────────────────────────────────────────────
* rest.resource[+].type = #DiagnosticReport
* rest.resource[=].supportedProfile[0] = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-diagnosticreport-lab"
* rest.resource[=].supportedProfile[+] = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-diagnosticreport-note"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type

// ── DocumentReference ────────────────────────────────────────────────
* rest.resource[+].type = #DocumentReference
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-documentreference"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type

// ── MedicationRequest ────────────────────────────────────────────────
* rest.resource[+].type = #MedicationRequest
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-medicationrequest"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type

// ── MedicationDispense ───────────────────────────────────────────────
* rest.resource[+].type = #MedicationDispense
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-medicationdispense"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type

// ── Medication ───────────────────────────────────────────────────────
* rest.resource[+].type = #Medication
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-medication"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type

// ── Immunization ─────────────────────────────────────────────────────
* rest.resource[+].type = #Immunization
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-immunization"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type

// ── AllergyIntolerance ───────────────────────────────────────────────
* rest.resource[+].type = #AllergyIntolerance
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-allergyintolerance"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type

// ── CarePlan ─────────────────────────────────────────────────────────
* rest.resource[+].type = #CarePlan
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-careplan"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type

// ── CareTeam ─────────────────────────────────────────────────────────
* rest.resource[+].type = #CareTeam
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-careteam"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type

// ── Goal ─────────────────────────────────────────────────────────────
* rest.resource[+].type = #Goal
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-goal"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type

// ── ServiceRequest ───────────────────────────────────────────────────
* rest.resource[+].type = #ServiceRequest
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-servicerequest"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type

// ── Coverage ─────────────────────────────────────────────────────────
* rest.resource[+].type = #Coverage
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-coverage"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type

// ── Device ───────────────────────────────────────────────────────────
* rest.resource[+].type = #Device
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-implantable-device"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type

// ── Provenance ───────────────────────────────────────────────────────
* rest.resource[+].type = #Provenance
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-provenance"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type

// ── RelatedPerson ────────────────────────────────────────────────────
* rest.resource[+].type = #RelatedPerson
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-relatedperson"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type

// ── QuestionnaireResponse ────────────────────────────────────────────
* rest.resource[+].type = #QuestionnaireResponse
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-questionnaireresponse"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type

// ── Specimen ─────────────────────────────────────────────────────────
* rest.resource[+].type = #Specimen
* rest.resource[=].supportedProfile = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-specimen"
* rest.resource[=].interaction[0].code = #read
* rest.resource[=].interaction[+].code = #search-type
