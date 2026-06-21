Profile: IECoreDiagnosticReportLab
Parent: DiagnosticReport
Id: ie-core-diagnosticreport-lab
Title: "IE Core DiagnosticReport for Laboratory Results"
Description: "The IE Core DiagnosticReport for Laboratory Results profile sets minimum expectations for the DiagnosticReport resource to record, search, and fetch laboratory diagnostic reports associated with a patient, based on Irish requirements."

* ^url = "https://hl7-ie.github.io/hl7-ie-fhir-draft-ig/fhir/ie/core/StructureDefinition/ie-core-diagnosticreport-lab"
* ^version = "0.1.0"
* ^status = #draft

* status 1..1 MS
* category 1..* MS
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains laboratory 1..1 MS
* category[laboratory] = $DiagReportCat#LAB "Laboratory"
* code 1..1 MS
* code from IECoreLaboratoryTestCodes (extensible)
* subject 1..1 MS
* subject only Reference(IECorePatient)
* encounter MS
* effective[x] MS
* issued MS
* performer MS
* result MS
* result only Reference(IECoreLaboratoryResultObservation)


Profile: IECoreDiagnosticReportNote
Parent: DiagnosticReport
Id: ie-core-diagnosticreport-note
Title: "IE Core DiagnosticReport for Report and Note Exchange"
Description: "The IE Core DiagnosticReport for Report and Note Exchange profile sets minimum expectations for the DiagnosticReport resource to record, search, and fetch diagnostic reports and notes for a patient, based on Irish requirements."

* ^url = "https://hl7-ie.github.io/hl7-ie-fhir-draft-ig/fhir/ie/core/StructureDefinition/ie-core-diagnosticreport-note"
* ^version = "0.1.0"
* ^status = #draft

* status 1..1 MS
* category 1..* MS
* category from IECoreDiagnosticReportCategory (extensible)
* code 1..1 MS
* code from IECoreDiagnosticReportReportAndNoteCodes (extensible)
* subject 1..1 MS
* subject only Reference(IECorePatient)
* encounter MS
* effective[x] MS
* issued MS
* performer MS
* presentedForm MS
