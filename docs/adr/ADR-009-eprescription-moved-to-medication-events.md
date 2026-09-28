# ADR-009: ePrescription and eDispensation moved to IE Medication Events

- **Status:** Accepted (project owner, 2026-09-28). **BREAKING.**
- **Date:** 2026-09-28
- **Supersedes:** the ePrescription parts of ADR-002 and ADR-003
- **Related:** ADR-008 (package id), hl7-ie/medication-events ADR-001 and ADR-002

## Context

IE Core 0.2.0 carried two HIQA draft standards: *Electronic Prescriptions and Electronic Dispensations* (EP) and
*Patient Summary* (PS). The EP work was copied into a separate IG, IE Medication Events
(`hl7-ie/medication-events`, package `nostalgic-ie.fhir.medication-events`), which also profiles medication
administration and medication statements. Keeping two copies of the EP profiles would let them drift, and IE Core
would carry use-case content that is not "core".

## Requirements

- IE Core stays a base IG: demographics, providers, clinical building blocks, the Patient Summary and the discharge
  report.
- Nothing HIQA EP is lost: it must exist in IE Medication Events before it is removed here.
- Identifier system URIs keep one owner, so an identifier is written the same way in every Irish IG.

## Options

| Option | Advantages | Disadvantages | Risks | Cost | Operational impact | GDPR/EHDS impact |
|---|---|---|---|---|---|---|
| A. Keep EP in both IGs | No breaking change | Two copies drift | Conflicting rules for the same prescription | Ongoing | Every EP change made twice | None |
| B. IE Medication Events depends on IE Core's EP profiles | One copy | IE Core keeps use-case content | Release coupling | Low | Coordinated releases | None |
| **C. Remove EP from IE Core; IE Medication Events owns it** | IE Core is clean; one owner per rule | Breaking for IE Core users of the EP profiles | Users must switch packages | One-off | Clear ownership | EP data minimisation now enforced in IE Medication Events |

## Decision

Option C (project owner, 28 September 2026: "EP/ED only"; "generic base only").

**Removed from IE Core:**
- Profiles: `IECoreMedicationRequest`, `IECoreMedicationDispense`, `IECoreMedicationRequestEPrescription`,
  `IECoreMedicationDispenseEDispensation`, `IECoreMedicationEPrescription`, `IECorePatientEPrescription`,
  `IECoreBundleEPrescription`, `IECoreBundleEPrescriptionCrossBorder`, `IECoreListAllergiesAtPrescribing` and
  `IECoreProvenanceEPrescriptionSignature`, with their invariants (`ie-rx-*`, `ie-md-*`, `ie-bnd-*`, `ie-list-allergy-1`).
- EP-only extensions (age at prescribing, quantity in words and figures, number of instalments, do not extend,
  interchangeable, exempt item, dispense receiver) and placeholders (MDA schedule, supply legal status).
- The HIQA EP logical model, mapping and traceability; the MedicationRequest search parameters; the EP entries
  in the CapabilityStatements.
- EP examples (HIQA scenarios 1–6, the medication scenarios, the cross-border examples), the cross-border
  payloads, the CDA ePrescription and the Postman collection; the cross-border ePrescription and Irish ePrescription
  legislation pages; the EP tests and the EP data-minimisation guard.
- The `hl7.fhir.eu.mpd`, `ihe.pharm.mpd.r4` and `hl7.fhir.extensions.r5` dependencies, which only the EP profiles used.

**Kept in IE Core:**
- The HIQA Patient Summary alignment, unchanged.
- Generic `IECoreMedication` and `IECoreMedicationStatement` (the Patient Summary medication section uses them).
- All NamingSystems and identifier system URIs, including NePS: IE Medication Events uses IE Core's URIs.
- The Hospital Discharge medication sections now accept `IECoreMedicationStatement` or a base `MedicationRequest`.
- Example patients and medicines still used elsewhere now claim the base `IECorePatient` / `IECoreMedication`.
- Open-issue numbers: EP-only issues are marked as moved, not renumbered.

## Consequences

- IE Core 0.3.0 is breaking for anyone using the EP profiles, invariants or examples: use
  `nostalgic-ie.fhir.medication-events` (`IEMpd*` profiles, canonical `https://hl7-ie.github.io/medication-events/fhir`).
- The EHDS ePrescription and eDispensation categories are out of scope for IE Core.
- HIQA EP traceability, data minimisation and clinical-safety tracking continue in IE Medication Events.
- The docs under `docs/audit/`, the release notes for 0.2.0 and ADR-002/ADR-003 remain as historical records.
