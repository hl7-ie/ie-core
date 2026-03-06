# IE Core FHIR IG — Pipeline Workflow

This document describes the end-to-end CI/CD pipeline for the **IE (Ireland) Core FHIR Implementation Guide** (`hl7.fhir.ie.core`). The pipeline is implemented as two GitHub Actions workflows:

| Workflow file | Purpose | Triggered by |
|---|---|---|
| `.github/workflows/pr-validation.yml` | Fast validation gate on pull requests | PRs targeting `main` or `develop` |
| `.github/workflows/build-ig.yml` | Full build, test, publish pipeline | Push to `main`/`develop`, PRs to `main`, manual dispatch |

---

## 1. High-Level Flow

```
┌─────────────────────────────────────────────────────────────────────┐
│                        Developer Workflow                           │
│                                                                     │
│   Edit .fsh files  ──►  Open PR  ──►  Merge to main               │
└────────────┬───────────────────┬────────────────────────────────────┘
             │  PR Validation    │  Main Build & Publish
             ▼                   ▼
┌────────────────────┐  ┌────────────────────────────────────────────┐
│  pr-validation.yml │  │              build-ig.yml                  │
│                    │  │                                            │
│  SUSHI R4          │  │  SUSHI R4/R5 ──► Tests ──► IG Publisher   │
│  SUSHI R5          │  │                              ──► GitHub    │
│  BDD Tests R4/R5   │  │                                  Pages     │
│  IG Publisher R4/R5│  │                                            │
│    (dry run)       │  │                                            │
│  PR Comment        │  │                                            │
└────────────────────┘  └────────────────────────────────────────────┘
```

---

## 2. PR Validation Workflow (`pr-validation.yml`)

Triggered on every pull request to `main` or `develop` that changes FSH sources, configuration files, or tests.

### 2.1 Trigger paths

```
input/fsh/**
r5/input/fsh/**
sushi-config.yaml
r5/sushi-config.yaml
ig.ini
r5/ig.ini
tests/**
r5/tests/**
```

### 2.2 Job dependency graph

```
sushi-r4 ──────────────────────────────────────────────┐
     │                                                  │
     ├──► bdd-tests ──────────────────────────────────► pr-comment
     │                                                  │
     └──► ig-publisher-r4-check                         │
                                                        │
sushi-r5 ──────────────────────────────────────────────┤
     │                                                  │
     ├──► bdd-tests-r5 ─────────────────────────────── ┘
     │
     └──► ig-publisher-r5-check
```

### 2.3 Jobs

#### `sushi-r4` — SUSHI R4 Compilation

| Item | Detail |
|---|---|
| Runner | `ubuntu-latest` |
| Node version | 20 |
| Key command | `sushi .` |
| Artifact produced | `pr-fsh-generated-r4` (retained 1 day) |
| Step summary | Counts of Profiles/Extensions, ValueSets, CodeSystems, Examples |

Compiles all FSH files under `input/fsh/` into FHIR R4 JSON resources in `fsh-generated/`.

---

#### `sushi-r5` — SUSHI R5 Compilation

| Item | Detail |
|---|---|
| Runner | `ubuntu-latest` |
| Node version | 20 |
| Key command | `sushi r5/` |
| Artifact produced | `pr-fsh-generated-r5` (retained 1 day) |
| Step summary | Counts of R5 Profiles and ValueSets |

Compiles all FSH files under `r5/input/fsh/` into FHIR R5 JSON resources in `r5/fsh-generated/`.

---

#### `bdd-tests` — BDD Tests (R4)

| Item | Detail |
|---|---|
| Depends on | `sushi-r4` |
| Runner | `ubuntu-latest` |
| Working directory | `tests/` |
| Commands | `npm ci`, `npm run test:bdd`, `npm run test:quality` |
| Artifacts produced | `pr-test-reports-r4`: `cucumber-report.json`, `quality-results.json` (retained 5 days) |
| Step summary | BDD scenario pass/fail table; Quality check results |

