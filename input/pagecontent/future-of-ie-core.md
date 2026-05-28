### Future of IE Core

The IE Core Implementation Guide is a living document that will continue to evolve as Ireland's digital health infrastructure matures. This page reflects priorities following the XT-EHR v1.0.0 release (2025).

### Immediate Priorities (2025-2026)

The following work items are required for full XT-EHR 1.0.0 alignment and are the next IE Core development priorities:

1. **IECoreMedicationStatement** (Draft → Active) — Complete MedicationStatement profile fully aligned with EHDSMedicationUse obligations; evaluate `adherence` element workaround for FHIR R4
2. **IECoreFlag** (Draft → Active) — Complete Flag/Alert profile aligned with EHDSAlert obligations; finalise `category` code system binding
3. **IECoreDeviceUseStatement** — New profile mapping to EHDSDeviceUse; needed for the `medicalDevices` section of the Patient Summary
4. **IECoreConsent** — Formal FHIR Consent profile aligned with EHDSAdvanceDirective, supplementing the current ADI DocumentReference approach
5. **XT-EHR Obligations compliance** — Formal verification that IE Core PS and HDR profiles satisfy all SHALL obligations in the XT-EHR 1.0.0 Obligations Framework
6. **ePrescription enhancements** — Additional XT-EHR 1.0.0 elements: `presentedForm` (PDF attachment), `inpatientPrescription` flag

### Planned Enhancements

#### Short Term (2025-2026)

- **Shared Care Record Integration**: Alignment with HSE's national shared care record programme
- **eReferral**: Standardized electronic referral profiles
- **ePrescribing**: Enhanced medication prescribing profiles aligned with national ePrescribing systems
- **National Immunization Registry**: Integration with Ireland's national immunization information system
- **MedicationAdministration**: Profile for EHDSMedicationAdministration

#### Medium Term (2026-2027)

- **EU Core 2.0 Re-parenting**: Re-base AllergyIntolerance, Condition, Procedure, Immunization, Medication, MedicationRequest, and DiagnosticReport profiles on HL7 Europe Core profiles when `hl7.fhir.eu.base` v2.0.0 is published
- **FHIR R5 Migration Path**: Planning for FHIR R5 adoption aligned with HL7 Europe's R5 timeline. Key profile changes: `MedicationStatement→MedicationUsage`, `DeviceUseStatement→DeviceUsage`, Consent restructure, Encounter `reasonCode→reason`
- **MyHealth@EU Integration**: Full cross-border patient summary exchange via MyHealth@EU infrastructure
- **EU Patient Summary IG adoption**: Formal re-parenting once `hl7.fhir.eu.eps` STU is published
- **EU Hospital Discharge IG adoption**: Formal re-parenting once `hl7.fhir.eu.hdr` STU is published
- **Genomics**: Profiles for genomic data exchange
- **Terminology Services**: National terminology server for Irish healthcare terminologies

#### Long Term (2027+)

- **EHDS Implementing Acts**: Full conformance with the European Commission's Implementing Acts on the European Electronic Health Record Exchange Format (expected early 2027)
- **EU Digital Identity Wallet**: Support for the EU Digital Identity framework for patient authentication
- **AI/Clinical Decision Support**: FHIR-based CDS Hooks integration
- **Population Health**: Aggregate data profiles for public health reporting
- **Research Data Exchange**: Profiles for clinical research data sharing, aligned with EHDS secondary use requirements

### How to Contribute

The IE Core Implementation Guide welcomes contributions from all stakeholders:

1. **Issue Reporting**: Submit issues through the HL7 Ireland Jira project
2. **Ballot Participation**: Participate in formal HL7 ballot processes
3. **Working Group Membership**: Join the HL7 Ireland / HSE FHIR Working Group
4. **Implementation Feedback**: Share implementation experience and challenges

### Versioning

IE Core follows [Semantic Versioning](https://semver.org/):

- **Major versions** (x.0.0): Breaking changes or significant restructuring
- **Minor versions** (x.y.0): New profiles, extensions, or value sets
- **Patch versions** (x.y.z): Bug fixes and clarifications
- **Pre-release** (-ballot, -snapshot): Work-in-progress versions for review
