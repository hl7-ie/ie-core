# Responses to the independent review (Phase 10)

Review: `docs/audit/review-hiqa-2026.md` (read-only subagent, no knowledge of the implementation). No CRITICAL
findings. Every HIGH finding is fixed; MEDIUM and LOW findings are fixed where cheap, otherwise logged.

| ID | Severity | Response | Where |
|---|---|---|---|
| R-01 | HIGH | **Fixed.** `medication[x]` only `Reference(IECoreMedicationEPrescription)` (HIQA 4.7.2 ingredient is Mandatory anyway). 2 FSH prescriptions and 20 payload prescriptions converted. A standalone MedicationRequest still cannot resolve its Medication; the rules are complete in Bundle context (OI-027) | `IECoreEPrescription.fsh`, ADR-003 addendum |
| R-02 | HIGH | **Fixed (confirmed against the HIQA text, EP 3.5.9.1 guidance).** `ie-rx-cd-2`: 14 days, or two months when the number of instalments is stated. The first-instalment-within-14-days rule is a dispensing check (OI-027) | `ie-rx-cd-2`; BDD |
| R-03 | MEDIUM | **Fixed.** Words and figures for any controlled drug (`ie-rx-cd-1`); number of instalments and interval for Schedule 2/3/4 Part 1 (`ie-rx-cd-3`). Scope question logged (OI-027) | `ie-rx-cd-1/3` |
| R-04 | HIGH | **Fixed.** `ie-bnd-rx-5` one patient; `ie-bnd-rx-6` listed allergies in the Bundle; `ie-bnd-rx-2` checks LOINC 48765-2 | `IECoreBundleEPrescription.fsh`; HZ-11 |
| R-05 | HIGH | **Fixed.** FSH examples: foreign identifier systems dropped (issuing country in `assigner`), foreign product codings removed, OID arc moved to 2.16.840.1.113883.19 (OI-020), `sid/pcrs-rx` / `prescription-group` → NePS, `sid/dispense-id` → `urn:uuid` | `CrossBorderExamples.fsh`, `MedicationExamples.fsh` |
| R-06 | HIGH | **Fixed.** NMPC ValueSets `experimental = true` with "refset ID not verified (OI-018)"; aliases `$SCT_IE`, `$NMPC_SUPPLEMENT`, `$PCRS_CATEGORY`, `$HPRA` removed; the eHDSI OID claim marked unverified (OI-026) | `ValueSets.fsh`, `aliases.fsh`, pages |
| R-07 | MEDIUM | **Fixed.** Age required when the date of birth is not a full date (`ie-rx-age-1`, `ie-bnd-rx-3`) | BDD "partial date of birth" |
| R-08 | MEDIUM | **Fixed (documentation).** `changes.md` states the payloads validate but do not claim the ePrescription Bundle profile and are illustrative | `changes.md`, sample-payloads page |
| R-09 | MEDIUM | **Fixed.** `clinicalStatus` 0..1 + `ie-allergy-1` (as `ie-cond-1`) | `IECoreAllergyIntolerance.fsh` |
| R-10 | MEDIUM | **Fixed.** `ie-bnd-rx-4` / `ie-bnd-xb-1` start from `requester`; EP 2.6 downgraded to Partial | mapping, matrix |
| R-11 | MEDIUM | **Partly fixed.** A file with no validator outcome now FAILS. Payload codes and displays are checked by the validator run with `--tx` (all 167 examples). Extending `verify_codes.py` to JSON payloads and displays is logged as a follow-up | `run-validation.js` |
| R-12 | LOW | **Logged.** Extension slicing on the EP patient stays open (EU Base parent); an allow-list is a follow-up. The guard covers the prohibited categories HIQA and ADR-002 name | — |
| R-13 | LOW | **Fixed.** OI-012 no longer lists `Procedure.performed[x]`; `changes.md` cites ADR-001 to ADR-007; README names HIQA and HL7 Ireland; `$HPRA` removed; the `sid/*` systems without a NamingSystem are no longer used by examples | docs |
| R-14 | LOW | **Logged.** SUSHI pinned by version (npm registry integrity); tx.fhir.org outages fail the terminology job (network errors are reported separately by the script) | — |
| R-15 | LOW | **Fixed / kept.** `ie-bnd-rx-1` compares system and value. `ie-rx-dosage-1` kept deliberately: it documents the safety rule and still holds if the 1..1 on `text` is relaxed (OI-012) | `ie-bnd-rx-1` |
