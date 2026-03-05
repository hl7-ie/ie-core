Profile: IECoreQuestionnaireResponse
Parent: QuestionnaireResponse
Id: ie-core-questionnaireresponse
Title: "IE Core QuestionnaireResponse"
Description: "The IE Core QuestionnaireResponse profile sets minimum expectations for the QuestionnaireResponse resource to record, search, and fetch questionnaire responses associated with a patient, based on Irish requirements."

* ^url = "http://hl7.hse.ie/fhir/ie/core/StructureDefinition/ie-core-questionnaireresponse"
* ^version = "0.1.0"
* ^status = #draft

* questionnaire MS
* status 1..1 MS
* subject 1..1 MS
* subject only Reference(IECorePatient)
* authored MS
* author MS
* item MS
* item.linkId 1..1 MS
* item.answer MS
