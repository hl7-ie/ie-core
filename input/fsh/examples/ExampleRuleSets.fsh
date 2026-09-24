// Shared rules for IE Core examples

// HIQA EP 1.4.3 / PS 1.4.4 Sex (assigned at birth), recorded with individual-recordedSexOrGender
RuleSet: SexAssignedAtBirth(code, display)
* extension[sexAssignedAtBirth].extension[value].valueCodeableConcept = http://hl7.org/fhir/administrative-gender#{code} "{display}"
* extension[sexAssignedAtBirth].extension[type].valueCodeableConcept = $LOINC#76689-9 "Sex assigned at birth"

// HIQA EP/PS 1.3.3 "other identifier used in health and social care": a PCRS scheme number.
// No format is enforced (HIQA gives none; ADR-006).
RuleSet: PCRSIdentifier(system, schemeCode, schemeDisplay, value)
* identifier[+].system = {system}
* identifier[=].type = IECorePCRSSchemeType#{schemeCode} "{schemeDisplay}"
* identifier[=].value = "{value}"
* identifier[=].assigner.display = "HSE"
