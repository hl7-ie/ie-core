# Baseline audit: IE Core vs HIQA draft national standards (Sept 2026)

| | |
|---|---|
| Date | 2026-09-24 |
| Branch | `feat/hiqa-2026-alignment-c8ff80` (worktree), from `main` @ `1ff978f` |
| IG version | `hl7.fhir.ie.core` 0.1.1 (draft), FHIR 4.0.1 |
| Sources | HIQA EP draft v1.1 and HIQA PS draft (Sept 2026). See `docs/sources/hiqa-2026/README.md` |
| Scope | Read-only audit. Nothing in `input/` was changed in Phase 1. |

> Proof of Concept by Nithin Mohan. Not affiliated with HIQA, the HSE, HSE Standards or the
> Department of Health. Provided as-is.

## 1. Build and test baseline

| Check | Result | Evidence |
|---|---|---|
| SUSHI 3.18.0 (`sushi .`) | **0 errors, 1 warning** (duplicate FSH names: `IECoreEthnicity`, `IECoreGenderIdentity`, `IECoreIHIStatus`, `IECoreIHIRecordStatus`, `IECoreMedicationAdherence`) | `docs/audit/.sushi-baseline.log` (local) |
| SUSHI output | 72 profiles, 13 extensions, 0 logicals, 54 ValueSets, 10 CodeSystems, 112 instances | same |
| IG Publisher QA (`_genonce`) | **Not run.** `publisher.jar` is not installed (no `input-cache/`). No QA counts are claimed. | Requires Clarification: see open issue OI-001 |
| FHIR Validator (`tests/validator/run-validation.js`) | **Not run.** `validator_cli.jar` is not installed. | OI-001 |
| BDD (cucumber) | **121/121 scenarios, 620/620 steps passed** | `docs/audit/.bdd-baseline.log` |
| Quality checks | **449/449 passed** | `docs/audit/.quality-baseline.log` |
| SUSHI version | 3.18.0 installed. 3.20.1 is the latest stable. | SUSHI banner |

> The BDD and quality suites pass, but neither checks conformance to HIQA. A green test run says
> nothing about data minimisation or HIQA coverage (see H-10).

## 2. Inventory

