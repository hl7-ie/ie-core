Profile: IECoreProvenance
Parent: Provenance
Id: ie-core-provenance
Title: "IE Core Provenance"
Description: "The IE Core Provenance profile sets minimum expectations for the Provenance resource to record, search, and fetch provenance information associated with a record, based on Irish requirements."

* ^url = "http://hl7.hse.ie/fhir/ie/core/StructureDefinition/ie-core-provenance"
* ^version = "0.1.0"
* ^status = #draft

* target 1..* MS
* recorded 1..1 MS
* agent 1..* MS
* agent.type MS
* agent.type from $IEBase/ValueSet/ie-core-provenance-participant-type (extensible)
* agent.who MS
* agent.who only Reference(IECorePractitioner or IECorePractitionerRole or IECoreOrganization or IECorePatient or Device or RelatedPerson)
* agent.onBehalfOf MS
* agent.onBehalfOf only Reference(IECoreOrganization)
