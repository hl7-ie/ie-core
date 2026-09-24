Profile: IECoreImmunization
Parent: Immunization
Id: ie-core-immunization
Title: "IE Core Immunization"
Description: "The IE Core Immunization profile sets minimum expectations for the Immunization resource to record, search, and fetch immunization history associated with a patient, based on Irish requirements."

* ^url = "https://hl7-ie.github.io/ie-core/fhir/ie/core/StructureDefinition/ie-core-immunization"
* ^version = "0.1.0"
* ^status = #draft

* status 1..1 MS
* statusReason MS
* vaccineCode 1..1 MS
* vaccineCode from IECoreVaccines (extensible)
* patient 1..1 MS
* patient only Reference(IECorePatient)
* occurrence[x] 1..1 MS
* primarySource MS

// ── HIQA PS Section 16 Immunisation Information ────────────────────────
* vaccineCode ^comment = "HIQA PS 16.3.3 Administered product / 16.3.5 Vaccine code (Mandatory). R4 has one vaccineCode: use one coding for the vaccine type and one for the product where both are known."
* protocolApplied MS
* protocolApplied.targetDisease MS
* protocolApplied.targetDisease ^comment = "HIQA PS 16.3.4 Target disease (Required)."
* protocolApplied.doseNumber[x] MS
* protocolApplied.doseNumber[x] ^comment = "HIQA PS 16.3.6 Number of doses (Required)."
* performer MS
* performer.actor MS
* performer.actor ^comment = "HIQA PS 16.3.7 Immunisation administrator (Required)."
* location MS
* location ^comment = "HIQA PS 16.3.8 Administering centre (Required)."
