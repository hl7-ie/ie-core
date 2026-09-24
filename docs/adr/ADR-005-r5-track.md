# ADR-005: R5 track (continue, freeze or drop)

- **Status:** Proposed (Checkpoint 1)
- **Date:** 2026-09-24

## Context

`r5/` is a separate SUSHI project with **3 profiles** (Patient, Practitioner, Organization,
194 lines of FSH and pages in total). It depends on `hl7.fhir.eu.base-r5` **0.1.0** (an early
ballot), has its own 14 cucumber scenarios and runs 4 CI jobs. It carries the same unsourced
identifier rules as R4 (`ie-pat-r5-2` GMS format; IHI 18 digits only).

The HIQA scope (ePrescription, eDispensation, Patient Summary) and the EHDS / MyHealth@EU targets
for March 2029 are served by **R4** artefacts: EU MPD 1.0.0, EU EPS ballot and IPS 2.0 are all R4.
EU R5 counterparts exist (`hl7.fhir.eu.mpd-r5`), but porting the HIQA work would double every
change in Phases 4–9.

## Options

| | Continue (port the HIQA changes to R5) | **Freeze (informative, correctness fixes only)** | Drop (delete `r5/`) |
|---|---|---|---|
| Advantages | R5 readiness | No double work; keeps the R5 exploration visible; honest labelling | Least maintenance; no stale content |
| Disadvantages | ~2× the effort for Phases 4–9; R5 EU packages are still maturing | Drifts from R4 over time | Loses the R5 exploration and history; would need rebuilding later |
| Risks | Delays the R4 HIQA work, which is the priority | Readers mistake it for maintained, so it needs a banner | Stakeholders who looked at it lose it |
| Cost | High | Low | Very low |
| Operational impact | +4 CI jobs kept as gates | CI: SUSHI R5 build kept, **non-blocking**; R5 BDD/validator jobs removed from PR gates | CI: −4 jobs |
| GDPR / EHDS impact | Would carry the same minimisation rules | Must not publish wrong rules, hence the correctness fixes | None |

## Decision (recommended)

**Freeze.**
1. Add a banner to `r5/input/pagecontent/index.md` and `r5-notes.md`: *"Frozen exploratory track,
   not aligned with the HIQA 2026 drafts; not maintained. Use the R4 IG."*
2. Correctness fixes only, so that a frozen artefact is not *wrong*: IHI accepts 18 or 10 digits;
   the unsourced GMS format invariant and slice are removed (consistent with ADR-006).
3. CI: the R5 SUSHI compile stays as an informational job (`continue-on-error: true`); the R5
   BDD, quality and validator jobs are removed from PR gates.
4. Revisit when EU R5 packages reach STU **and** MyHealth@EU announces an R5 timeline.

## Consequences

- Tests: the R5 cucumber suite is no longer a gate. The R5 scenarios on identifier formats are
  updated to match the fixes.
- `changes.md`: "R5 track frozen (ADR-005)".
