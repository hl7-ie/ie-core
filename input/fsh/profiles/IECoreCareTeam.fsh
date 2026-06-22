Profile: IECoreCareTeam
Parent: CareTeam
Id: ie-core-careteam
Title: "IE Core CareTeam"
Description: "The IE Core CareTeam profile sets minimum expectations for the CareTeam resource to record, search, and fetch care team data associated with a patient, based on Irish requirements."

* ^url = "https://hl7-ie.github.io/ie-core-fhir-ig-draft/fhir/ie/core/StructureDefinition/ie-core-careteam"
* ^version = "0.1.0"
* ^status = #draft

* status MS
* subject MS
* subject only Reference(IECorePatient)
* participant MS
* participant.role MS
* participant.role from IECoreCareTeamMemberFunction (extensible)
* participant.member MS
* participant.member only Reference(IECorePractitioner or IECorePractitionerRole or IECoreOrganization or IECoreCareTeam or IECorePatient or IECoreRelatedPerson)
