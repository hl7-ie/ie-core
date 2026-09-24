Profile: IECorePatientR5
Parent: $EUPatientCoreR5
Id: ie-core-patient-r5
Title: "IE Core Patient (R5)"
Description: "R5 edition of the IE Core Patient Profile (FROZEN, ADR-005: not aligned with the HIQA 2026 drafts; use the R4 IG). Correctness fixes only: IHI 18 or 10 digits; the unsourced GMS slice is removed (ADR-006)."

* identifier MS
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier contains
    IHI 0..1 MS and
    MRN 0..* MS

* identifier[IHI].system 1..1 MS
* identifier[IHI].system = $IHI
* identifier[IHI].type = $V2-0203#NI "National unique individual identifier"
* identifier[IHI].value 1..1 MS
* identifier[IHI] obeys ie-pat-r5-1

* identifier[MRN].system 1..1 MS
* identifier[MRN].system = $MRN
* identifier[MRN].type = $V2-0203#MR "Medical record number"
* identifier[MRN].value 1..1 MS

* name 1..* MS
* name.family MS
* name.given MS
* gender 1..1 MS
* birthDate MS

* address MS
* address.line MS
* address.city MS
* address.state MS
* address.postalCode MS
* address.country MS

* telecom MS
* telecom.system 1..1 MS
* telecom.value 1..1 MS
* telecom.use MS

* communication MS
* communication.language MS

Invariant: ie-pat-r5-1
Description: "IHI SHALL be 18 or 10 digits (HIQA EP/PS 1.3.1: 'a unique 18 or 10-digit number')"
Expression: "value.matches('^([0-9]{18}|[0-9]{10})$')"
Severity: #error