| Artefact | Count | Location |
|---|---|---|
| Profiles | 72 (44 resource profiles, 9 Identifier datatype profiles, the rest vital-sign and observation variants) | `input/fsh/profiles`, `input/fsh/identifiers` |
| Extensions | 13 | `input/fsh/extensions/Extensions.fsh`, `IECoreEPrescription.fsh` |
| CodeSystems / ValueSets | 10 / 54 (the brief said 49; SUSHI reports 54) | `input/fsh/terminology` |
| CapabilityStatements | 2 (`ie-core-server`, `ie-core-client`) | `input/fsh/capability` |
| SearchParameters | 20 | `input/fsh/searchparameters` |
| TestScripts | 3 (patient read/search, encounter read) | `input/fsh/testscripts` |
| Examples (FSH) | 88 example instances (the other 24 of SUSHI's 112 are CapabilityStatements, SearchParameters and TestScripts): 8 Patient, 18 MedicationRequest, 18 MedicationDispense, 12 Medication, 2 AllergyIntolerance. **No Patient Summary Composition or Bundle example.** | `input/fsh/examples` |
| JSON / CDA payloads | 22 JSON + 2 CDA (`IE_to_DE_ePrescription_CDA.xml`, `IPS_CDA_Sample.xml`) | `input/examples` |
| Bundle profiles | **0**. ePrescription, eDispensation and Patient Summary Bundles are unprofiled. | n/a |
| Logical models | **0** | n/a |
| Pages | 23 | `input/pagecontent` |
| Cucumber features | 7 (116 scenarios declared; 121 executed incl. outlines) | `tests/features` |
| Postman | 1 collection (medication scenarios 0–6) | `input/postman` |
| R5 track | 3 profiles (Patient, Practitioner, Organization), separate SUSHI project and tests | `r5/` |
| CI | `build-ig.yml`, `pr-validation.yml` | `.github/workflows` |

## 3. Sensitive demographics usage

Full list: `docs/audit/sensitive-demographics-usage.csv` (68 occurrences), produced by
`scripts/audit/scan_sensitive_demographics.py`.

| Element | FSH profiles/extensions | FSH terminology | FSH examples | JSON/CDA | Tests/Postman | Pages/README |
|---|---|---|---|---|---|---|
| Ethnicity | 9 | 23 | 0 | 0 | 0 | 5 |
| Mother's maiden name | 7 | 0 | 0 | 0 | 0 | 3 |
| Gender identity | 8 | 6 | 0 | 0 | 0 | 3 |
| Pronouns | 3 | 0 | 0 | 0 | 0 | 0 |
| Nationality | 0 | 0 | 0 | 0 | 0 | 5 (prose) |
| Religion / marital status | 0 | 0 | 0 | 0 | 0 | 0 |

**Key point:** none of the examples, payloads, tests or Postman calls carry ethnicity or mother's
maiden name today. The risk is in the **profile**: `IECorePatient` marks both as MustSupport, and
`IECorePatient` is the only permitted `subject` of every prescription and dispense. The clean-up
work in Phase 8 is therefore small. The design change in Phase 4 is the one that matters.

## 4. Dependencies (report only)

| Package | Pinned | Latest on packages.fhir.org | Note |
|---|---|---|---|
| hl7.fhir.uv.extensions.r4 | 5.1.0 | 5.3.0 | EU MPD and EU EPS both build on 5.2.0/5.3.0 |
| hl7.fhir.eu.base | 2.0.0 | 2.0.0 | current |
| hl7.fhir.uv.ips | 2.0.0 | **2.0.1** | patch release available |
| hl7.fhir.eu.laboratory | 2.0.0 | 2.0.0 | current |
| hl7.fhir.eu.extensions | 1.3.0 | **1.3.1** | patch release available |
| hl7.fhir.eu.mpd | 1.0.0 | 1.0.0 | declared but **no IE profile derives from it** (M-01) |
| hl7.fhir.eu.hdr | 0.1.0-ballot | 0.1.0-ballot (only) | ballot dependency |
| hl7.fhir.eu.imaging | 1.0.0-ballot | 1.0.0-ballot (only) | ballot dependency, not used by the HIQA scope |
| hl7.fhir.eu.health-data-api | 1.0.0-ballot | 1.0.0-ballot (only) | ballot dependency |
| *hl7.fhir.eu.eps* | not a dependency | **1.0.0-ballot** (R4, 2026-06-06) | HL7 Europe Patient Summary. Builds on IPS 2.0.0 and EU Base 2.0.0, and adds `sectionTravelHx` (LOINC 10182-4). Input to ADR-004. |
| *xtehr.eu.ehds.models* | not a dependency | R5 (built 2026-04-13) | Xt-EHR logical models. **R5**, so it cannot be a direct dependency of this R4 IG. Input to ADR-001. |

Terminology servers: tx.fhir.org does **not** host the SNOMED CT Irish edition. The HSE CTS
(`https://nmpc.hse.ie/production1/fhir`) is reachable and reports
`http://snomed.info/sct/1601000220105/version/20260921` as its SNOMED CT edition. That matches
`aliases.fsh` (`$SCT_IE`) and **not** the `11000220105` given in the brief. Anonymous `$lookup`
failed, so this is logged as OI-004.

## 5. Findings

Severity: **CRITICAL** = legal or clinical-safety exposure in the current release;
**HIGH** = conflicts with a Mandatory/Required HIQA element or a legal requirement;
**MEDIUM** = conformance or architecture gap; **LOW** = hygiene; **INFORMATIONAL** = context.
🛑 = patient-safety concern, also logged in `docs/hiqa-2026/clinical-safety-log.md`.

### CRITICAL

**C-01. Special-category and identity data is MustSupport on every ePrescription and eDispensation.**
- Evidence: `input/fsh/profiles/IECorePatient.fsh:13` (`IECoreEthnicity ... MS`), `:14`
  (`patient-mothersMaidenName ... MS`), `:16` (`individual-pronouns ... MS`).
  `IECoreMedicationRequest.fsh:17` and `IECoreMedicationDispense.fsh:16`
  (`subject only Reference(IECorePatient)`). `IECoreEPrescription.fsh:9,89` inherit this.
- Rationale: the HIQA EP draft contains no ethnicity, mother's maiden name, nationality, marital
  status or religion (confirmed by full-text search of the EP extraction). MustSupport obliges a
  sender to populate an element when the data is known. So today the IG tells prescribing systems
  to send ethnicity, which is GDPR Art. 9 special-category data, to pharmacies, and across borders
  through MyHealth@EU, with no purpose for it in the prescription. This breaches GDPR Art. 5(1)(c)
  data minimisation and conflicts with the HIQA EP dataset. By contrast, the HIQA PS draft *does*
  include Ethnicity (PS 1.4.10, Required 0..*) and Mother's former surnames (PS 1.4.6, Required
  0..*), so the data has to be handled **per use case**, not removed globally. → ADR-002.

