# HIQA 2026 alignment: task list

Branch: `feat/hiqa-2026-alignment-c8ff80`. One commit per phase (Conventional Commits).

| # | Phase | Status | Notes |
|---|---|---|---|
| 1 | Baseline audit | ✅ done | `docs/audit/baseline.md`, `docs/audit/sensitive-demographics-usage.csv`, `docs/sources/hiqa-2026/` |
| 2 | HIQA logical models and traceability | ✅ done | 2 Logical models, FSH Mappings, 558-row matrix; generator `scripts/hiqa/generate_traceability.py`. Baseline: Mandatory aligned EP 18/54, PS 27/68 |
| 3 | Design and ADRs | ⏳ | **⛔ CHECKPOINT 1** |
| 4 | Demographics and data minimisation | ⏸ waiting for Checkpoint 1 | Includes the identifier rationalisation (ADR-006) |
| 5 | ePrescription / eDispensation | ⏸ | |
| 6 | Patient Summary | ⏸ | |
| 7 | Terminology | ⏸ | |
| 8 | Examples, tests, payloads | ⏸ | |
| 9 | Pages, R5, CI | ⏸ | |
| 10 | Independent review | ⏸ | **⛔ CHECKPOINT 2** |
| 11 | Consultation feedback and release prep | ⏸ | No tag, push or publish |