Downloads the R4 SUSHI artifact, installs test dependencies, then runs:
- **BDD (Cucumber.js)** — scenario-level tests defined in `tests/features/*.feature`
- **Quality checks** — static analysis on generated resources (`tests/quality/quality-checks.js`)

---

#### `bdd-tests-r5` — BDD Tests (R5)

| Item | Detail |
|---|---|
| Depends on | `sushi-r5` |
| Runner | `ubuntu-latest` |
| Working directory | `r5/tests/` |
| Commands | `npm ci`, `npm run test:bdd`, `npm run test:quality` |
| Artifacts produced | `pr-test-reports-r5`: `cucumber-report.json`, `quality-results.json` (retained 5 days) |
| Step summary | R5 BDD scenario pass/fail table; R5 Quality check results |

---

#### `ig-publisher-r4-check` — IG Publisher R4 (Dry Run)

| Item | Detail |
|---|---|
| Depends on | `sushi-r4` |
| Runner | `ubuntu-latest` |
| Java version | 17 (Temurin) |
| Ruby/Jekyll | Ruby 3.2 + `jekyll` gem |
| Key command | `java -jar input-cache/publisher.jar -ig ig.ini` |
| Step summary | Error / Warning / Information counts from `output/qa.json` |

Downloads the latest HL7 FHIR IG Publisher JAR and runs a full R4 build to catch any IG Publisher validation errors before merge. Does **not** deploy output.

---

#### `ig-publisher-r5-check` — IG Publisher R5 (Dry Run)

| Item | Detail |
|---|---|
| Depends on | `sushi-r5` |
| Runner | `ubuntu-latest` |
| Java version | 17 (Temurin) |
| Key command | `cd r5 && java -jar input-cache/publisher.jar -ig ig.ini` |
| Step summary | Error / Warning / Information counts from `r5/output/qa.json` |

Same as the R4 dry-run but for the R5 edition.

---

#### `pr-comment` — Post PR Test Summary

| Item | Detail |
|---|---|
| Depends on | `bdd-tests`, `bdd-tests-r5` |
| Runs | Always (even if tests fail) |
| Runner | `ubuntu-latest` |
| Permissions | `pull-requests: write` |

Downloads both R4 and R5 test report artifacts, generates a combined Markdown summary via `tests/reports/generate-summary.js`, and posts (or updates) a **sticky comment** on the PR using `marocchino/sticky-pull-request-comment@v2`. The comment header key is `ie-core-test-results` so the same comment is updated on each push rather than creating duplicates.

---

## 3. Full Build & Publish Workflow (`build-ig.yml`)

Triggered on every push to `main` or `develop`, PRs to `main`, and manual dispatch (`workflow_dispatch`).

### 3.1 Job dependency graph

```
sushi-r4 ──────────────────────────────────────────────────────────────────────┐
     │                                                                          │
     ├──► bdd-tests ──────────────────────────────────► ig-publish-r4 ─────────┤
     │                                                                          │
     ├──► quality-checks ──────────────────────────────────────────────────────┤
     │                                                                          │
     ├──► fhir-validation (×6 matrix) ──► fhir-validation-collect ─────────────┤
     │                                                                          │
     └──► (feeds ig-publish-r4 via needs)                                       │
                                                                                ▼
sushi-r5 ──────────────────────────────────────────────────────────────────►  deploy-pages
     │                                                                          ▲
     ├──► bdd-tests-r5 ─────────────────────────────────► ig-publish-r5 ───────┤
     │                                                                          │
     ├──► quality-checks-r5 ──────────────────────────────────────────────────┤
     │                                                                          │
     └──► fhir-validation-r5 ────────────────────────────────────────────────── ┘
```

`deploy-pages` only runs on push to `main`.

### 3.2 Jobs

#### `sushi-r4` — SUSHI R4 Compilation

| Item | Detail |
|---|---|
| Runner | `ubuntu-latest` |
| Key command | `sushi .` |
| Artifact produced | `fsh-generated-r4` (retained 5 days) |

#### `sushi-r5` — SUSHI R5 Compilation