### HIGH

**H-01 🛑 Sex assigned at birth is conflated with administrative gender.**
- Evidence: `IECorePatient.fsh:121` (`gender 1..1 MS`, with a short of
  `male | female | other | unknown`). No `individual-recordedSexOrGender` or
  `patient-sexParameterForClinicalUse`.
- HIQA: EP 1.4.3 / PS 1.4.4 Sex (assigned at birth) is **Mandatory 1..1**. EP 1.4.4 / PS 1.4.5
  Gender (cluster) is **Required 0..1**, with a free-text "other gender identity".
- Risk: `Patient.gender` is *administrative* gender. A sending system that puts gender identity
  there leaves the receiver without sex at birth, which some dose and reference-range decisions
  depend on. Showing both side by side can also disclose a gender reassignment; the HIQA guidance
  warns about exactly this. → ADR-002.

**H-02 🛑 The IHI invariant rejects valid 10-digit IHIs.**
- Evidence: `IECorePatient.fsh:173-176` (`ie-pat-1`: `^[0-9]{18}$`, severity error). The text at
  `:43` and `Identifiers.fsh:175` says "unique 18-digit".
- HIQA EP 1.3.1 and PS 1.3.1 say a "unique 18 or 10-digit number". All 14 IHIs in the examples
  have 18 digits.
- Risk: a conformant sender with a 10-digit IHI must either fail validation or drop the IHI. Either
  way the receiver falls back to demographic matching, which raises the risk of misidentification.
  How the 18- and 10-digit forms relate (for example, whether one is a check-digit-bearing
  subset) is not stated → OI-002.

**H-03 🛑 A prescription can be issued without any allergy statement.**
- Evidence: `IECoreEPrescription.fsh` has no reference or invariant tying a MedicationRequest to
  AllergyIntolerance records or to a "reason for not recording". `IECoreAllergyIntolerance.fsh` is
  standalone.
- HIQA EP 1.6.1 "Reason for not recording allergies and intolerances" (Required 0..1, *"only
  completed if allergies or intolerances are not recorded"*) and EP 1.6.2 Allergies (Required
  0..*, P). Read together, every prescription should carry either allergies or a reason for
  having none.
- Risk: the pharmacist cannot tell "no known allergies" apart from "not asked". → Phase 5.

**H-04 🛑 The under-12 age requirement is not modelled.**
- HIQA EP 1.4.2 Age (Required 0..1, P), with 1.4.2.1 value and 1.4.2.2 type both Mandatory
  inside the cluster: *"If the date of birth indicates age is less than 12 years, then it is a
  legal requirement in Ireland to record the age of the patient on a prescription record."*
  (EP p. 30)
