Profile: IECoreGoal
Parent: Goal
Id: ie-core-goal
Title: "IE Core Goal"
Description: "The IE Core Goal profile sets minimum expectations for the Goal resource to record, search, and fetch goal data associated with a patient, based on Irish requirements."

* ^url = "http://hl7.hse.ie/fhir/ie/core/StructureDefinition/ie-core-goal"
* ^version = "0.1.0"
* ^status = #draft

* lifecycleStatus 1..1 MS
* description 1..1 MS
* description from $IEBase/ValueSet/ie-core-goal-codes (extensible)
* subject 1..1 MS
* subject only Reference(IECorePatient)
* target MS
* target.due[x] only date
* target.due[x] MS
