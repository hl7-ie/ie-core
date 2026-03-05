// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Identifier Profiles                                        │
// ╰──────────────────────────────────────────────────────────────────────╯

// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Individual Healthcare Identifier (IHI)                     │
// ╰──────────────────────────────────────────────────────────────────────╯

Profile: IECoreIndividualHealthcareIdentifier
Parent: Identifier
Id: ie-core-individual-healthcare-identifier
Title: "IE Core Individual Healthcare Identifier (IHI)"
Description: "A profile on the Identifier datatype for the Individual Health Identifier (IHI) issued by the HSE. The IHI is a unique 18-digit numeric identifier assigned to every person accessing public health services in Ireland."
* type 1..1 MS
* type = $V2-0203#NI "National unique individual identifier"
* system 1..1 MS
* system = $IHI (exactly)
* value 1..1 MS
* value ^short = "IHI number (18 digits)"
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
Description: "A profile on the Identifier datatype for a local Medical Record Number (MRN) assigned by a healthcare facility within the Irish health system."
* type 1..1 MS
* type = $V2-0203#MR "Medical record number"
* system 1..1 MS
* value 1..1 MS
* value ^short = "Medical record number value"

// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Insurance Member Number (IMN)                              │
// ╰──────────────────────────────────────────────────────────────────────╯

Profile: IECoreInsuranceMemberNumber
Parent: Identifier
Id: ie-core-insurance-member-number
Title: "IE Core Insurance Member Number (IMN)"
Description: "A profile on the Identifier datatype for a health insurance member number used within the Irish health system."
* type 1..1 MS
* type = $V2-0203#MB "Member number"
* system 1..1 MS
* value 1..1 MS
* value ^short = "Insurance member number value"

// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core General Medical Service (GMS)                              │
// ╰──────────────────────────────────────────────────────────────────────╯

Profile: IECoreGeneralMedicalService
Parent: Identifier
Id: ie-core-general-medical-service
Title: "IE Core General Medical Service (GMS)"
Description: "A profile on the Identifier datatype for a General Medical Services (Medical Card) number. Format is 7 digits followed by 1 alphabetic character."
* system 1..1 MS
* system = $GMS (exactly)
* value 1..1 MS
* value ^short = "GMS number (e.g. 1234567A)"

// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Drugs Payment Scheme (DPS)                                 │
// ╰──────────────────────────────────────────────────────────────────────╯

Profile: IECoreDrugsPaymentScheme
Parent: Identifier
Id: ie-core-drugs-payment-scheme
Title: "IE Core Drugs Payment Scheme (DPS)"
Description: "A profile on the Identifier datatype for a Drugs Payment Scheme number. Format follows the PPS Number pattern: 7 digits followed by 1-2 alphabetic characters."
* system 1..1 MS
* system = $DPS (exactly)
* value 1..1 MS
* value ^short = "DPS number"

// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Long Term Illness (LTI)                                    │
// ╰──────────────────────────────────────────────────────────────────────╯

Profile: IECoreLongTermIllness
Parent: Identifier
Id: ie-core-long-term-illness
Title: "IE Core Long Term Illness (LTI)"
Description: "A profile on the Identifier datatype for a Long Term Illness scheme number. Format follows the PPS Number pattern: 7 digits followed by 1-2 alphabetic characters."
* system 1..1 MS
* system = $LTI (exactly)
* value 1..1 MS
* value ^short = "LTI number"

// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Health Amendment Act (HAA)                                 │
// ╰──────────────────────────────────────────────────────────────────────╯

Profile: IECoreHealthAmendmentAct
Parent: Identifier
Id: ie-core-health-amendment-act
Title: "IE Core Health Amendment Act (HAA)"
Description: "A profile on the Identifier datatype for a Health Amendment Act number used within the Irish health system."
* system 1..1 MS
* system = $HAA (exactly)
* value 1..1 MS
* value ^short = "HAA number"

// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Health Service Provider Identifier (HPI)                   │
// ╰──────────────────────────────────────────────────────────────────────╯

Profile: IECoreHealthServiceProviderIdentifier
Parent: Identifier
Id: ie-core-health-service-provider-identifier
Title: "IE Core Health Service Provider Identifier (HPI)"
Description: "A profile on the Identifier datatype for a Health Service Provider Identifier (HPI) assigned to organisations and practitioners within the Irish health system."
* type 1..1 MS
* type = $V2-0203#PRN "Provider number"
* system 1..1 MS
* system = $HPI (exactly)
* value 1..1 MS
* value ^short = "HPI number"

// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Irish Medical Council (IMC)                                │
// ╰──────────────────────────────────────────────────────────────────────╯

Profile: IECoreIrishMedicalCouncil
Parent: Identifier
Id: ie-core-irish-medical-council
Title: "IE Core Irish Medical Council (IMC)"
Description: "A profile on the Identifier datatype for an Irish Medical Council registration number assigned to medical practitioners registered in Ireland."
* system 1..1 MS
* system = $IMC (exactly)
* value 1..1 MS
* value ^short = "IMC registration number"

// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Company Registration Number (CRN)                          │
// ╰──────────────────────────────────────────────────────────────────────╯

Profile: IECoreCompanyRegistrationNumber
Parent: Identifier
Id: ie-core-company-registration-number
Title: "IE Core Company Registration Number (CRN)"
Description: "A profile on the Identifier datatype for a Company Registration Number (CRN) as assigned by the Companies Registration Office (CRO) in Ireland."
* system 1..1 MS
* system = $CRN (exactly)
* value 1..1 MS
* value ^short = "CRN number"
