# HIQA draft national standards (September 2026) — source provenance

These are the normative sources for the HIQA 2026 alignment work. Both are **consultation drafts**
(consultation closes 5pm, 21 October 2026) and will change.

| Short name | Document | Version | URL | SHA-256 (downloaded 2026-09-24) |
|---|---|---|---|---|
| EP | Draft National Standard for Electronic Prescriptions and Electronic Dispensations (119 pp.) | 1.1 draft, Sept 2026 | <https://www.hiqa.ie/sites/default/files/2026-09/Draft-National-Standard-for-Electronic-Prescriptions-and-Electronic-Dispensations.pdf> | `5db82e98e38cb959556f7e90c13ac615dacfc3579825cc9716476e6a7e3d1085` |
| PS | Draft National Standard for a Patient Summary (154 pp.) | draft, Sept 2026 | <https://www.hiqa.ie/sites/default/files/2026-09/Draft-National-Standard-for-a-Patient-Summary.pdf> | `c2e3540219e2935584a160239920ac8e3a66377a00c9fc14497f25f1723cc72f` |

## What is committed

The PDFs, their full-text extractions (`*.txt`) and the full-prose element tables (`*-full.csv`)
are **HIQA copyright** and are git-ignored. They are kept locally so the work can be traced; they are
not redistributed. To re-create them, download the PDFs from the URLs above and run the extraction
below.

The committed files hold structural metadata only:

- `ep-elements.csv`: 242 EP data elements (sections 1–6)
- `ps-elements.csv`: 306 PS data elements (sections 1–19)

Columns: `id` (HIQA element ID), `element` (name), `pd` (EP only: P = prescription record,
D = dispensation record), `auto` (`#` = expected to be auto-populated), `conformance`
(Mandatory/Required/Optional), `cardinality`, `values` (HIQA datatype), `page` (PDF page).

## How the extraction was done

1. `pdftotext -layout` for reading. It interleaves table columns, so it is **not** used for
   conformance or cardinality.
2. `python scripts/audit/extract_hiqa_tables.py <pdf> <out.csv>` uses PyMuPDF `find_tables()` and
   assigns each cell to a column by its x-coordinate against the table header, then merges
   page-split continuation rows.
3. Manual repairs, each checked against the positioned text blocks on the stated page:
   - PS 1.3.4.3 – 1.5.4 (pp. 31–40): the table detector merged these rows, so they were
     transcribed by hand from the PyMuPDF text blocks.
   - PS 19.2.4 – 19.2.6 (pp. 142–143): not table-detected, so transcribed from the text layer.
   - PS 17.x: the cardinality column was shifted into the values column and was re-split.
   - Rows from Table 3 ("business rules in practice", worked examples on pp. 16–20) were dropped.
     They are not dataset elements.
4. Spot checks against coordinates: EP 3.5.11 (**Optional** 0..1), EP 6.5 (**Required** 0..1),
   PS 1.3.1 and 1.3.2 (Required 0..1).

Anomalies in the source itself (for example "Mandatory 0..1", duplicate or skipped numbering)
are **kept as published** and logged in `docs/hiqa-2026/open-issues.md`. They are not corrected here.