- Evidence: no age element or invariant in `IECorePatient.fsh` or `IECoreEPrescription.fsh`.
  Paediatric dosing safety depends on it. → Phase 4.

**H-05 🛑 Controlled-drug legal elements are missing.**
- HIQA: EP 4.2.3 MDA Schedule (Required 0..1). EP 3.5.7.2 Quantity prescribed (free text), which is
  a *"legal requirement ... if the prescribed item is a controlled drug"*. EP 3.5.12 Number of
  instalments (Required, a legal requirement for Schedule 2, 3 and 4 part 1). EP 3.5.13 Minimum
  dispense interval. EP 3.5.9.1 guidance: CD Schedule 2 and 3 prescriptions are valid for 14 days.
- Evidence: `IECoreEPrescription.fsh` has `dispenseInterval` (`:63`) but no schedule, no
  words-and-figures quantity, no instalment count and no CD validity rule. → Phase 5.

**H-06 Identifier set: several identifiers have no authoritative source (see §6).**
- Evidence: `IECorePatient.fsh:32-107`, `IECorePractitioner.fsh:17-38`,
  `IECoreOrganization.fsh:15-38`, `Identifiers.fsh`, `aliases.fsh:374-387`.
- HPI, IMN and CRN appear in neither HIQA draft. The format invariants `ie-pat-2..5` are not in
  HIQA. HAA is mislabelled: `IECorePatient.fsh:81-83` says "Hospital Appointment Access", while
  HIQA EP 1.3.3.1 defines HAA as the *Health Amendment Act card scheme*. DPS and LTI are typed
  `v2-0203#JHN` "Jurisdictional health number (Canada)" (`:66,:76`). All `sid/*` systems are
  minted under the IG's own canonical, so no Irish authority issued them. The project owner has
  said this set may have come from a cybersquatted hl7.ie website. → ADR-006.

**H-07 Practitioner registration (Mandatory) is not enforced, and only IMC is modelled.**
- HIQA EP/PS 2.6 Health practitioner registration (**Mandatory 1..1**): 2.6.1 body type (M) and
  2.6.2 value (M), covering IMC (MCRN), PSI, and NMBI RNP/RMP divisions. The EP definitions also
  name dentists.
- Evidence: `IECorePractitioner.fsh:17-38` has HPI and IMC slices only, both 0..1.
  `IECoreEPrescription.fsh:39` lets `requester` be an Organization, so a prescription can have no
  registered prescriber at all.

**H-08 Cross-border legal requirements are not enforced, and the signature is not modelled.**
- HIQA EP 1.4.1 (DOB; a legal requirement on cross-border prescriptions), EP 2.10.1 and 2.10.2
  (prescriber telephone and secure email; legal requirements cross-border), EP 2.13 Signature
  (Required 0..1; a legal requirement for prescriptions issued in another Member State and
  dispensed in Ireland).
- Evidence: there are no Bundle profiles, no signature element, and no cross-border flag or
  invariant anywhere in `input/fsh`.

**H-09 Pharmacy and facility identifiers are missing.**
- HIQA EP 2.8 facility identifier (the PSI RPB number for pharmacies), 2.9.1 facility postcode
  (Eircode; **Mandatory 1..1**), 2.11 GLN (13 digits with a GS1 check digit), 2.12 GMS Panel ID.
- Evidence: `IECoreOrganization.fsh` has only the CRN and HPI slices. `address.postalCode` is MS,
  not 1..1. `IECoreLocation.fsh` has no GLN.

**H-10 No traceability from IG to HIQA, and no tests for it.**
- There are no logical models, mappings or tests linking an IE Core element to a HIQA element ID.
  The 121 passing BDD scenarios cannot detect a HIQA regression.

### MEDIUM