| Item | Detail |
|---|---|
| Runner | `ubuntu-latest` |
| Key command | `sushi r5/` |
| Artifact produced | `fsh-generated-r5` (retained 5 days) |

---

#### `bdd-tests` — BDD / Cucumber Tests (R4)

| Item | Detail |
|---|---|
| Depends on | `sushi-r4` |
| Commands | `npm ci` → `npm run test:bdd` |
| Artifacts produced | `bdd-report`: all files under `tests/reports/` (retained 30 days) |
| Step summary | Per-scenario pass/fail table |

---

#### `quality-checks` — Quality Control (R4)

| Item | Detail |
|---|---|
| Depends on | `sushi-r4` |
| Command | `npm run test:quality` |
| Artifacts produced | `quality-report`: `tests/reports/quality-results.json` (retained 30 days) |
| Step summary | Pass/fail count; table of failing checks |

Runs the quality gate script (`tests/quality/quality-checks.js`) which inspects the generated FHIR JSON for conformance to IG conventions (e.g., required metadata fields, snapshot presence, correct versioning).

---

#### `fhir-validation` — FHIR Validator (Matrix, R4)

| Item | Detail |
|---|---|
| Depends on | `sushi-r4` |
| Matrix domains | `persons`, `organizations`, `clinical`, `medication`, `prescription`, `dispense` |
| Java version | 17 (Temurin) |
| Commands | `npm run download:validator` → `npm run test:validate -- --domain <domain>` |
| Artifacts produced | `validation-report-<domain>`: per-domain JSON report (retained 30 days) |
| Step summary | Per-domain pass/fail table |
| Timeout | 15 minutes per domain |

