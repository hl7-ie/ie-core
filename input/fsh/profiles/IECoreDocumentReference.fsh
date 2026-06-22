Profile: IECoreDocumentReference
Parent: DocumentReference
Id: ie-core-documentreference
Title: "IE Core DocumentReference"
Description: "The IE Core DocumentReference profile sets minimum expectations for the DocumentReference resource to record, search, and fetch documents associated with a patient, based on Irish requirements."

* ^url = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-documentreference"
* ^version = "0.1.0"
* ^status = #draft

* identifier MS
* status 1..1 MS
* type MS
* type from IECoreDocumentReferenceType (extensible)
* category MS
* category from IECoreDocumentReferenceCategory (extensible)
* subject MS
* subject only Reference(IECorePatient)
* date MS
* author MS
* content MS
* content.attachment MS
* context MS
* context.encounter MS
* context.period MS


Profile: IECoreADIDocumentReference
Parent: IECoreDocumentReference
Id: ie-core-adi-documentreference
Title: "IE Core ADI DocumentReference"
Description: "The IE Core ADI (Advance Directive Interoperability) DocumentReference profile sets minimum expectations for the DocumentReference resource to record, search, and fetch advance directive documents associated with a patient, based on Irish requirements."

* ^url = "https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core/StructureDefinition/ie-core-adi-documentreference"
* ^version = "0.1.0"
* ^status = #draft

* type 1..1 MS
* category 1..* MS
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains adi 1..1 MS
* category[adi] = $LOINC#42348-3 "Advance directives"
* subject 1..1 MS
* content.attachment.contentType 1..1 MS
* content.attachment.url 1..1 MS
