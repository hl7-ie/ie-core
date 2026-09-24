# ADR-006: Identifier rationalisation (remove unsourced identifiers)

- **Status:** Accepted (Checkpoint 1, 2026-09-24). **BREAKING.**
- **Date:** 2026-09-24
- **Trigger:** the project owner (2026-09-24) flagged that the identifier set may have come from a
  cybersquatted hl7.ie website, and asked for the irrelevant ones to be removed.
- **Related:** baseline H-06, H-07, H-09, L-04 and §6; ADR-002 (IHI, PPSN); OI-002, OI-003

## Context

IE Core defines ten identifiers (IHI, HPI, IMC, MRN, GMS, DPS, LTI, HAA, IMN, CRN) as Patient,
Practitioner and Organization slices, as nine Identifier datatype profiles in `Identifiers.fsh`,
and as `sid/*` aliases. Several have **no authoritative source**:

- **HPI, IMN, CRN** appear in neither HIQA draft.
- The format invariants `ie-pat-2..5` (GMS 7 digits + 1 letter; DPS and LTI 7 digits + 1–2 letters;
  HAA 8–10 alphanumerics) are not in HIQA.
- **HAA** is labelled "Hospital Appointment Access". HIQA EP 1.3.3.1 says *Health Amendment Act*
  card scheme.
- DPS and LTI are typed `v2-0203#JHN` "Jurisdictional health number (Canada)".
- Every `system` URI is minted under this IG's own canonical. No Irish authority issued them.

HIQA does name: IHI (1.3.1), PPSN (1.3.2), the "other identifiers" cluster (1.3.3, with PCRS scheme
numbers, GP record number, MRN, NHS number, EHIC and private insurance as *examples*), practitioner
registration with a professional body (2.6: IMC/MCRN, PSI, NMBI RNP/RMP), the facility identifier
(2.8: PSI Retail Pharmacy Business registration), GLN (2.11: 13 digits, GS1 company prefix +
location reference + check digit), the GMS Panel ID (2.12) and the NePS prescription (group)
identifier (3.1).

## Options

| | Keep all (status quo) | **Rationalise to HIQA-sourced identifiers** | Remove all IE identifier slices |
|---|---|---|---|
| Advantages | No breaking change | Every identifier traces to HIQA; invented formats and labels go; adds the missing Mandatory registration | Nothing unsourced remains |
| Disadvantages | Publishes unsourced, partly wrong rules | Breaking; placeholder `system` URIs remain for the kept ones (OI-003) | Loses IHI; cannot meet HIQA 1.3.1 or 2.6 |
| Risks | Implementers build to invented formats → false validation failures (safety: HZ-02 pattern) | Existing data using removed slices still validates (open slicing), but loses MS | Non-conformance |
| Cost | none | Medium | Low |
| GDPR / EHDS | Neutral | PPSN handled cautiously (no MS) | — |

## Decision (recommended): rationalise

| Identifier | Action | New modelling | Source |
|---|---|---|---|
| IHI | **Keep, fix** | slice on Patient; `^([0-9]{18}\|[0-9]{10})$` | EP/PS 1.3.1 |
| PPSN | **Add** (use-case profiles) | slice 0..1, **no MS**; warning invariant `^[0-9]{7}[A-Za-z]{1,2}$` ("seven numbers followed by either one or two letters") | EP/PS 1.3.2; OI-008 |
| GMS (medical card), GP visit card, DPS, LTI, HAA | **Re-scope** | slices and datatype profiles **removed**. Carried as generic "other identifier" (1.3.3) with `type` + `system` + `assigner.display` = "HSE" (HIQA's example). **Format invariants `ie-pat-2..5` deleted.** A `IECorePCRSSchemeType` ValueSet with the scheme names from HIQA's text (placeholder CodeSystem, Requires Clarification) | EP/PS 1.3.3.1 (examples only) |
| MRN | **Re-scope** | generic other identifier: `type` = v2-0203 `MR` (a real code), `system` = the issuing facility's own namespace (no IG-minted `sid/mrn`) | EP/PS 1.3.3.1 |
| IMN | **Remove** | — | none |
| HPI (practitioner and organisation) | **Remove** | — | none |
| CRN | **Remove** | — | none |
| IMC | **Keep** | registration slice (below) | EP/PS 2.6 |
| PSI, NMBI, Dental Council | **Add** | Practitioner `identifier` slices by `system`: `IMC`, `PSI`, `NMBI`, `DentalCouncil`. The EP profile adds an invariant: **at least one registration identifier** (EP 2.6 Mandatory 1..1). Formats: PSI "up to eight digits" (from the HIQA text) as a warning; MCRN "six-digit" is an example in HIQA ("For example, a General Practitioner's …"), so it is **not** enforced; NMBI and Dental Council formats Requires Clarification | EP/PS 2.6.1, 2.6.2 |
| PSI Retail Pharmacy Business (RPB) number | **Add** | Organization `identifier` slice `PSIRPB` | EP/PS 2.8 |
| GLN | **Add** | Location `identifier` slice `GLN`, system **`http://www.gs1.org/gln`**: the preferred URI of HL7 Terminology `NamingSystem/GLN` (active; OID 1.3.88), verified in hl7.terminology.r4 7.4.0. Invariant: 13 digits + GS1 mod-10 check digit | EP/PS 2.11 |
| GMS Panel ID | **Add** | Organization `identifier` slice, no format rule ("typically a five- to six-digit number") | EP/PS 2.12 |
| NePS (group) identifier | **Keep** | `groupIdentifier` / `identifier` systems; URI placeholder | EP 3.1; OI-003 |
| `$Eircode`, `$EIDASPatientID`, `$NCPeHOrgID` aliases | **Remove** (unused, unsourced OIDs) | — | none |

All kept or added `system` URIs stay under the IG canonical, each with a NamingSystem whose
description says **"placeholder pending an HSE-published URI"** (OI-003). The GLN is the one
exception: it uses the external GS1 URI from HL7 Terminology.

## Consequences

- **BREAKING:** removed slices and profiles: `IECoreHealthServiceProviderIdentifier`,
  `IECoreInsuranceMemberNumber`, `IECoreCompanyRegistrationNumber`,
  `IECoreGeneralMedicalService`, `IECoreDrugsPaymentScheme`, `IECoreLongTermIllness`,
  `IECoreHealthAmendmentAct`; Patient slices `GMS`, `DPS`, `LTI`, `HAA`, `IMN`; Practitioner `HPI`;
  Organization `HPI`, `CRN`. Invariants `ie-pat-2..5` deleted.
- Examples and payloads using `sid/crn` (10), `sid/gms` (12), `sid/hpi` (1), `sid/imn` (1),
  `sid/dps` (1), `sid/lti` (1) and `sid/haa` (1) are migrated in Phase 8.
- `IECoreIndividualHealthcareIdentifier` and `IECoreMedicalRecordNumber` are kept (the latter
  without a fixed system).
- The `ie-core-v2-0203-extended` ValueSet is reviewed in Phase 7.
