# ADR-001: HIQA logical models and the mapping approach

- **Status:** Proposed (Checkpoint 1)
- **Date:** 2026-09-24
- **Deciders:** Nithin Mohan (IG author)
- **Related:** baseline finding H-10; Phase 2 commit `40022a4`

## Context

HIQA's September 2026 drafts define the Irish ePrescription/eDispensation dataset (EP, 242 elements)
and Patient Summary dataset (PS, 306 elements). Each element has an ID, a conformance (Mandatory,
Required or Optional), a cardinality and a datatype. HIQA does **not** specify coded values or a
FHIR representation. Both drafts cite the Xt-EHR logic models as their basis.

IE Core had no machine-readable link from a HIQA element to a FHIR profile path. So nothing could
answer "is every Mandatory element enforced?", and a regression would go unnoticed (the 121 BDD
scenarios pass whether or not the IG meets HIQA).

The Xt-EHR models are published as `xtehr.eu.ehds.models`, an **R5** package, so they cannot be a
dependency of this R4 IG.

## Requirements and constraints

1. Every HIQA element is traceable to an IE Core path, or explicitly marked as a gap.
2. HIQA facts (ID, conformance, cardinality) are recorded exactly, including the drafts' own
   anomalies (e.g. "Mandatory 0..1").
3. HIQA prose is copyrighted and is not republished in the IG.
4. The drafts will change after consultation (closes 21 Oct 2026), so re-baselining must be cheap.
5. The traceability must be testable in CI.

## Options

| | A. Logical models + FSH `Mapping` generated from CSV sources | B. Hand-written FSH logical models | C. Spreadsheet only (no FHIR artefacts) | D. Depend on Xt-EHR models and map to those |
|---|---|---|---|---|
| Advantages | One source of truth; regenerated in seconds when HIQA changes; CI `--check` catches drift; published as StructureDefinitions with a mapping tab | Readable diffs; no generator to maintain | Cheapest; familiar to non-FHIR reviewers | Reuses EU work; European alignment |
| Disadvantages | A generator to maintain (about 300 lines of Python) | 548 elements by hand; drifts from the matrix | Not in the IG; no FHIR tooling; drifts silently | The package is R5; Xt-EHR ≠ HIQA (HIQA adds Irish elements and omits some optional Xt-EHR ones) |
| Risks | Generator bugs (mitigated by validation and by checking the SUSHI output, e.g. `contentReference` targets) | Transcription errors | Traceability is lost at the first edit | Cross-version tooling immaturity |
| Cost | Low (done in Phase 2) | High | Very low | Medium–high |
| Operational impact | Re-run the script after each HIQA revision | Manual rework each revision | Manual | Tracks the Xt-EHR release cycle |
| GDPR / EHDS impact | Makes "not in dataset" rows explicit, so data minimisation becomes testable | Same, but by hand | None enforced | Good for EHDS; weak for Irish specifics |

## Decision (recommended)

**Option A.** Implemented in Phase 2:

- `docs/sources/hiqa-2026/{ep,ps}-elements.csv` hold the HIQA facts (structural metadata only).
- `docs/hiqa-2026/mapping/{ep,ps}-mapping.csv` hold the IE Core side, **hand-maintained**:
  profile, path, MS, status, notes.
- `scripts/hiqa/generate_traceability.py` produces the FSH Logical models (`HIQAEPrescriptionLM`,
  `HIQAPatientSummaryLM`), the FSH `Mapping:` to `ie-core`, `docs/hiqa-2026/traceability-matrix.csv`
  and `input/pagecontent/hiqa-traceability.md`.
- Each LM element carries the HIQA ID, conformance, exact cardinality and PDF page in `short` and
  `definition`. HIQA prose is **not** copied.
- Xt-EHR is referenced in page text and mapping comments by URL, not as a package dependency.
  Revisit if an R4 package of the Xt-EHR models is published.

## Mapping conventions

| HIQA conformance | FHIR constraint in the use-case profile |
|---|---|
| Mandatory | `min ≥ 1` + MustSupport. If the element sits in an optional cluster: `1..1` inside the parent, and the parent stays optional |
| Required ("send if known") | cardinality `0..n` + MustSupport |
| Optional | allowed; **no** MustSupport |
| Not in the use case's dataset (personal data) | `0..0` in that use-case profile only (GDPR Art. 5(1)(c)) |

Status values: **Aligned**, **Partial**, **Gap**, **Prohibited (violated / enforced)**, **N/A**.
A Gap row has no path (the generator enforces this).

## Consequences

- Positive: traceability is part of the build. The Phase 8 test asserts that Mandatory → `min ≥ 1`
  and Required → MS against the generated snapshots, and that the matrix is current.
- Negative: two CSVs must be kept correct by hand. Mitigation: the generator validates coverage in
  both directions.
- When HIQA publishes the final standards: refresh the element CSVs → the generator flags
  new or removed IDs → update the mapping rows.
