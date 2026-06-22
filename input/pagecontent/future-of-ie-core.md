### Future of IE Core

The IE Core Implementation Guide is a living document that will continue to evolve as Ireland's digital health infrastructure matures. This page reflects priorities following the XT-EHR v1.0.0 release (2025) and the entry into force of the EHDS Regulation 2025/327 and eIDAS 2.0 (Regulation 2024/1183/EU).

### Immediate Priorities (2025-2026)

The following work items are required for full XT-EHR 1.0.0 alignment and are the next IE Core development priorities:

1. **IECoreMedicationStatement** — MedicationStatement profile fully aligned with EHDSMedicationUse v1.0.0; evaluate `adherence` element enhancements for future FHIR versions
2. **IECoreFlag** — Flag/Alert profile aligned with EHDSAlert v1.0.0; alert codes standardized with SNOMED CT
3. **IECoreDeviceUseStatement** — New profile mapping to EHDSDeviceUse; needed for the `medicalDevices` section of the Patient Summary
4. **IECoreConsent** — Formal FHIR Consent profile aligned with EHDSAdvanceDirective, supplementing the current ADI DocumentReference approach
5. **XT-EHR Obligations compliance** — Formal verification that IE Core PS and HDR profiles satisfy all SHALL obligations in the XT-EHR 1.0.0 Obligations Framework
6. **ePrescription enhancements** — Additional XT-EHR 1.0.0 elements: `presentedForm` (PDF attachment), `inpatientPrescription` flag
7. **EUDI Wallet / eIDAS 2.0 integration** — Align cross-border patient authentication with EUDI Wallet PID attestations; implement EUDI PID→FHIR Patient mapping per eIDAS 2.0 ARF v2.x; update NCPeH signing guidance to include JAdES/XAdES and IHE DSG profile alignment

### Planned Enhancements

#### Short Term (2025-2026)

- **EUDI Wallet Integration**: Full alignment with the EU Digital Identity (EUDI) Wallet architecture (eIDAS 2.0, Regulation 2024/1183/EU) for cross-border patient authentication via MyHealth@EU — targeted for 2026 MyHealth@EU onboarding
- **Shared Care Record Integration**: Alignment with HSE's national shared care record programme
- **eReferral**: Standardized electronic referral profiles
- **ePrescribing**: Enhanced medication prescribing profiles aligned with national ePrescribing systems
- **National Immunization Registry**: Integration with Ireland's national immunization information system
- **MedicationAdministration**: Profile for EHDSMedicationAdministration
- **HIPS Bill Conformance**: Alignment with Health Information and Patient Safety (HIPS) Bill requirements once enacted
- **FAPI 2.0**: Implement Financial-grade API 2.0 security profile for EHDS secondary use data spaces and the HL7 Europe Health Data API IG

#### Medium Term (2026-2027)

- **EU Core 2.0 Re-parenting**: Re-base AllergyIntolerance, Condition, Procedure, Immunization, Medication, MedicationRequest, and DiagnosticReport profiles on HL7 Europe Core profiles when `hl7.fhir.eu.base` v2.0.0 is published
- **FHIR R5 Migration Path**: Planning for FHIR R5 adoption aligned with HL7 Europe's R5 timeline. Key profile changes: `MedicationStatement→MedicationUsage`, `DeviceUseStatement→DeviceUsage`, Consent restructure, Encounter `reasonCode→reason`
- **MyHealth@EU Integration**: Full cross-border patient summary exchange via MyHealth@EU infrastructure
- **EU Patient Summary IG adoption**: Formal re-parenting once `hl7.fhir.eu.eps` STU is published
- **EU Hospital Discharge IG adoption**: Formal re-parenting once `hl7.fhir.eu.hdr` STU is published
- **Genomics**: Profiles for genomic data exchange
- **Terminology Services**: National terminology server for Irish healthcare terminologies
- **EHDS Implementing Acts**: Begin alignment with the European Commission's Implementing Acts on the EEHRxF (expected early 2027)

#### Long Term (2027+)

- **EHDS Full Conformance**: Complete conformance with EHDS Implementing Acts on the European Electronic Health Record Exchange Format (EEHRxF) — March 2027 deadline
- **AI/Clinical Decision Support**: FHIR-based CDS Hooks integration
- **Population Health**: Aggregate data profiles for public health reporting
- **Research Data Exchange**: Profiles for clinical research data sharing, aligned with EHDS secondary use requirements

### How to Contribute

**⚠️ Current Status:** This IG is a Proof of Concept maintained by Nithin Mohan. Contributions are welcome, and in the future, when governance is established, the following processes will apply:

The IE Core Implementation Guide welcomes contributions from all stakeholders:

1. **Issue Reporting**: Submit issues through the GitHub repository
2. **Ballot Participation**: Participate in formal HL7 ballot processes (future, when formally established)
3. **Working Group Membership**: Join or establish an HL7 Ireland FHIR Working Group
4. **Implementation Feedback**: Share implementation experience and challenges

### Versioning

IE Core follows [Semantic Versioning](https://semver.org/):

- **Major versions** (x.0.0): Breaking changes or significant restructuring
- **Minor versions** (x.y.0): New profiles, extensions, or value sets
- **Patch versions** (x.y.z): Bug fixes and clarifications
- **Pre-release** (-ballot, -snapshot): Work-in-progress versions for review
