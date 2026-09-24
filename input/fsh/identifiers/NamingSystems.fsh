// ╭──────────────────────────────────────────────────────────────────────╮
// │  NamingSystems for IE identifier URIs (ADR-006, OI-003)             │
// │  All URIs below are PLACEHOLDERS minted under this IG's canonical.  │
// │  They will be replaced when the issuing authority publishes a URI.  │
// ╰──────────────────────────────────────────────────────────────────────╯

Instance: ie-core-ns-ihi
InstanceOf: NamingSystem
Usage: #definition
Title: "Individual Health Identifier (IHI)"
* name = "IECoreNamingSystemIHI"
* status = #draft
* kind = #identifier
* date = "2026-09-24"
* responsible = "HSE"
* description = "PLACEHOLDER URI, pending a URI published by the issuing authority (Requires Clarification, OI-003). HIQA EP/PS 1.3.1. Issued by the HSE; 18 or 10 digits."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* uniqueId[0].type = #uri
* uniqueId[=].value = "https://hl7-ie.github.io/ie-core/fhir/ie/core/sid/ihi"
* uniqueId[=].preferred = true

Instance: ie-core-ns-ppsn
InstanceOf: NamingSystem
Usage: #definition
Title: "Personal Public Service Number (PPSN)"
* name = "IECoreNamingSystemPPSN"
* status = #draft
* kind = #identifier
* date = "2026-09-24"
* responsible = "Department of Social Protection"
* description = "PLACEHOLDER URI, pending a URI published by the issuing authority (Requires Clarification, OI-003). HIQA EP/PS 1.3.2. Use as a health identifier is Requires Clarification (OI-008)."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* uniqueId[0].type = #uri
* uniqueId[=].value = "https://hl7-ie.github.io/ie-core/fhir/ie/core/sid/pps"
* uniqueId[=].preferred = true

Instance: ie-core-ns-gms
InstanceOf: NamingSystem
Usage: #definition
Title: "PCRS medical card (GMS) number"
* name = "IECoreNamingSystemGMSMedicalCard"
* status = #draft
* kind = #identifier
* date = "2026-09-24"
* responsible = "HSE PCRS"
* description = "PLACEHOLDER URI, pending a URI published by the issuing authority (Requires Clarification, OI-003). HIQA EP/PS 1.3.3.1 lists it as an example of an other identifier. HIQA gives no format, so none is enforced (ADR-006)."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* uniqueId[0].type = #uri
* uniqueId[=].value = "https://hl7-ie.github.io/ie-core/fhir/ie/core/sid/gms"
* uniqueId[=].preferred = true

Instance: ie-core-ns-dps
InstanceOf: NamingSystem
Usage: #definition
Title: "PCRS Drugs Payment Scheme (DPS) number"
* name = "IECoreNamingSystemDrugsPaymentScheme"
* status = #draft
* kind = #identifier
* date = "2026-09-24"
* responsible = "HSE PCRS"
* description = "PLACEHOLDER URI, pending a URI published by the issuing authority (Requires Clarification, OI-003). HIQA EP/PS 1.3.3.1 example. No format enforced."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* uniqueId[0].type = #uri
* uniqueId[=].value = "https://hl7-ie.github.io/ie-core/fhir/ie/core/sid/dps"
* uniqueId[=].preferred = true

Instance: ie-core-ns-lti
InstanceOf: NamingSystem
Usage: #definition
Title: "PCRS Long-Term Illness (LTI) scheme number"
* name = "IECoreNamingSystemLongTermIllness"
* status = #draft
* kind = #identifier
* date = "2026-09-24"
* responsible = "HSE PCRS"
* description = "PLACEHOLDER URI, pending a URI published by the issuing authority (Requires Clarification, OI-003). HIQA EP/PS 1.3.3.1 example. No format enforced."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* uniqueId[0].type = #uri
* uniqueId[=].value = "https://hl7-ie.github.io/ie-core/fhir/ie/core/sid/lti"
* uniqueId[=].preferred = true

Instance: ie-core-ns-haa
InstanceOf: NamingSystem
Usage: #definition
Title: "PCRS Health (Amendment) Act (HAA) card number"
* name = "IECoreNamingSystemHealthAmendmentAct"
* status = #draft
* kind = #identifier
* date = "2026-09-24"
* responsible = "HSE PCRS"
* description = "PLACEHOLDER URI, pending a URI published by the issuing authority (Requires Clarification, OI-003). HIQA EP/PS 1.3.3.1 example (Health Amendment Act card scheme). No format enforced."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* uniqueId[0].type = #uri
* uniqueId[=].value = "https://hl7-ie.github.io/ie-core/fhir/ie/core/sid/haa"
* uniqueId[=].preferred = true

