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
