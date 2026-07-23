// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core FHIR TestScript Resources                                │
// │  Pattern: Denmark MedCom / TouchStone                             │
// ╰──────────────────────────────────────────────────────────────────────╯

Instance: ie-core-testscript-patient-read
InstanceOf: TestScript
Usage: #definition
Title: "IE Core TestScript: Patient Read"
Description: "Verifies that a FHIR server can return a Patient resource conforming to the IE Core Patient profile."

* url = "https://hl7-ie.github.io/ie-core/fhir/ie/core/TestScript/ie-core-testscript-patient-read"
* name = "IECoreTestScriptPatientRead"
* status = #draft
* date = "2025-01-01"
* publisher = "IE Core (Proof of Concept by Nithin Mohan T K)"

* fixture[0].id = "patient-fixture"
* fixture[=].autocreate = false
* fixture[=].autodelete = false
* fixture[=].resource = Reference(Patient/ie-core-patient-example)

* test[0].name = "Patient Read Test"
* test[=].description = "Read a Patient and verify it conforms to the IE Core Patient profile."
* test[=].action[0].operation.type = http://terminology.hl7.org/CodeSystem/testscript-operation-codes#read
* test[=].action[=].operation.resource = #Patient
* test[=].action[=].operation.description = "Read the Patient resource"
* test[=].action[=].operation.accept = #json
* test[=].action[=].operation.encodeRequestUrl = true
* test[=].action[=].operation.params = "/ie-core-patient-example"

* test[=].action[+].assert.description = "Confirm the response is HTTP 200 OK"
* test[=].action[=].assert.response = #okay
* test[=].action[=].assert.warningOnly = false

* test[=].action[+].assert.description = "Confirm the returned resource is a Patient"
* test[=].action[=].assert.resource = #Patient
* test[=].action[=].assert.warningOnly = false

* test[=].action[+].assert.description = "Confirm Patient has the IE Core Patient profile"
* test[=].action[=].assert.expression = "meta.profile.where($this = 'https://hl7-ie.github.io/ie-core/fhir/ie/core/StructureDefinition/ie-core-patient').exists()"
* test[=].action[=].assert.warningOnly = false

* test[=].action[+].assert.description = "Confirm Patient has at least one name"
* test[=].action[=].assert.expression = "name.count() >= 1"
* test[=].action[=].assert.warningOnly = false

* test[=].action[+].assert.description = "Confirm Patient has a gender"
* test[=].action[=].assert.expression = "gender.exists()"
* test[=].action[=].assert.warningOnly = false


Instance: ie-core-testscript-patient-search
InstanceOf: TestScript
Usage: #definition
Title: "IE Core TestScript: Patient Search"
Description: "Verifies that a FHIR server supports searching for Patient resources by name, identifier, and birthdate."

* url = "https://hl7-ie.github.io/ie-core/fhir/ie/core/TestScript/ie-core-testscript-patient-search"
* name = "IECoreTestScriptPatientSearch"
* status = #draft
* date = "2025-01-01"
* publisher = "IE Core (Proof of Concept by Nithin Mohan T K)"

* test[0].name = "Patient Search by Name"
* test[=].description = "Search for a Patient by family name."
* test[=].action[0].operation.type = http://terminology.hl7.org/CodeSystem/testscript-operation-codes#search
* test[=].action[=].operation.resource = #Patient
* test[=].action[=].operation.description = "Search for Patients by family name"
* test[=].action[=].operation.accept = #json
* test[=].action[=].operation.encodeRequestUrl = true
* test[=].action[=].operation.params = "?family=Murphy"

* test[=].action[+].assert.description = "Confirm the response is HTTP 200 OK"
* test[=].action[=].assert.response = #okay
* test[=].action[=].assert.warningOnly = false

* test[=].action[+].assert.description = "Confirm the response is a Bundle"
* test[=].action[=].assert.resource = #Bundle
* test[=].action[=].assert.warningOnly = false

* test[+].name = "Patient Search by IHI"
* test[=].description = "Search for a Patient by IHI (Individual Health Identifier)."
* test[=].action[0].operation.type = http://terminology.hl7.org/CodeSystem/testscript-operation-codes#search
* test[=].action[=].operation.resource = #Patient
* test[=].action[=].operation.description = "Search for Patients by IHI"
* test[=].action[=].operation.accept = #json
* test[=].action[=].operation.encodeRequestUrl = true
* test[=].action[=].operation.params = "?identifier=https://hl7-ie.github.io/ie-core/fhir/ie/core/sid/ihi|210000000012345678"

* test[=].action[+].assert.description = "Confirm the response is HTTP 200 OK"
* test[=].action[=].assert.response = #okay
* test[=].action[=].assert.warningOnly = false

* test[=].action[+].assert.description = "Confirm the response is a Bundle"
* test[=].action[=].assert.resource = #Bundle
* test[=].action[=].assert.warningOnly = false

* test[+].name = "Patient Search by Birthdate"
* test[=].description = "Search for a Patient by date of birth."
* test[=].action[0].operation.type = http://terminology.hl7.org/CodeSystem/testscript-operation-codes#search
* test[=].action[=].operation.resource = #Patient
* test[=].action[=].operation.description = "Search for Patients by birthdate"
* test[=].action[=].operation.accept = #json
* test[=].action[=].operation.encodeRequestUrl = true
* test[=].action[=].operation.params = "?birthdate=1978-05-15"

* test[=].action[+].assert.description = "Confirm the response is HTTP 200 OK"
* test[=].action[=].assert.response = #okay
* test[=].action[=].assert.warningOnly = false


Instance: ie-core-testscript-encounter-read
InstanceOf: TestScript
Usage: #definition
Title: "IE Core TestScript: Encounter Read"
Description: "Verifies that a FHIR server can return an Encounter resource conforming to the IE Core Encounter profile."

* url = "https://hl7-ie.github.io/ie-core/fhir/ie/core/TestScript/ie-core-testscript-encounter-read"
* name = "IECoreTestScriptEncounterRead"
* status = #draft
* date = "2025-01-01"
* publisher = "IE Core (Proof of Concept by Nithin Mohan T K)"

* test[0].name = "Encounter Read Test"
* test[=].description = "Read an Encounter and verify it conforms to the IE Core Encounter profile."
* test[=].action[0].operation.type = http://terminology.hl7.org/CodeSystem/testscript-operation-codes#read
* test[=].action[=].operation.resource = #Encounter
* test[=].action[=].operation.description = "Read the Encounter resource"
* test[=].action[=].operation.accept = #json
* test[=].action[=].operation.encodeRequestUrl = true
* test[=].action[=].operation.params = "/ie-core-encounter-example"

* test[=].action[+].assert.description = "Confirm the response is HTTP 200 OK"
* test[=].action[=].assert.response = #okay
* test[=].action[=].assert.warningOnly = false

* test[=].action[+].assert.description = "Confirm the returned resource is an Encounter"
* test[=].action[=].assert.resource = #Encounter
* test[=].action[=].assert.warningOnly = false

* test[=].action[+].assert.description = "Confirm Encounter has a status"
* test[=].action[=].assert.expression = "status.exists()"
* test[=].action[=].assert.warningOnly = false

* test[=].action[+].assert.description = "Confirm Encounter has a class"
* test[=].action[=].assert.expression = "class.exists()"
* test[=].action[=].assert.warningOnly = false

* test[=].action[+].assert.description = "Confirm Encounter has a subject reference"
* test[=].action[=].assert.expression = "subject.exists()"
* test[=].action[=].assert.warningOnly = false
