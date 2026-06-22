// ╭────────────────────────────────────────────────────────────────────────────────────────────────╮
// │ IE CORE FHIR ALIASES                                                                         │
// │ NOTE: Base URL is configurable via build-config.env and build-ig-with-config.sh              │
// │ See README.md for instructions on building with custom base URL                              │
// ╰────────────────────────────────────────────────────────────────────────────────────────────────╯

// HL7 & FHIR Standard Aliases
Alias: $SCT = http://snomed.info/sct
Alias: $LOINC = http://loinc.org
Alias: $UCUM = http://unitsofmeasure.org
Alias: $ICD10 = http://hl7.org/fhir/sid/icd-10-cm
Alias: $ICD10PCS = http://www.cms.gov/Medicare/Coding/ICD10
Alias: $CPT = http://www.ama-assn.org/go/cpt
Alias: $RxNorm = http://www.nlm.nih.gov/research/umls/rxnorm
Alias: $CVX = http://hl7.org/fhir/sid/cvx
Alias: $ATC = http://www.whocc.no/atc

// HSE Central Terminology Server (CTS) — NMPC & SNOMED CT Irish Edition
// FHIR endpoint: https://nmpc.hse.ie/production1/fhir
// Guidance & examples: https://github.com/hsenmpc/nmpc-api-examples
//
// The NMPC (National Medicinal Product Catalogue) is a SNOMED CT-based medication
// catalogue maintained by the HSE and hosted on the CTS. Products are represented
// as SNOMED CT concepts within the Irish Extension (module 1601000220105), with
// an NMPC supplement codesystem providing additional properties (PCRS category,
// shortage status, HPRA authorisation number, ATC mapping, etc.).
//
// Product hierarchy:
//   VTM  → ATM  (therapeutic moiety level)
//   VMP  → AMP  (medicinal product level)
//   VMPP → AMPP (pack level — dispensable unit)
//
// SNOMED CT Irish Extension (module 1601000220105):
Alias: $SCT_IE = http://snomed.info/sct/1601000220105
// NMPC supplement codesystem (provides PCRS/HPRA/ATC properties on SNOMED concepts):
Alias: $NMPC_SUPPLEMENT = https://nmpc.hse.ie/CodeSystem/nmpc-supplement
// PCRS (Primary Care Reimbursement Service) category reference:
Alias: $PCRS_CATEGORY = https://nmpc.hse.ie/PCRS/Category
// HPRA (Health Products Regulatory Authority) drug catalogue (mapped via SNOMED ConceptMap):
Alias: $HPRA = https://www.hpra.ie/drug-catalogue
// Legacy/local NMPC placeholder (used in illustrative examples; real codes are SNOMED CT concepts):
Alias: $NMPC = https://hl7-ie.github.io/ie-core-fhir-ig-draft/fhir/ie/core/sid/nmpc
Alias: $V2-0203 = http://terminology.hl7.org/CodeSystem/v2-0203
Alias: $V3-NullFlavor = http://terminology.hl7.org/CodeSystem/v3-NullFlavor
Alias: $V3-ActCode = http://terminology.hl7.org/CodeSystem/v3-ActCode
Alias: $V3-RoleCode = http://terminology.hl7.org/CodeSystem/v3-RoleCode
Alias: $V3-ParticipationType = http://terminology.hl7.org/CodeSystem/v3-ParticipationType
Alias: $ObsCat = http://terminology.hl7.org/CodeSystem/observation-category
Alias: $CondCat = http://terminology.hl7.org/CodeSystem/condition-category
Alias: $DiagReportCat = http://terminology.hl7.org/CodeSystem/v2-0074
Alias: $DocRefCat = http://hl7.org/fhir/us/core/CodeSystem/us-core-documentreference-category
Alias: $ProvenanceParticipant = http://terminology.hl7.org/CodeSystem/provenance-participant-type
Alias: $DataAbsentReason = http://terminology.hl7.org/CodeSystem/data-absent-reason
Alias: $CondVerStatus = http://terminology.hl7.org/CodeSystem/condition-ver-status

// IE Core Canonical Base
Alias: $IEBase = https://hl7-ie.github.io/ie-core-fhir-ig-draft/fhir/ie/core

// IE Core Identifier Systems
Alias: $IHI = https://hl7-ie.github.io/ie-core-fhir-ig-draft/fhir/ie/core/sid/ihi
Alias: $HPI = https://hl7-ie.github.io/ie-core-fhir-ig-draft/fhir/ie/core/sid/hpi
Alias: $MRN = https://hl7-ie.github.io/ie-core-fhir-ig-draft/fhir/ie/core/sid/mrn
Alias: $IMC = https://hl7-ie.github.io/ie-core-fhir-ig-draft/fhir/ie/core/sid/imc
Alias: $GMS = https://hl7-ie.github.io/ie-core-fhir-ig-draft/fhir/ie/core/sid/gms
Alias: $DPS = https://hl7-ie.github.io/ie-core-fhir-ig-draft/fhir/ie/core/sid/dps
Alias: $LTI = https://hl7-ie.github.io/ie-core-fhir-ig-draft/fhir/ie/core/sid/lti
Alias: $HAA = https://hl7-ie.github.io/ie-core-fhir-ig-draft/fhir/ie/core/sid/haa
Alias: $CRN = https://hl7-ie.github.io/ie-core-fhir-ig-draft/fhir/ie/core/sid/crn
Alias: $IMN = https://hl7-ie.github.io/ie-core-fhir-ig-draft/fhir/ie/core/sid/imn

// Irish Government Identifier Systems
Alias: $PPS = https://hl7-ie.github.io/ie-core-fhir-ig-draft/fhir/ie/core/sid/pps
Alias: $Eircode = https://hl7-ie.github.io/ie-core-fhir-ig-draft/fhir/ie/core/sid/eircode

