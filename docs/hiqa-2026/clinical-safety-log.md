# Clinical safety log: HIQA 2026 alignment

A hazard log for the IE Core IG. The IG is a proof of concept, not a medical device and not a
live service. This log records specification-level hazards that an implementer would inherit.
Risk ratings are qualitative (Low / Medium / High) and use the author's judgement. They have not
been reviewed by a clinical safety officer.

| Field | Meaning |
|---|---|
| Hazard | What could go wrong for a patient |
| Cause | The specification defect that allows it |
| Effect | Possible harm |
| Mitigation | The change to the IG (with phase or ADR) |
| Residual | Risk after mitigation, and what the IG cannot control |

---

## HZ-01. Sex assigned at birth not reliably available to the dispenser

- **Status:** Mitigated (Phase 4). `extension[sexAssignedAtBirth]` is 1..1 MS in both use-case patient profiles. Identified in the Phase 1 baseline (H-01).
- **Hazard:** a dose or appropriateness check uses the wrong sex.
- **Cause:** `IECorePatient.gender` (administrative gender) is the only sex/gender element. There is
  no separate "sex assigned at birth" (HIQA EP 1.4.3 / PS 1.4.4, Mandatory).
- **Effect:** a sex-dependent dosing or contraindication check (e.g. some teratogenic medicines) is
  based on administrative gender or gender identity.
- **Mitigation (planned, ADR-002):** model sex assigned at birth separately and as Mandatory. Model
  gender identity in the HIQA Gender cluster. Add guidance that sex for clinical use is a
  clinical-system concern.
- **Residual:** Medium. The sending system must record sex at birth correctly. Showing sex at birth
  next to gender can disclose a gender reassignment; display is a receiver concern (privacy
  guidance in `security.md`).

## HZ-02. Valid 10-digit IHI rejected, causing a fallback to demographic matching

- **Status:** Mitigated (Phase 4): `ie-pat-1` accepts 18 or 10 digits. OI-002 is still open for the check-digit rule (H-02).
- **Hazard:** the patient is misidentified at the pharmacy, or the prescription is attached to the
  wrong record.
- **Cause:** invariant `ie-pat-1` accepts only 18 digits. HIQA EP/PS 1.3.1 allow 18 or 10.
- **Effect:** the sender drops the IHI, and matching relies on name, DOB and address only.
- **Mitigation (planned, ADR-002/006):** accept 18 **or** 10 digits. Record the format question in
  consultation feedback.
- **Residual:** Low. It depends on HSE confirming the 10-digit form (OI-002).

## HZ-03. Prescription issued with no allergy statement

- **Status:** Open (H-03).
- **Hazard:** a medicine the patient is allergic to is dispensed.
- **Cause:** there is no link or rule tying a prescription to allergy records or to "reason for not
  recording allergies" (HIQA EP 1.6.1 / 1.6.2).
- **Effect:** the pharmacist cannot tell "no known allergies" from "not asked", which weakens the
  final safety check.
- **Mitigation (planned, Phase 5):** each ePrescription carries either allergy entries or an
  explicit reason for their absence (design in ADR-003).
- **Residual:** Medium. The IG can require that a *statement* is present, not that it is correct.

## HZ-04. Paediatric age missing on prescriptions for children under 12

- **Status:** Partly mitigated (Phase 4): `IECorePatientAgeAtPrescribing` + invariant `ie-rx-age-1` on the prescription (resolves the subject within the Bundle). The Bundle-level enforcement lands in Phase 5 (H-04).
- **Hazard:** a paediatric dosing error.
- **Cause:** there is no age element or rule. HIQA EP 1.4.2 says age is a legal requirement when
  the patient is under 12.
- **Effect:** the dispenser relies on working out age from DOB, or on DOB alone.
- **Mitigation (planned, Phase 4):** a conditional invariant on ePrescription (age value and unit
  present when DOB shows the patient is under 12 at `authoredOn`).
- **Residual:** Low. FHIRPath age calculation at month resolution is approximate. The IG requires
  the stated age; it cannot verify it.

## HZ-05. Controlled-drug legal safeguards not captured

- **Status:** Open (H-05).
- **Hazard:** a controlled drug is over-supplied or diverted; an invalid CD prescription is
  dispensed.
- **Cause:** there is no MDA schedule (EP 4.2.3), no words-and-figures quantity (EP 3.5.7.2), no
  instalment count (EP 3.5.12), and no 14-day CD validity rule (EP 3.5.9.1 guidance).
- **Mitigation (planned, Phase 5):** add these elements, plus invariants that fire when the MDA
  schedule is 2, 3 or 4 part 1 (codes Requires Clarification; see OI-007).
- **Residual:** Medium until an authoritative MDA schedule code system exists.

## HZ-06. Identity matching after removing mother's maiden name from prescriptions

- **Status:** Accepted residual risk (Phase 4): mother's maiden name is 0..0 in `IECorePatientEPrescription`.
- **Hazard:** misidentification when no IHI is present.
- **Cause:** mother's maiden name is a traditional disambiguator. HIQA EP does not include it, so it
  will be prohibited in the ePrescription profile.
- **Mitigation:** the IHI (when available) plus DOB, forename, surname and address. HIQA EP 1.1.2,
  1.1.3, 1.2.2, 1.2.4 and 1.4.1 are Mandatory, so these are always present. Guidance to use the
  IHI wherever one exists.
- **Residual:** Low. The same data set is legally sufficient for paper prescriptions today.