Runs the [HL7 FHIR Validator](https://github.com/hapifhir/org.hl7.fhir.core) against all example instances, grouped by clinical domain. `fail-fast: false` ensures all domains are validated even if one fails.

---

#### `fhir-validation-collect` — FHIR Validation (Collect All Domains, R4)

| Item | Detail |
|---|---|
| Depends on | `fhir-validation` (all 6 matrix jobs) |
| Purpose | Merge per-domain reports into a single `validation-results.json` |
| Artifact produced | `validation-report`: merged `tests/reports/validation-results.json` (retained 30 days) |
| Step summary | Total pass/fail count across all domains |

---

#### `bdd-tests-r5` — BDD / Cucumber Tests (R5)

| Item | Detail |
|---|---|
| Depends on | `sushi-r5` |
| Working directory | `r5/tests/` |
| Artifacts produced | `bdd-report-r5`: all files under `r5/tests/reports/` (retained 30 days) |

---

#### `quality-checks-r5` — Quality Control (R5)

| Item | Detail |
|---|---|
| Depends on | `sushi-r5` |
| Artifacts produced | `quality-report-r5`: `r5/tests/reports/quality-results.json` (retained 30 days) |

---

#### `fhir-validation-r5` — FHIR Validator (R5)

| Item | Detail |
|---|---|
| Depends on | `sushi-r5` |
| Timeout | 30 minutes |
| Commands | `npm run download:validator` → `npm run test:validate` |
| Artifacts produced | `validation-report-r5`: `r5/tests/reports/validation-results.json` (retained 30 days) |

Validates all R5 example instances against the R5 profiles using the HL7 FHIR Validator.

---

#### `ig-publish-r4` — Full IG Build (R4)

| Item | Detail |
|---|---|
| Depends on | `sushi-r4`, `bdd-tests`, `quality-checks` |
| Java version | 17 (Temurin) |
| Ruby/Jekyll | Ruby 3.2 + `jekyll` gem |
| Key command | `java -jar input-cache/publisher.jar -ig ig.ini` |
| Artifacts produced | `ig-output-r4`: full `output/` directory (retained 30 days); `qa-report-r4`: `qa.json`, `qa.html`, `qa-time-report.json` (retained 30 days) |

Downloads the latest HL7 FHIR IG Publisher JAR and runs the complete R4 IG build, producing the full HTML website with narrative pages, profile tables, and terminology browser.

---

#### `ig-publish-r5` — Full IG Build (R5)

| Item | Detail |
|---|---|
| Depends on | `sushi-r5`, `bdd-tests-r5`, `quality-checks-r5` |
| Key command | `cd r5 && java -jar input-cache/publisher.jar -ig ig.ini` |
| Artifacts produced | `ig-output-r5`: full `r5/output/` directory (retained 30 days); `qa-report-r5` (retained 30 days) |

---

#### `deploy-pages` — Deploy to GitHub Pages

| Item | Detail |
|---|---|
| Depends on | ALL preceding jobs (`ig-publish-r4`, `ig-publish-r5`, both BDD, both quality-checks, both FHIR validation jobs) |
| Condition | Only runs on **push to `main`** |
| Environment | `github-pages` |

**Steps:**

1. Download R4 IG output → `site/`
2. Download R5 IG output → `site/R5/`
3. Download all test reports (R4 BDD, R4 quality, R4 validation, R5 BDD, R5 quality, R5 validation) — continue on error if any are missing
4. Generate the Test Dashboard HTML (`node tests/reports/generate-dashboard.js`)
5. Copy dashboard and BDD HTML reports into `site/test-reports/`
6. Create `site/versions.html` — version index page linking R4 and R5 editions and the test report dashboard
7. Configure GitHub Pages (`actions/configure-pages@v5`)
8. Upload pages artifact (`actions/upload-pages-artifact@v3`)
9. Deploy to GitHub Pages (`actions/deploy-pages@v4`)

**Published structure:**

```
https://<org>.github.io/<repo>/
├── index.html              # R4 IG home page
├── versions.html           # Version index (R4, R5, reports)
├── R5/
│   └── index.html          # R5 IG home page
└── test-reports/
    ├── index.html           # Combined test dashboard
    ├── r4-bdd.html          # R4 Cucumber HTML report
    └── r5-bdd.html          # R5 Cucumber HTML report
```

---

## 4. Test Infrastructure

All tests live in `tests/` (R4) and `r5/tests/` (R5).

### 4.1 BDD Tests (Cucumber.js)

Framework: `@cucumber/cucumber` v11  
Config: `tests/cucumber.mjs`

Feature files define scenarios in Gherkin syntax:

| Feature file | Domain |
|---|---|
| `profile-validation.feature` | Generic profile conformance |
| `terminology.feature` | ValueSet / CodeSystem checks |
| `invariants.feature` | Profile invariant rules |
| `medication-scenarios.feature` | Medication workflows |
| `crossborder-eprescription.feature` | Cross-border ePrescription (EHDS) |
| `ehds-profiles.feature` | EHDS-aligned profile checks |
| `eu-conformance.feature` | HL7 Europe / IPS conformance |

Step definitions live in `tests/features/step_definitions/`.

### 4.2 Quality Checks

Script: `tests/quality/quality-checks.js`  
Run: `npm run test:quality`  
Output: `tests/reports/quality-results.json`

Performs static analysis on generated resources, checking for conformance to IG conventions such as correct metadata fields, presence of snapshots, and proper versioning.

### 4.3 FHIR Validator

Script: `tests/validator/run-validation.js`  
Downloader: `tests/validator/download-validator.js`  
Run: `npm run test:validate [-- --domain <domain>]`  
Output: `tests/reports/validation-results-<domain>.json`

Downloads the official [HL7 FHIR Validator](https://github.com/hapifhir/org.hl7.fhir.core) JAR and validates all example FHIR instances against the generated profiles. Examples are grouped by domain: `persons`, `organizations`, `clinical`, `medication`, `prescription`, `dispense`.

### 4.4 Reporting

| Script | Output | Purpose |
|---|---|---|
| `tests/reports/generate-summary.js` | `tests/reports/pr-comment.md` | PR sticky comment |
| `tests/reports/generate-dashboard.js` | `tests/reports/html/index.html` | GitHub Pages test dashboard |

---

## 5. Artifact Retention Summary

| Artifact name | Retained | Produced by |
|---|---|---|
| `pr-fsh-generated-r4` | 1 day | PR: `sushi-r4` |
| `pr-fsh-generated-r5` | 1 day | PR: `sushi-r5` |
| `pr-test-reports-r4` | 5 days | PR: `bdd-tests` |
| `pr-test-reports-r5` | 5 days | PR: `bdd-tests-r5` |
| `fsh-generated-r4` | 5 days | Build: `sushi-r4` |
| `fsh-generated-r5` | 5 days | Build: `sushi-r5` |
| `bdd-report` | 30 days | Build: `bdd-tests` |
| `bdd-report-r5` | 30 days | Build: `bdd-tests-r5` |
| `quality-report` | 30 days | Build: `quality-checks` |
| `quality-report-r5` | 30 days | Build: `quality-checks-r5` |
| `validation-report-<domain>` | 30 days | Build: `fhir-validation` (×6) |
| `validation-report` | 30 days | Build: `fhir-validation-collect` |
| `validation-report-r5` | 30 days | Build: `fhir-validation-r5` |
| `ig-output-r4` | 30 days | Build: `ig-publish-r4` |
| `ig-output-r5` | 30 days | Build: `ig-publish-r5` |
| `qa-report-r4` | 30 days | Build: `ig-publish-r4` |
| `qa-report-r5` | 30 days | Build: `ig-publish-r5` |

---

## 6. Technology Stack

| Layer | Tool | Version | Purpose |
|---|---|---|---|
| Profile authoring | [FHIR Shorthand (FSH)](http://hl7.org/fhir/uv/shorthand/) | — | Define profiles, extensions, value sets, examples |
| FSH compiler | [SUSHI](https://fshschool.org/docs/sushi/) | 3.x | Compile `.fsh` → FHIR JSON |
| IG builder | [HL7 IG Publisher](https://github.com/HL7/fhir-ig-publisher) | latest | Build full HTML IG website |
| FHIR validator | [HL7 FHIR Validator](https://github.com/hapifhir/org.hl7.fhir.core) | latest | Validate instances against profiles |
| BDD test framework | [Cucumber.js](https://cucumber.io/docs/installation/javascript/) | 11.x | Gherkin-driven scenario tests |
| Test assertions | [Chai](https://www.chaijs.com/) | 4.x | BDD/TDD assertions |
| Schema validation | [AJV](https://ajv.js.org/) | 8.x | JSON Schema validation |
| Page generation | [Jekyll](https://jekyllrb.com/) | — | IG narrative page rendering |
| CI/CD | [GitHub Actions](https://docs.github.com/en/actions) | — | Automation platform |
| Hosting | [GitHub Pages](https://pages.github.com/) | — | Published IG website |
| Runtime (Node) | Node.js | 20 | Test runner / scripts |
| Runtime (Java) | Temurin JDK | 17 | IG Publisher / FHIR Validator |
| Runtime (Ruby) | Ruby | 3.2 | Jekyll |

---

## 7. Local Development Quick-Start

```bash
# 1. Install tooling
npm install -g fsh-sushi
gem install jekyll

# 2. Compile R4 FSH → FHIR JSON
sushi .

# 3. Run tests (from tests/ directory)
cd tests
npm ci
npm run test:bdd          # BDD / Cucumber scenarios
npm run test:quality      # Quality checks
npm run test:validate     # FHIR Validator (requires Java 17+)

# 4. Build full R4 IG (requires publisher.jar in input-cache/)
./_updatePublisher.sh     # download latest publisher.jar
./_genonce.sh             # build IG → output/

# 5. Preview
open output/index.html
```

For R5:

```bash
sushi r5/
cd r5/tests && npm ci && npm run test:bdd
```

---

## 8. Permissions & Concurrency

| Workflow | Required permissions | Notes |
|---|---|---|
| `pr-validation.yml` | `contents: read`, `pull-requests: write` | Needs write to post PR comment |
| `build-ig.yml` | `contents: read`, `pages: write`, `id-token: write` | Needs write + OIDC token for GitHub Pages deploy |

The `build-ig.yml` workflow uses `concurrency: group: "pages", cancel-in-progress: false` to prevent concurrent GitHub Pages deployments from conflicting.
