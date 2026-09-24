Profile: IECoreProcedure
Parent: Procedure
Id: ie-core-procedure
Title: "IE Core Procedure"
Description: "The IE Core Procedure profile sets minimum expectations for the Procedure resource to record, search, and fetch procedure data associated with a patient, based on Irish requirements."

* ^url = "https://hl7-ie.github.io/ie-core/fhir/ie/core/StructureDefinition/ie-core-procedure"
* ^version = "0.1.0"
* ^status = #draft

* status 1..1 MS
* code 1..1 MS
* code from IECoreProcedureCode (extensible)
* subject 1..1 MS
* subject only Reference(IECorePatient)
* performed[x] MS
* performed[x] ^comment = "HIQA PS 9.3.1 Date of procedure (Required 0..1). Relaxed from 1..1 so that a procedure with an unknown date can be recorded (OI-012)."
* encounter MS

// ── HIQA PS Section 9 Procedures, Operations and Treatments ────────────
* code ^comment = "HIQA PS 9.3.2 Procedure name (Mandatory)."
* status ^comment = "HIQA PS 9.3.4 Status (Mandatory)."
* reasonCode MS
* reasonCode ^comment = "HIQA PS 9.3.3 Reason (Required)."
* bodySite MS
* bodySite ^comment = "HIQA PS 9.3.5 Anatomical location (Required): location and laterality post-coordinated in SNOMED CT."
* complication MS
* complication ^comment = "HIQA PS 9.3.7 Complications (Required)."
* outcome ^comment = "HIQA PS 9.3.6 Outcome (Optional)."
* focalDevice ^comment = "HIQA PS 9.3.8 Device use (Optional)."
