// ============================================================================
// IE Core CodeSystems
// Ireland (IE) Core FHIR Implementation Guide
// Canonical: https://hl7-ie.github.io/ie-core-fhir-ig-draft/fhir/ie/core
// FHIR R4 (4.0.1)
// ============================================================================

// ----------------------------------------------------------------------------
// 1. IE Core CodeSystem — General codes used across IE Core
// ----------------------------------------------------------------------------
CodeSystem: IECoreCodeSystem
Id: ie-core-codesystem
Title: "IE Core CodeSystem"
Description: "General codes used across the IE Core Implementation Guide that are not defined elsewhere."
* ^status = #draft
* ^experimental = false
* ^caseSensitive = true
* ^content = #complete
* #assess-plan "Assess and Plan" "A category for assessment and plan notes within a clinical encounter."

// ----------------------------------------------------------------------------
// 2. IE Core Condition Category Codes
// ----------------------------------------------------------------------------
CodeSystem: IECoreConditionCategoryCodes
Id: ie-core-condition-category
Title: "IE Core Condition Category Codes"
Description: "Codes used as condition category values in the IE Core Implementation Guide."
* ^status = #draft
* ^experimental = false
* ^caseSensitive = true
* ^content = #complete
* #health-concern "Health Concern" "A health concern is a clinical concept representing a condition, problem, diagnosis, or other event, situation, issue, or clinical concept that has risen to a level of concern."

// ----------------------------------------------------------------------------
// 3. IE Core Provenance Participant Type
// ----------------------------------------------------------------------------
CodeSystem: IECoreProvenanceParticipantTypeCodes
Id: ie-core-provenance-participant-type-codes
Title: "IE Core Provenance Participant Type"
Description: "Codes for provenance participant types specific to the IE Core Implementation Guide."
* ^status = #draft
* ^experimental = false
* ^caseSensitive = true
* ^content = #complete
* #transmitter "Transmitter" "The entity that provided the copy to your system."

// ----------------------------------------------------------------------------
// 4. IE Core Tags
// ----------------------------------------------------------------------------
CodeSystem: IECoreTags
Id: ie-core-tags
Title: "IE Core Tags"
Description: "Tag codes used for marking resources in the IE Core Implementation Guide."
* ^status = #draft
* ^experimental = false
* ^caseSensitive = true
* ^content = #complete
* #iecdi-requirement "IECDI Requirement" "Indicates the resource is required by the Ireland Electronic Clinical Document Infrastructure (IECDI)."

// ----------------------------------------------------------------------------
// 5. IE Core DocumentReference Category Codes
// ----------------------------------------------------------------------------
CodeSystem: IECoreDocumentReferenceCategoryCodes
Id: ie-core-documentreference-category-codes
Title: "IE Core DocumentReference Category Codes"
Description: "Codes for categorising DocumentReference resources in the IE Core Implementation Guide."
* ^status = #draft
* ^experimental = false
* ^caseSensitive = true
* ^content = #complete
* #clinical-note "Clinical Note" "A clinical note or document authored during a patient encounter."

// ----------------------------------------------------------------------------
// 6. IE Core Screening Assessment Codes
// ----------------------------------------------------------------------------
CodeSystem: IECoreScreeningAssessmentCodes
Id: ie-core-screening-assessment-codes
Title: "IE Core Screening Assessment Codes"
Description: "Codes for categorising screening and assessment observations in the IE Core Implementation Guide."
* ^status = #draft
* ^experimental = false
* ^caseSensitive = true
* ^content = #complete
* #sdoh "Social Determinants of Health" "Category for Social Determinants of Health screening and assessment observations."