// HL7 FHIR Extension URLs
Alias: $DAR = http://hl7.org/fhir/StructureDefinition/data-absent-reason
Alias: $IndividualPronouns = http://hl7.org/fhir/StructureDefinition/individual-pronouns
Alias: $PatientProficiency = http://hl7.org/fhir/StructureDefinition/patient-proficiency

// Observation Category Codes
Alias: $VitalSigns = vital-signs
Alias: $Laboratory = laboratory
Alias: $SocialHistory = social-history
Alias: $Survey = survey

// HL7 Europe Base & Core Profiles (EHDS-aligned)
Alias: $EUPatientBase = http://hl7.eu/fhir/base/StructureDefinition/patient-eu
Alias: $EUPatientCore = http://hl7.eu/fhir/base/StructureDefinition/patient-eu-core
Alias: $EUPractitionerCore = http://hl7.eu/fhir/base/StructureDefinition/practitioner-eu-core
Alias: $EUPractitionerRoleCore = http://hl7.eu/fhir/base/StructureDefinition/practitionerRole-eu-core
Alias: $EUOrganizationCore = http://hl7.eu/fhir/base/StructureDefinition/organization-eu-core
Alias: $EUAllergyIntoleranceCore = http://hl7.eu/fhir/base/StructureDefinition/allergyIntolerance-eu-core
Alias: $EUConditionCore = http://hl7.eu/fhir/base/StructureDefinition/condition-eu-core
Alias: $EUProcedureCore = http://hl7.eu/fhir/base/StructureDefinition/procedure-eu-core
Alias: $EUImmunizationCore = http://hl7.eu/fhir/base/StructureDefinition/immunization-eu-core
Alias: $EUMedicationCore = http://hl7.eu/fhir/base/StructureDefinition/medication-eu-core
Alias: $EUMedicationRequestCore = http://hl7.eu/fhir/base/StructureDefinition/medicationRequest-eu-core
Alias: $EUDiagnosticReportCore = http://hl7.eu/fhir/base/StructureDefinition/diagnosticReport-eu-core
Alias: $EULocationCore = http://hl7.eu/fhir/base/StructureDefinition/location-eu-core
Alias: $EUMedicalTestResultCore = http://hl7.eu/fhir/base/StructureDefinition/medicalTestResult-eu-core
Alias: $EUAddressDataType = http://hl7.eu/fhir/base/StructureDefinition/Address-eu

// International Patient Summary (IPS)
Alias: $IPSPatient = http://hl7.org/fhir/uv/ips/StructureDefinition/Patient-uv-ips

// HL7 Europe MPD — ePrescription & eDispensation (hl7.fhir.eu.mpd 0.1.0-ballot)
// https://hl7.eu/fhir/mpd
Alias: $EUMPDMedicationRequest  = http://hl7.eu/fhir/mpd/StructureDefinition/MedicationRequest-eu-mpd
Alias: $EUMPDMedicationDispense = http://hl7.eu/fhir/mpd/StructureDefinition/MedicationDispense-eu-mpd
Alias: $EUMPDMedication         = http://hl7.eu/fhir/mpd/StructureDefinition/Medication-eu-mpd

// HL7 Europe Hospital Discharge Report (hl7.fhir.eu.hdr 0.1.0-ballot)
// https://hl7.eu/fhir/hdr
Alias: $EUHDRComposition = http://hl7.eu/fhir/hdr/StructureDefinition/composition-eu-hdr
Alias: $EUHDRBundle      = http://hl7.eu/fhir/hdr/StructureDefinition/bundle-eu-hdr

// HL7 Europe Extensions (hl7.fhir.eu.extensions 1.2.0)
// https://hl7.eu/fhir/extensions
Alias: $EUExtInformationRecipient = http://hl7.eu/fhir/extensions/StructureDefinition/information-recipient
Alias: $EUExtMedicationPackageType = http://hl7.eu/fhir/extensions/StructureDefinition/medication-package-type

// HL7 Europe Imaging IG (ballot ongoing — no package published yet)
// https://hl7.eu/fhir/imaging / https://hl7.eu/fhir/imaging-r5
// Aliases will be added once the package is formally published.

// ── eIDAS 2.0 / EUDI Wallet / Cross-Border Patient Identity ───────────────────
//
// eIDAS Cross-Border Patient Identifier
//   OID: 1.3.6.1.4.1.12559.11.10.1.3.1.42.1
//   Format: Origin/Destination/NationalID (e.g. IE/DE/1234567T)
//   Used in: Patient.identifier.system for cross-border PID (eHDSI / MyHealth@EU)
//   Basis: eIDAS Regulation 2014/910/EU; eIDAS 2.0 Regulation 2024/1183/EU
Alias: $EIDASPatientID = urn:oid:1.3.6.1.4.1.12559.11.10.1.3.1.42.1

// EUDI Wallet Namespace (ARF v2.x)
//   Base namespace for EU Digital Identity Wallet attestation types
//   Defined in: EUDI Architecture and Reference Framework (ARF) v2.x
//   See: https://digital-strategy.ec.europa.eu/en/policies/eudi-wallet-technical-specifications
Alias: $EUDIWalletNamespace = https://identity.eudi.ec.europa.eu/claims

// eHDSI / MyHealth@EU system identifiers
//   NCPeH organisation identifier system (eHDSI OID)
Alias: $NCPeHOrgID = urn:oid:1.3.6.1.4.1.12559.11.10.1.3.1.2.1

// Irish National ePrescription Service (NePS) identifier system
Alias: $NePS = https://hl7-ie.github.io/ie-core-fhir-ig-draft/fhir/ie/core/sid/neps
