Profile: IECoreImplantableDevice
Parent: Device
Id: ie-core-implantable-device
Title: "IE Core Implantable Device"
Description: "The IE Core Implantable Device profile sets minimum expectations for the Device resource to record, search, and fetch UDI and implantable device information associated with a patient, based on Irish requirements."

* ^url = "https://hl7-ie.github.io/ie-core/fhir/ie/core/StructureDefinition/ie-core-implantable-device"
* ^version = "0.1.0"
* ^status = #draft

* udiCarrier MS
* udiCarrier.deviceIdentifier MS
* udiCarrier.carrierAIDC MS
* udiCarrier.carrierHRF MS
* distinctIdentifier MS
* manufactureDate MS
* expirationDate MS
* lotNumber MS
* serialNumber MS
* type 1..1 MS
* patient MS
* patient only Reference(IECorePatient)
