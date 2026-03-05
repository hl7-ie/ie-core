Profile: IECorePractitionerR5
Parent: $EUPractitionerCoreR5
Id: ie-core-practitioner-r5
Title: "IE Core Practitioner (R5)"
Description: "R5 edition of the IE Core Practitioner Profile."

* identifier MS
* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier contains HPI 0..1 MS

* identifier[HPI].system 1..1 MS
* identifier[HPI].system = $HPI
* identifier[HPI].type = $V2-0203#NPI "National provider identifier"
* identifier[HPI].value 1..1 MS

* name 1..* MS
* name.family 1..1 MS
* name.given MS

* telecom MS
* address MS

* qualification MS
* qualification.code MS