**M-01 ePrescription profiles do not build on HL7 Europe MPD 1.0.0, although it is a declared dependency.**
- Evidence: `IECoreMedicationRequest.fsh:2` and `IECoreMedicationDispense.fsh:2` use base R4
  parents. `IECoreEPrescription.fsh:164-181` defines its own `IECoreOffLabelUse`, while
  `MedicationRequest-eu-mpd` already uses the IHE `ihe-ext-offLabel`. `MedicationDispense-eu-mpd`
  requires `extension:recorded` 1..1, which matches HIQA EP 6.2 "Date and time of issuing the
  dispense record" (Mandatory). → ADR-003.

**M-02 The Patient Summary Composition derives from base `Composition`, not IPS or EU EPS, and has no Bundle profile.**
- Evidence: `IECorePatientSummary.fsh:7`. All section LOINC codes match IPS 2.0.0 except
  `travelHistory` 10182-4, which is sourced from `hl7.fhir.eu.eps` 1.0.0-ballot. HIQA PS 3
  (nominated contact person), PS 11 (patient-provided data) and PS 12 (social context, as HIQA
  structures it) are not represented. `subject only Reference(IECorePatient)` (`:19`). → ADR-004.

**M-03 Dispense-to-prescription link: the IG is stricter than HIQA.**
- `IECoreEPrescription.fsh:113` has `authorizingPrescription 1..*`. HIQA EP 6.5 "Prescription item
  identifier with related request" is **Required 0..1** (checked against page coordinates). The
  brief asks for 1..1. This needs a decision in ADR-003: whether 1..1 is justified by the scope
  statement ("a dispense ... based on a prescription", EP p. 15), or whether it blocks emergency
  supply.

**M-04 The ethnicity CodeSystem probably does not match the current CSO classification.**
- Evidence: `CodeSystems.fsh` `ie-core-ethnicity-codes` has both `irish-traveller` and
  `white-irish-traveller`, a bare `roma`, and no Asian Indian/Pakistani/Bangladeshi or Arab
  categories. The extension binding is `required` (`Extensions.fsh:16`). To verify against CSO in
  Phase 7 (OI-005).

**M-05 Dosage consistency.**
- `IECoreEPrescription.fsh:49` sets `dosageInstruction.text 1..1`, which is a good safety fallback,
  but nothing checks that it agrees with the structured dosage. HIQA EP 5.1 Rendered dosage
  instruction is Optional and 5.2 Dosage details is Required. The EP 5.2.3/5.2.4 structure
  (dose/rate, frequency, period, day, time, event, as-needed, body site) is not constrained.

**M-06 CI supply chain and least privilege.**
- `build-ig.yml:10-13` grants `pages: write` and `id-token: write` to **every** job. Actions are
  pinned by tag (`@v4`), not SHA. `npm install -g fsh-sushi` is unpinned. The publisher is
  `releases/latest/download/publisher.jar` (`:340-343`), unpinned. There is no package cache and no
  Dependabot.

**M-07 There is no QA baseline to gate on (process).**
- The definition of done ("QA errors not higher than baseline") cannot be enforced until the IG
  Publisher runs locally or in CI and its counts are stored. → OI-001.

**M-08 Ballot-status dependencies in a published IG.**
- `hl7.fhir.eu.hdr` 0.1.0-ballot, `hl7.fhir.eu.imaging` 1.0.0-ballot and
  `hl7.fhir.eu.health-data-api` 1.0.0-ballot. None is needed for the HIQA EP or PS scope.
  Informs the release decision.

### LOW

- **L-01** Pronouns (`IECorePatient.fsh:16`) and interpreter required (`:17`) are MustSupport.
  Pronouns appear in neither HIQA dataset. Interpreter needs map at best to PS 1.4.9 Preferred
  language (Optional).
- **L-02** Duplicate FSH entity names cause the one SUSHI warning.
- **L-03** Hard-coded `^version = "0.1.0"` on some profiles (e.g. `IECoreMedicationRequest.fsh:8`)
  while the IG is at 0.1.1. `pin-canonicals: pin-all` plus stale versions risks confusion.
- **L-04** Unused aliases: `$Eircode`, `$NePS`, `$EIDASPatientID`, `$NCPeHOrgID`. The OIDs are
  unverified.