// ----------------------------------------------------------------------------
// 7. IE Core County Codes
// ----------------------------------------------------------------------------
CodeSystem: IECoreCountyCodes
Id: ie-core-county-codes
Title: "IE Core County Codes"
Description: "Codes representing the 26 counties of the Republic of Ireland."
* ^status = #draft
* ^experimental = false
* ^caseSensitive = true
* ^content = #complete
* #CW "Carlow" "County Carlow"
* #CN "Cavan" "County Cavan"
* #CE "Clare" "County Clare"
* #CO "Cork" "County Cork"
* #DL "Donegal" "County Donegal"
* #D  "Dublin" "County Dublin"
* #G  "Galway" "County Galway"
* #KY "Kerry" "County Kerry"
* #KE "Kildare" "County Kildare"
* #KK "Kilkenny" "County Kilkenny"
* #LS "Laois" "County Laois"
* #LM "Leitrim" "County Leitrim"
* #LK "Limerick" "County Limerick"
* #LD "Longford" "County Longford"
* #LH "Louth" "County Louth"
* #MO "Mayo" "County Mayo"
* #MH "Meath" "County Meath"
* #MN "Monaghan" "County Monaghan"
* #OY "Offaly" "County Offaly"
* #RN "Roscommon" "County Roscommon"
* #SO "Sligo" "County Sligo"
* #TA "Tipperary" "County Tipperary"
* #WD "Waterford" "County Waterford"
* #WH "Westmeath" "County Westmeath"
* #WX "Wexford" "County Wexford"
* #WW "Wicklow" "County Wicklow"

// ----------------------------------------------------------------------------
// 8. IE Core Ethnicity Codes
// ----------------------------------------------------------------------------
CodeSystem: IECoreEthnicityCodes
Id: ie-core-ethnicity-codes
Title: "IE Core Ethnicity Codes"
Description: "Ethnicity codes based on the Central Statistics Office (CSO) census categories for the Republic of Ireland."
* ^status = #draft
* ^experimental = false
* ^caseSensitive = true
* ^content = #complete
* #irish-traveller "Irish Traveller" "Irish Traveller ethnic group."
* #roma "Roma" "Roma ethnic group."
* #white-irish "White Irish" "White Irish ethnic group."
* #white-irish-traveller "White Irish Traveller" "White Irish Traveller ethnic group."
* #any-other-white "Any other White background" "Any other White background ethnic group."
* #black-african "Black or Black Irish - African" "Black or Black Irish – African ethnic group."
* #black-other "Black or Black Irish - any other Black background" "Black or Black Irish – any other Black background ethnic group."
* #asian-chinese "Asian or Asian Irish - Chinese" "Asian or Asian Irish – Chinese ethnic group."
* #asian-other "Asian or Asian Irish - any other Asian background" "Asian or Asian Irish – any other Asian background ethnic group."
* #other-mixed "Other including mixed background" "Other including mixed background ethnic group."
* #not-stated "Not stated" "Ethnicity not stated."

// ----------------------------------------------------------------------------
// 9. IE Core IHI Status Codes
// ----------------------------------------------------------------------------
CodeSystem: IECoreIHIStatusCodes
Id: ie-core-ihi-status-codes
Title: "IE Core IHI Status Codes"
Description: "Status codes for Individual Health Identifiers (IHI) in the Irish health system."
* ^status = #draft
* ^experimental = false
* ^caseSensitive = true
* ^content = #complete
* #active "Active" "The IHI is currently active and in use."
* #deceased "Deceased" "The individual associated with the IHI is deceased."
* #retired "Retired" "The IHI has been retired and is no longer in use."
* #unknown "Unknown" "The status of the IHI is unknown."

// ----------------------------------------------------------------------------
// 10. IE Core IHI Record Status Codes
// ----------------------------------------------------------------------------
CodeSystem: IECoreIHIRecordStatusCodes
Id: ie-core-ihi-record-status-codes
Title: "IE Core IHI Record Status Codes"
Description: "Record-level status codes for Individual Health Identifier (IHI) records indicating verification state."
* ^status = #draft
* ^experimental = false
* ^caseSensitive = true
* ^content = #complete
* #verified "Verified" "The IHI record has been verified against authoritative sources."
* #unverified "Unverified" "The IHI record has not yet been verified."
* #provisional "Provisional" "The IHI record is provisional and awaiting verification."
