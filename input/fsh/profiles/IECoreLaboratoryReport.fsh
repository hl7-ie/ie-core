// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Laboratory Report Profiles                                │
// │  Aligned with: HL7 Europe Laboratory Report IG, Xt-EHR             │
// ╰──────────────────────────────────────────────────────────────────────╯

Profile: IECoreLaboratoryReport
Parent: DiagnosticReport
Id: ie-core-laboratory-report
Title: "IE Core Laboratory Report"
Description: "Profile for laboratory reports in the Irish healthcare system, aligned with the HL7 Europe Laboratory Report IG (hl7.fhir.eu.laboratory) and the Xt-EHR EHDSLaboratoryReport logical model. Supports both national laboratory workflows and cross-border laboratory result exchange via MyHealth@EU."

* ^status = #draft

* identifier MS
* identifier ^short = "Report identifier (lab accession number)"

* basedOn MS
* basedOn only Reference(IECoreServiceRequest)
* basedOn ^short = "Reference to the order that initiated this report"

* status 1..1 MS
* category 1..* MS
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains laboratory 1..1 MS
* category[laboratory] = http://terminology.hl7.org/CodeSystem/v2-0074#LAB

* code 1..1 MS
* code ^short = "Report type (LOINC)"

* subject 1..1 MS
* subject only Reference(IECorePatient)

* encounter MS

* effective[x] MS
* effective[x] ^short = "Diagnostically relevant time (specimen collection)"

* issued MS
* issued ^short = "Date/time the report was issued"

* performer MS
* performer only Reference(IECorePractitioner or IECorePractitionerRole or IECoreOrganization)
* performer ^short = "Laboratory / pathologist responsible for the report"

* resultsInterpreter MS
* resultsInterpreter ^short = "Clinician who interpreted the results"

* specimen MS
* specimen only Reference(IECoreSpecimen)

* result MS
* result only Reference(IECoreLaboratoryResultObservation)
* result ^short = "Individual test results within this report"

* conclusion MS
* conclusion ^short = "Clinical conclusion / interpretation"

* conclusionCode MS