- **L-05** Test tooling: `npm ci` warns about the deprecated `glob@10.5.0`.

### INFORMATIONAL

- **I-01** Anomalies in the HIQA drafts, kept as published: EP 1.6.x.x provenance author/date are
  "Mandatory 0..*" / "Mandatory 0..1". PS 13.3.2, 15.2.1 and 19.1.12.x are "Mandatory 0..1".
  PS 16.2 is "Required 1..1". PS 4.4.6 (should presumably be 4.3.6) and PS 6.3.11.1 have no
  6.3.11 parent. PS 6.3 Medication record entry is **0..1**, so only one medication can be
  recorded, which looks like an error. Table 3 examples use numbering that differs from the
  dataset (EP 3.5.8 Validity period vs dataset 3.5.9.1; PS 13.1.1 vs 8.2.2). → OI-006; feedback
  in Phase 11.
- **I-02** HIQA coded values are not specified ("Coded values have not yet been specified in this
  standard"), EP p. 18 and PS p. 15. Every binding we choose is our own and must be labelled
  that way.
- **I-03** The committed HIQA material is limited to structural metadata. The PDFs and prose stay
  out of git for copyright reasons.

## 6. Identifier review (requested by the project owner)

Each identifier is checked against the HIQA text. **Keep** = HIQA names it. **Re-scope** = HIQA
covers it only as an "other identifier" example, so it stays but without invented formats.
**Remove** = no HIQA basis.

| Identifier | Where in IG | HIQA basis | Verdict |
|---|---|---|---|
| IHI | Patient slice, `IECoreIndividualHealthcareIdentifier` | EP/PS 1.3.1, Required 0..1, "18 or 10-digit" | **Keep**, fix the 18/10-digit rule (H-02). System URI → OI-003 |
| PPSN | alias only (`$PPS`), used in 12 JSON payloads | EP/PS 1.3.2, Required 0..1 | **Add** as a slice, **no MS**, "Requires Clarification" (legal basis for health use) |
| GMS / medical card, GP visit card, DPS, LTI, HAA | Patient slices, with format invariants `ie-pat-2..5` | EP/PS 1.3.3.1 lists them only as *examples* of a PCRS number | **Re-scope** into one typed "other identifier (PCRS scheme)" pattern. **Drop** the format invariants and the wrong labels (HAA, JHN "Canada"). |
| MRN | Patient slice | EP/PS 1.3.3.1 example | **Re-scope** into the generic "other identifier" (assigner-specific system), not an IG-minted `sid/mrn` |
| IMN (immunisation number) | Patient slice | none | **Remove** |
| HPI (practitioner) | Practitioner slice | none (2.6 is professional-body registration) | **Remove** |
| HPI (organisation) | Organization slice | none (2.8 is a facility identifier: PSI RPB for pharmacies) | **Remove**. Replace with PSI RPB number and GLN. |
| IMC | Practitioner slice | EP/PS 2.6.1/2.6.2 (e.g. "six-digit MCRN") | **Keep** as one of the registration slices |
| PSI, NMBI (RNP/RMP), Dental Council registration | absent | EP/PS 2.6 (PSI "up to eight digits"; RNP/RMP division) | **Add**. Format rules only where HIQA states them; otherwise Requires Clarification. |
| CRN (Companies Registration Office) | Organization slice | none | **Remove** |
| PSI RPB number, GLN, GMS Panel ID | absent | EP/PS 2.8, 2.11, 2.12 | **Add** (GLN: 13 digits with a GS1 mod-10 check) |
| NePS prescription (group) identifier | alias `$NePS`, unused | EP 3.1 | **Keep**. System URI → OI-003 |
| eIDAS / NCPeH OIDs, `$Eircode` | unused aliases | none | **Remove** (L-04) |

Removing identifier slices is a **breaking change**, so it goes through an ADR (ADR-006) and is
implemented only after Checkpoint 1.
