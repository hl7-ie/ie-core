// ╭──────────────────────────────────────────────────────────────────────╮
// │  Placeholder terminology for HIQA draft standards (Sept 2026)       │
// │  HIQA: "Coded values have not yet been specified in this standard". │
// │  Each CodeSystem here is an IE Core PLACEHOLDER built only from     │
// │  names given in the HIQA text or the cited legislation. None is an  │
// │  authoritative code system. Requires Clarification (OI-007).        │
// ╰──────────────────────────────────────────────────────────────────────╯

CodeSystem: IECorePCRSSchemeType
Id: ie-core-pcrs-scheme-type
Title: "IE Core PCRS Scheme Type (placeholder)"
Description: "PLACEHOLDER. Types of Primary Care Reimbursement Service (PCRS) scheme number, taken from the examples in HIQA EP/PS 1.3.3.1: medical card scheme, GP visit card, Drugs Payment Scheme (DPS), Long-Term Illness scheme and Health Amendment Act card scheme (HAA). Used as Identifier.type for HIQA 'other identifiers used in health and social care'. Requires Clarification (OI-007): to be replaced by an HSE/PCRS code system."
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #medical-card "Medical card scheme number" "PCRS medical card (General Medical Services) number."
* #gp-visit-card "GP visit card number" "PCRS GP visit card number."
* #dps "Drugs Payment Scheme number" "PCRS Drugs Payment Scheme (DPS) number."
* #lti "Long-Term Illness scheme number" "PCRS Long-Term Illness (LTI) scheme number."
* #haa "Health Amendment Act card number" "PCRS Health (Amendment) Act card scheme (HAA) number."

ValueSet: IECorePCRSSchemeTypeVS
Id: ie-core-pcrs-scheme-type
Title: "IE Core PCRS Scheme Type (placeholder)"
Description: "PLACEHOLDER. PCRS scheme number types (HIQA EP/PS 1.3.3.1 examples). Requires Clarification (OI-007)."
* ^status = #draft
* ^experimental = true
* include codes from system IECorePCRSSchemeType

CodeSystem: IECoreMDASchedule
Id: ie-core-mda-schedule
Title: "IE Core Misuse of Drugs Schedule (placeholder)"
Description: "PLACEHOLDER. Controlled drug schedules of the Misuse of Drugs Regulations 2017 (S.I. No. 173/2017), cited by HIQA EP 4.2.3 (MDA Schedule, Required, expected auto-populated from the NMPC). The schedule names come from the regulations; the codes are IE Core placeholders. Requires Clarification (OI-007): to be replaced by the NMPC/HPRA representation."
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #schedule-1 "Schedule 1" "Misuse of Drugs Regulations 2017, Schedule 1."
* #schedule-2 "Schedule 2" "Misuse of Drugs Regulations 2017, Schedule 2."
* #schedule-3 "Schedule 3" "Misuse of Drugs Regulations 2017, Schedule 3."
* #schedule-4-part-1 "Schedule 4 Part 1" "Misuse of Drugs Regulations 2017, Schedule 4 Part 1."
* #schedule-4-part-2 "Schedule 4 Part 2" "Misuse of Drugs Regulations 2017, Schedule 4 Part 2."
* #schedule-5 "Schedule 5" "Misuse of Drugs Regulations 2017, Schedule 5."

ValueSet: IECoreMDAScheduleVS
Id: ie-core-mda-schedule
Title: "IE Core Misuse of Drugs Schedule (placeholder)"
Description: "PLACEHOLDER. Controlled drug schedules (S.I. No. 173/2017). HIQA EP 4.2.3. Requires Clarification (OI-007)."
* ^status = #draft
* ^experimental = true
* include codes from system IECoreMDASchedule

CodeSystem: IECoreSupplyLegalStatus
Id: ie-core-supply-legal-status
Title: "IE Core Supply Legal Status (placeholder)"
Description: "PLACEHOLDER. Legal supply status of a medicinal product, HIQA EP 4.2.2 (Required, auto-populated). Only the two statuses given as examples in the HIQA text are included. Requires Clarification (OI-007): to be replaced by the NMPC/HPRA representation."
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #fragment
* #prescription-only "Prescription only medicine" "Prescription only medicine (HIQA EP 4.2.2 example)."
* #general-sale "General sales list" "General sales list (HIQA EP 4.2.2 example)."

CodeSystem: IECoreNMPCPlaceholder
Id: ie-core-nmpc-placeholder
Title: "IE Core NMPC Placeholder (illustrative codes only)"
Description: "PLACEHOLDER. Illustrative medication codes used in the IE Core examples. This is NOT the National Medicinal Product Catalogue (NMPC). Real NMPC codes are SNOMED CT Irish Extension concepts served by the HSE Central Terminology Server (see Terminology Services); the NMPC does not publish a separate FHIR code system URI that this IG can use (Requires Clarification, OI-018). Do not use these codes in production."
* ^status = #draft
* ^experimental = true
* ^caseSensitive = true
* ^content = #complete
* #NMPC-AML5TAB "Amlodipine 5mg tablets"
* #NMPC-ATV20TAB "Atorvastatin 20mg film-coated tablets"
* #NMPC-ATV40TAB "Atorvastatin 40mg tablets"
* #NMPC-ATV80TAB "Atorvastatin 80mg tablets"
* #NMPC-INSASP100 "Insulin aspart 100 units/ml solution for injection"
* #NMPC-INSGLAR100 "Insulin glargine 100 units/ml solution for injection"
* #NMPC-LIS10TAB "Lisinopril 10mg tablets"
* #NMPC-MET500TAB "Metformin hydrochloride 500mg film-coated tablets"
* #NMPC-OME20CAP "Omeprazole 20mg gastro-resistant capsules"
* #NMPC-RAM10CAP "Ramipril 10mg capsules"
* #NMPC-RAM5CAP "Ramipril 5mg capsules"
* #NMPC-SER50TAB "Sertraline 50mg tablets"
* #NMPC-WAR5TAB "Warfarin 5mg tablets"
