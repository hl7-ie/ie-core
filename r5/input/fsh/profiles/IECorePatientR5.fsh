Profile: IECorePatientR5
Parent: $EUPatientCoreR5
Id: ie-core-patient-r5
Title: "IE Core Patient (R5)"
Description: "R5 edition of the IE Core Patient Profile. Mirrors the R4 edition with R5-specific adaptations."

* identifier MS
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier contains
    IHI 0..1 MS and
    GMS 0..1 MS and
    MRN 0..* MS

* identifier[IHI].system 1..1 MS
* identifier[IHI].system = $IHI
* identifier[IHI].type = $V2-0203#NI "National unique individual identifier"
* identifier[IHI].value 1..1 MS
* identifier[IHI] obeys ie-pat-r5-1

* identifier[GMS].system 1..1 MS
* identifier[GMS].system = $GMS
* identifier[GMS].type = $V2-0203#MC "Patient's Medicare number"
* identifier[GMS].value 1..1 MS
* identifier[GMS] obeys ie-pat-r5-2

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
Description: "IHI SHALL be exactly 18 digits"
Expression: "value.matches('^[0-9]{18}$')"
Severity: #error

Invariant: ie-pat-r5-2
Description: "GMS number SHALL be 7 digits followed by 1 alphabetic check character"
Expression: "value.matches('^[0-9]{7}[A-Za-z]$')"
Severity: #error
