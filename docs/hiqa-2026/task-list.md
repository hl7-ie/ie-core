# HIQA 2026 alignment: task list

Branch: `feat/hiqa-2026-alignment-c8ff80`. One commit per phase (Conventional Commits).

| # | Phase | Status | Notes |
|---|---|---|---|
| 1 | Baseline audit | ✅ done | `docs/audit/baseline.md`, `docs/audit/sensitive-demographics-usage.csv`, `docs/sources/hiqa-2026/` |
| 2 | HIQA logical models and traceability | ✅ done | 2 Logical models, FSH Mappings, 558-row matrix; generator `scripts/hiqa/generate_traceability.py`. Baseline: Mandatory aligned EP 18/54, PS 25/68 (corrected in Phase 3 by the snapshot cross-check) |
| 3 | Design and ADRs | ✅ approved 2026-09-24 | ADR-001–006, `checkpoint-1-plan.md`; parent trials: MPD 38 errors (36 examples), IPS 1, EPS 1 |
| 4 | Demographics and data minimisation | ✅ done | IECorePatientEPrescription, IECorePatientSummaryPatient, ADR-006 identifiers; Mandatory aligned EP 25/54, PS 32/68; 15 prohibited rows enforced |
| 5 | ePrescription / eDispensation | ✅ done | EU MPD parents; Bundle, allergy List, signature Provenance; 14 invariants; registration/facility/GLN identifiers; EP Mandatory aligned 40/54 |
| 6 | Patient Summary | ✅ done | EPS parent; PS Bundle; clinical MS; PS Mandatory aligned 46/68 |
| 7 | Terminology | ✅ done | ADR-007: 277 codes verified on tx.fhir.org (0 invalid); 37 wrong-meaning, 13 non-existent, 6 inactive codes and 6 dangling bindings fixed; CSO ethnicity v1.0; validator QA 30 errors (main 48) |
| 8 | Examples, tests, payloads | ✅ done | 8 HIQA scenario Bundles (52 resources, `HIQAScenarios.fsh`); payload/CDA/Postman remediation; `hiqa-eprescription`, `hiqa-patient-summary`, `data-minimisation` features (FHIRPath on the real invariants, negative cases); EP guard script; validator 145/145 examples pass with tx.fhir.org; BDD 168/168; quality 543/543; 309 codes verified |
| 9 | Pages, R5, CI | ✅ done | Pages: HIQA 2026 Alignment (Mermaid context, prescribe/dispense, PS flow), Data Minimisation, Open Issues (generated); index INFO/WARNING at the top; identifiers, terminology (Irish Edition as `version`), cross-border, security, must-support, testing updated; HIQA menu. R5 frozen (IHI 18/10, GMS removed). CI: SHA-pinned actions, least privilege, pinned SUSHI 3.18.0 / Publisher 2.3.4 / validator 6.10.4 (SHA-256), caches, gates (traceability, mapping, guard, codes, validator QA baseline, links), Dependabot. The 22 legacy payload Bundles now validate (22/22) |
| 10 | Independent review | ✅ done, **⛔ CHECKPOINT 2** | `docs/audit/review-hiqa-2026.md` (read-only subagent): 0 CRITICAL, 5 HIGH (all fixed), 7 MEDIUM (6 fixed, 1 partly), 3 LOW; responses in `docs/audit/review-hiqa-2026-responses.md`. SUSHI 0/0; validator 168/168; QA 35 (baseline); BDD 176/176; quality 544/544 |
| 11 | Consultation feedback and release prep | ✅ done | `consultation-feedback.md` (individual submission); version 0.2.0 (per-artefact version pins removed); `changes.md` dated; README HIQA section; `docs/release-notes-0.2.0.md`; OI-010 resolved, OI-027 decision recorded. Branch renamed to `feat/hiqa-2026-alignment`. **Not tagged, pushed or published** |