Instance: ie-core-ns-neps
InstanceOf: NamingSystem
Usage: #definition
Title: "National ePrescribing Service (NePS) prescription (group) identifier"
* name = "IECoreNamingSystemNePSPrescription"
* status = #draft
* kind = #identifier
* date = "2026-09-24"
* responsible = "HSE"
* description = "PLACEHOLDER URI, pending a URI published by the issuing authority (Requires Clarification, OI-003). HIQA EP 3.1: the NePS electronic prescription (group) identifier used throughout the prescription and dispensation life cycle."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* uniqueId[0].type = #uri
* uniqueId[=].value = "https://hl7-ie.github.io/ie-core/fhir/ie/core/sid/neps"
* uniqueId[=].preferred = true

Instance: ie-core-ns-imc
InstanceOf: NamingSystem
Usage: #definition
Title: "Irish Medical Council registration number (MCRN)"
* name = "IECoreNamingSystemIMC"
* status = #draft
* kind = #identifier
* date = "2026-09-24"
* responsible = "Medical Council"
* description = "PLACEHOLDER URI, pending a URI published by the issuing authority (Requires Clarification, OI-003). HIQA EP/PS 2.6.2."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* uniqueId[0].type = #uri
* uniqueId[=].value = "https://hl7-ie.github.io/ie-core/fhir/ie/core/sid/imc"
* uniqueId[=].preferred = true

Instance: ie-core-ns-psi
InstanceOf: NamingSystem
Usage: #definition
Title: "Pharmaceutical Society of Ireland registration number"
* name = "IECoreNamingSystemPSI"
* status = #draft
* kind = #identifier
* date = "2026-09-24"
* responsible = "Pharmaceutical Society of Ireland"
* description = "PLACEHOLDER URI, pending a URI published by the issuing authority (Requires Clarification, OI-003). HIQA EP/PS 2.6.2: up to eight digits."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* uniqueId[0].type = #uri
* uniqueId[=].value = "https://hl7-ie.github.io/ie-core/fhir/ie/core/sid/psi"
* uniqueId[=].preferred = true

Instance: ie-core-ns-nmbi
InstanceOf: NamingSystem
Usage: #definition
Title: "Nursing and Midwifery Board of Ireland registration number"
* name = "IECoreNamingSystemNMBI"
* status = #draft
* kind = #identifier
* date = "2026-09-24"
* responsible = "Nursing and Midwifery Board of Ireland"
* description = "PLACEHOLDER URI, pending a URI published by the issuing authority (Requires Clarification, OI-003). HIQA EP/PS 2.6.2 (RNP/RMP divisions)."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* uniqueId[0].type = #uri
* uniqueId[=].value = "https://hl7-ie.github.io/ie-core/fhir/ie/core/sid/nmbi"
* uniqueId[=].preferred = true

Instance: ie-core-ns-dental-council
InstanceOf: NamingSystem
Usage: #definition
Title: "Dental Council of Ireland registration number"
* name = "IECoreNamingSystemDentalCouncil"
* status = #draft
* kind = #identifier
* date = "2026-09-24"
* responsible = "Dental Council of Ireland"
* description = "PLACEHOLDER URI, pending a URI published by the issuing authority (Requires Clarification, OI-003). HIQA EP definitions (dentist prescribers)."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* uniqueId[0].type = #uri
* uniqueId[=].value = "https://hl7-ie.github.io/ie-core/fhir/ie/core/sid/dental-council"
* uniqueId[=].preferred = true

Instance: ie-core-ns-psi-rpb
InstanceOf: NamingSystem
Usage: #definition
Title: "PSI Retail Pharmacy Business registration number"
* name = "IECoreNamingSystemPSIRPB"
* status = #draft
* kind = #identifier
* date = "2026-09-24"
* responsible = "Pharmaceutical Society of Ireland"
* description = "PLACEHOLDER URI, pending a URI published by the issuing authority (Requires Clarification, OI-003). HIQA EP/PS 2.8."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* uniqueId[0].type = #uri
* uniqueId[=].value = "https://hl7-ie.github.io/ie-core/fhir/ie/core/sid/psi-rpb"
* uniqueId[=].preferred = true

Instance: ie-core-ns-gms-panel
InstanceOf: NamingSystem
Usage: #definition
Title: "GMS Panel ID"
* name = "IECoreNamingSystemGMSPanel"
* status = #draft
* kind = #identifier
* date = "2026-09-24"
* responsible = "HSE PCRS"
* description = "PLACEHOLDER URI, pending a URI published by the issuing authority (Requires Clarification, OI-003). HIQA EP/PS 2.12."
* jurisdiction = urn:iso:std:iso:3166#IE "Ireland"
* uniqueId[0].type = #uri
* uniqueId[=].value = "https://hl7-ie.github.io/ie-core/fhir/ie/core/sid/gms-panel"
* uniqueId[=].preferred = true
