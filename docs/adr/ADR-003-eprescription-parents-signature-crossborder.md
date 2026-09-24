# ADR-003: ePrescription/eDispensation parents, signature and cross-border flag

- **Status:** Accepted (Checkpoint 1, 2026-09-24). **BREAKING.**
- **Date:** 2026-09-24
- **Related:** baseline M-01, M-03, H-03, H-05, H-08; hazards HZ-03, HZ-05; ADR-002

## Context

`IECoreMedicationRequest`, `IECoreMedicationDispense` and `IECoreMedication` derive from base R4.
`hl7.fhir.eu.mpd` 1.0.0 is declared as a dependency but not used. There is no Bundle profile, no
signature model and no way to tell a cross-border prescription apart. The cross-border payloads tag
Bundles with `http://ehealth.ec.europa.eu/fhir/tag#xt-ehr` (and `v3-ActCode#PBILLACCT`, a
billing-account code). I found **no source** for that tag system, so it must go (see the
guardrail on invented URIs).

### What the packages actually contain (inspected 2026-09-24)

| Package | Relevant profiles | Hard constraints |
|---|---|---|
| `hl7.fhir.eu.mpd` 1.0.0 (R4) | `MedicationRequest-eu-mpd`, `MedicationDispense-eu-mpd`, `Medication-eu-mpd` (on `medication-eu-core`), `Dosage-eu-mpd`. **No Bundle, no Provenance.** | MR: `authoredOn 1..*`, `requester 1..*`, IHE `ihe-ext-offLabel`, R5-backport `renderedDosageInstruction` and `effectiveDosePeriod`, IHE `prescribedQuantity`. MD: `extension:recorded 1..1` (R5 backport), `quantity 1..*`. Depends on `ihe.pharm.mpd.r4` 1.0.0-comment-2 |
| `hl7.fhir.uv.ips` 2.0.0 | `MedicationRequest-uv-ips`, `MedicationStatement-uv-ips` | built for the *medication summary* in a PS, not for prescribing workflow |

### SUSHI trial build (scratch copy, re-parenting only)

| Trial | SUSHI errors | Nature |
|---|---|---|
| MR, MD and Medication → EU MPD 1.0.0 | **38** | 2 profile-level: (1) slice name `offLabelUse` already defined by MPD, so our custom `IECoreOffLabelUse` clashes; (2) `authorizingPrescription` must reference an MPD-derived MedicationRequest. **36 are examples:** 18 dispenses lack the mandatory `extension:recorded`, which is exactly HIQA EP 6.2 (Mandatory) |

Validator-level conflicts (slicing, bindings) were not tested because the IG Publisher and
validator are not installed (OI-001). They will surface in Phase 5 once available.

## Options: parents

| | A. Base R4 (status quo) | **B. HL7 Europe MPD 1.0.0** | C. IPS 2.0.0 |
|---|---|---|---|
| Advantages | Full freedom; no dependency churn | EHDS-aligned for the same priority category; gives HIQA EP 6.2 (`recorded`), 3.5.14 (off-label), 3.5.6 (`effectiveDosePeriod`), 5.1 (`renderedDosageInstruction`) for free; cross-border receivers will expect it | Aligned with the PS medication summary |
| Disadvantages | Re-invents what MPD standardises; custom off-label extension | Pulls in `ihe.pharm.mpd.r4` (a comment-ballot label) and R5-backport extensions; MPD may revise | Not designed for prescribing and dispensing workflow (no dispense profile) |
| Risks | Divergence from the EU format → NCPeH transformation burden | MPD 1.x revisions → re-test; mitigated by the pinned version | Wrong semantics |
| Cost | none | Medium: 2 profile fixes + add `recorded` to 18 examples | Medium, with a poor fit |
| Operational impact | Transformation at the NCPeH | Less transformation | n/a |
| GDPR / EHDS impact | Neutral | **Positive**: EHDS priority category, EU format | Neutral |

**Recommendation: B.** The IE profiles re-parent onto MPD. The IE-specific constraints previously
inherited from `IECoreMedicationRequest` and `IECoreMedicationDispense` (subject profile,
medication binding, status 1..1) are restated in the ePrescription profiles. The base
`IECoreMedicationRequest` and `IECoreMedicationDispense` stay for non-ePrescription use (e.g. an
inpatient medication record) and are unchanged. `IECoreOffLabelUse` is **retired** in favour of
MPD's IHE `ihe-ext-offLabel`, whose shape (boolean + reason) matches EP 3.5.14.

## Options: signature (EP 2.13, a legal requirement for inbound cross-border prescriptions)

| | Bundle.signature | **Provenance.signature (target = the prescription items)** | Both, one mandatory |
|---|---|---|---|
| Advantages | One signature over everything; simple | Survives storage in NePS and re-bundling by the NCPeH; signs exactly the clinical content; `agent` = prescriber; FHIR's intended pattern for attesting authorship | Flexibility |
| Disadvantages | Breaks when a NePS or NCPeH re-bundles or transforms; canonicalisation of a large Bundle | One extra resource; versioned target references needed | Ambiguity about which is authoritative |
| Risks | Signature invalid after legitimate transformation | Target version drift; mitigated by requiring `_history` versioned references | Receivers verify the wrong one |
| GDPR / EHDS | same | same | same |

**Recommendation: `IECoreProvenanceEPrescriptionSignature`**: `target` 1..* (every MedicationRequest
in the prescription), `recorded` 1..1, `agent` (prescriber) 1..1, `signature` 1..1 with
`type` from the FHIR signature-type ValueSet. `Bundle.signature` stays allowed but is not required.
**Requires Clarification (OI-009):** the signature format and eIDAS assurance level NePS and
MyHealth@EU will require (e.g. AdES). HIQA says only "electronic or digital signature".

