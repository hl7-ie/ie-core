// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Identifier Profiles                                        │
// │                                                                      │
// │  ADR-006: only identifiers with an authoritative source are kept.   │
// │  Removed (no HIQA or other authoritative source): HPI, IMN, CRN,    │
// │  and the GMS/DPS/LTI/HAA datatype profiles with their invented      │
// │  format rules. PCRS scheme numbers are carried as HIQA "other       │
// │  identifiers" (EP/PS 1.3.3) typed with IECorePCRSSchemeType.        │
// ╰──────────────────────────────────────────────────────────────────────╯

// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Individual Health Identifier (IHI)                         │
// ╰──────────────────────────────────────────────────────────────────────╯

Profile: IECoreIndividualHealthcareIdentifier
Parent: Identifier
Id: ie-core-individual-healthcare-identifier
Title: "IE Core Individual Health Identifier (IHI)"
Description: "The Individual Health Identifier (IHI) issued by the HSE. HIQA EP/PS 1.3.1 describe it as 'a unique 18 or 10-digit number'. The system URI is a placeholder pending an HSE-published URI (OI-003)."
* type 1..1 MS
* type = $V2-0203#NI "National unique individual identifier"
* system 1..1 MS
* system = $IHI (exactly)
* value 1..1 MS
* value ^short = "IHI number (18 or 10 digits)"
* obeys ie-pat-1
* extension contains
    IECoreIHIStatus named ihiStatus 0..1 MS and
    IECoreIHIRecordStatus named ihiRecordStatus 0..1 MS and
    IECoreIHIVerifiedDate named ihiVerifiedDate 0..1 MS
* extension[ihiStatus] ^short = "IHI status (active, deceased, retired)"
* extension[ihiRecordStatus] ^short = "IHI record status (verified, unverified, provisional)"
* extension[ihiVerifiedDate] ^short = "Date the IHI was last verified"

// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Medical Record Number (MRN)                                │
// ╰──────────────────────────────────────────────────────────────────────╯

Profile: IECoreMedicalRecordNumber
Parent: Identifier
Id: ie-core-medical-record-number
Title: "IE Core Medical Record Number (MRN)"
Description: "A local Medical Record Number assigned by a healthcare facility: an example of an 'other identifier used in health and social care' in HIQA EP/PS 1.3.3.1. The system is the issuing facility's own namespace (there is no national MRN system) and the assigner names the facility (HIQA 1.3.3.4)."
* type 1..1 MS
* type = $V2-0203#MR "Medical record number"
* system 1..1 MS
* value 1..1 MS
* value ^short = "Medical record number value"
* assigner MS
* assigner ^short = "Facility that issued the MRN (HIQA 1.3.3.4)"
