# HIQA 2026 alignment: task list

Branch: `feat/hiqa-2026-alignment-c8ff80`. One commit per phase (Conventional Commits).

| # | Phase | Status | Notes |
|---|---|---|---|
| 1 | Baseline audit | ✅ done | `docs/audit/baseline.md`, `docs/audit/sensitive-demographics-usage.csv`, `docs/sources/hiqa-2026/` |
| 2 | HIQA logical models and traceability | ✅ done | 2 Logical models, FSH Mappings, 558-row matrix; generator `scripts/hiqa/generate_traceability.py`. Baseline: Mandatory aligned EP 18/54, PS 25/68 (corrected in Phase 3 by the snapshot cross-check) |
| 3 | Design and ADRs | ✅ approved 2026-09-24 | ADR-001–006, `checkpoint-1-plan.md`; parent trials: MPD 38 errors (36 examples), IPS 1, EPS 1 |
| 4 | Demographics and data minimisation | ✅ done | IECorePatientEPrescription, IECorePatientSummaryPatient, ADR-006 identifiers; Mandatory aligned EP 25/54, PS 32/68; 15 prohibited rows enforced |
| 5 | ePrescription / eDispensation | ⏸ | |
| 6 | Patient Summary | ⏸ | |
| 7 | Terminology | ⏸ | |
| 8 | Examples, tests, payloads | ⏸ | |
| 9 | Pages, R5, CI | ⏸ | |
| 10 | Independent review | ⏸ | **⛔ CHECKPOINT 2** |
| 11 | Consultation feedback and release prep | ⏸ | No tag, push or publish |