## Options: flagging a cross-border prescription

| | Invented `meta.tag` (status quo) | `meta.tag` from an IE Core CodeSystem | **Separate cross-border Bundle profile, claimed in `meta.profile`** |
|---|---|---|---|
| Advantages | none: unsourced URI | Local and honest | Standard FHIR conformance mechanism; the legal constraints live **in** the profile; no new codes |
| Disadvantages | Invented; must be removed | A second place to keep in sync with the constraints | The sender (NePS or NCPeH) must claim it |
| **Recommendation** | remove | — | **✓** |

- `IECoreBundleEPrescription` (`type = collection`): entries are one `IECorePatientEPrescription`,
  1..* `IECoreMedicationRequestEPrescription`, the prescriber `IECorePractitioner` +
  `IECorePractitionerRole`, `IECoreOrganization`, `IECoreMedicationEPrescription`, and the allergy
  statement List (below).
  - Invariants: all MedicationRequests share one `groupIdentifier` when there is more than one
    item (EP 3.1). The under-12 age rule (ADR-002). Each MedicationRequest's `supportingInformation`
    includes the allergy List.
- `IECoreBundleEPrescriptionCrossBorder` (parent the above) adds the legal requirements:
  - Patient `birthDate` present (EP 1.4.1; already 1..1)
  - prescriber telecom has `system=phone` **and** `system=email` (EP 2.10.1, 2.10.2)
  - `IECoreProvenanceEPrescriptionSignature` present, covering every MedicationRequest (EP 2.13).

## Consequential decisions (Phase 5), for approval now

| Topic | HIQA | Recommendation | Rationale |
|---|---|---|---|
| Dispense → prescription link | EP 6.5 **Required 0..1** | `authorizingPrescription` **1..1** in `IECoreMedicationDispenseEDispensation` only; the base `IECoreMedicationDispense` stays 0..* | The standard's "immediate scope ... is a dispense ... based on a prescription" (EP p. 15). Emergency supply (no prescription) uses the base profile. **Stricter than HIQA**, recorded as a deliberate deviation and raised in the consultation feedback |
| Allergy statement with the prescription (EP 1.6.1 / 1.6.2) 🛑 | Required | New `IECoreListAllergiesAtPrescribing` (List, `code` = LOINC 48765-2 as used by the IPS allergy section), **1..1 per ePrescription Bundle**. Invariant: `entry.exists() xor emptyReason.exists()`. `emptyReason` bound to HL7 `list-empty-reason` (verified: nilknown, notasked, withheld, unavailable, …). Each MR's `supportingInformation` references it (MS) | `List.emptyReason` is the FHIR-native "reason for not recording" (EP 1.6.1). This closes HZ-03: a prescription cannot validate without an allergy statement. "No known allergy" = `emptyReason=nilknown`, or an AllergyIntolerance with SNOMED CT 716186003 (verified, active) |
| Repeats dispensed | *not a HIQA element* (HIQA has 3.5.11 repeats allowed, 3.5.12 instalments) | **Derived**, not stored: count the `completed` MedicationDispense records with the same `authorizingPrescription`. Documented as a search (`MedicationDispense?prescription=`) | One source of truth; a stored counter drifts and races when two pharmacies are involved. Raised in the feedback |
| Controlled drug indicator | EP 4.2.3 MDA Schedule (Required, auto-populated from NMPC) | Extension on **Medication** (`IECoreMisuseOfDrugsSchedule`, CodeableConcept) bound to a **placeholder** CodeSystem (Schedules 1, 2, 3, 4 Part 1, 4 Part 2, 5 per S.I. 173/2017, as cited by HIQA). **Requires Clarification** (OI-007: NMPC/HPRA code system). Bundle-level invariants fire for Schedules 2, 3 and 4 Part 1: words-and-figures quantity (EP 3.5.7.2), instalments (EP 3.5.12), and validity ≤ 14 days for Schedules 2 and 3 (EP 3.5.9.1) | It is a product property (HIQA marks it `#` auto-populated), not a per-prescription choice |
| Prescription-level status (EP 3.3) | Mandatory | Carried on **each item** (`status`, `statusReason`) and **derived** for the whole prescription (all items `completed` → complete; any `active` → active; otherwise inactive). Documented; no container resource | R4 and MPD have no prescription-header resource; RequestGroup is not used by MPD. Raised in the feedback |
| Acute vs repeat | not a distinct HIQA element | `courseOfTherapyType` MS (acute / continuous), plus `numberOfRepeatsAllowed` (EP 3.5.11) | Brief requirement; standard FHIR element |
| Dosage safety fallback | EP 5.1 Optional, 5.2 Required | Keep `dosageInstruction.text 1..1`. New invariant: if `timing` or `doseAndRate` is present then `text` is present (always true while text is 1..1; the rule is kept so the intent survives a later relaxation) | A human-readable instruction must always accompany the structured form |

## Consequences

- **BREAKING:** ePrescription profiles change parent; `IECoreOffLabelUse` is retired; dispenses
  must carry `recorded`; ePrescription Bundles must carry an allergy statement; the cross-border
  profile needs a signature Provenance.
- The invented cross-border tag is removed from all payloads (Phase 8).
- CapabilityStatements gain the Bundle, List and Provenance profiles, plus the
  `MedicationDispense?prescription=` search that repeats-dispensed depends on.
