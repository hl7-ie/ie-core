### Testing & Validation

The IE Core Implementation Guide employs a multi-layered testing strategy inspired by best practices from national FHIR implementations across the UK (NHS England), Denmark (MedCom), Australia (HL7 AU), Norway, and Finland.

### Testing Architecture

```
┌─────────────────────────────────────────────────────────┐
│  Layer 5: Full IG Publisher Build (QA Report)           │
│  Comprehensive HTML generation and cross-reference check│
├─────────────────────────────────────────────────────────┤
│  Layer 4: FHIR Validator CLI (HL7 Validator)            │
│  Deep profile validation of examples against profiles   │
├─────────────────────────────────────────────────────────┤
│  Layer 3: BDD / Cucumber Tests (Gherkin)                │
│  Behaviour-driven acceptance tests for profiles/data    │
├─────────────────────────────────────────────────────────┤
│  Layer 2: Quality Control Checks (NHS IOPS pattern)     │
│  Metadata, consistency, and IG hygiene checks           │
├─────────────────────────────────────────────────────────┤
│  Layer 1: SUSHI Compilation                             │
│  FSH syntax, cardinality, and reference validation      │
└─────────────────────────────────────────────────────────┘
```

### Layer 1: SUSHI Compilation

The first line of defence. SUSHI compiles FSH definitions to FHIR JSON and validates:

- FSH syntax correctness
- Element path validity
- Cardinality constraints
- Profile and extension references
- Alias resolution

```bash
sushi .        # R4 edition
sushi r5/      # R5 edition
```

### Layer 2: Quality Control Checks

Inspired by [NHS England IOPS Quality Control](https://github.com/NHSDigital/IOPS-FHIR-Test-Scripts), automated checks verify:

| Check | Description | R4 | R5 |
|-------|-------------|:--:|:--:|
| Profile descriptions | Every profile has a meaningful description (>20 chars) | Y | Y |
| Draft status | All artifacts have `status: draft` during development | Y | Y |
| FHIR version | R5 profiles must declare `fhirVersion: 5.0.0` | — | Y |
| ValueSet composition | Every ValueSet has at least one `compose.include` | Y | Y |
| CodeSystem concepts | Every CodeSystem defines at least one concept | Y | Y |
| Example profile refs | Examples reference valid IE Core profile URLs | Y | — |
| No active status | No FSH file contains premature `active` status | Y | Y |
| Config completeness | `sushi-config.yaml` has all required fields | Y | Y |
| Canonical consistency | All profile URLs use the correct edition base URL | Y | Y |
| EU Core derivation | R5 profiles derive from EU Core R5 where applicable | — | Y |

```bash
cd tests && npm run test:quality       # R4 quality checks
cd r5/tests && npm run test:quality    # R5 quality checks
```

### Layer 3: BDD / Cucumber Tests

Behaviour-Driven Development (BDD) tests using [Cucumber.js](https://cucumber.io/) with Gherkin feature files. This approach enables non-technical stakeholders to read and validate test scenarios.

#### R4 Feature Files (`tests/features/`)

| Feature | Coverage |
|---------|----------|
| `profile-validation.feature` | Patient, Practitioner, Organization, Encounter, Observation, Condition examples |
| `eu-conformance.feature` | EU Core profile derivation, canonical URL consistency |
| `terminology.feature` | ValueSet composition, CodeSystem concepts, county codes, draft status |
| `invariants.feature` | IHI format, GMS format, Eircode format (valid and invalid scenarios) |
| `ehds-profiles.feature` | All 5 EHDS priority category profiles existence and derivation |
| `crossborder-eprescription.feature` | All 11 cross-border ePrescription scenarios — bundles, eDispensations, NePS inbound, eIDAS identifiers, drug code mapping, allergy propagation |

#### R5 Feature Files (`r5/tests/features/`)

| Feature | Coverage |
|---------|----------|
| `profile-validation.feature` | R5 Patient, Practitioner, Organization StructureDefinitions and fhirVersion |
| `eu-conformance.feature` | EU Core R5 derivation, R5 canonical URL consistency, fhirVersion = 5.0.0 |
| `invariants.feature` | IHI, GMS, Eircode patterns (shared identifier rules across R4/R5) |

#### Example Gherkin Scenario

```gherkin
Scenario: IE Core Patient IHI identifier format is valid
  Given I have the example resource "Patient-ie-core-patient-example.json"
  When I extract identifiers with system "http://hl7.hse.ie/fhir/ie/core/sid/ihi"
  Then each identifier value should match pattern "^[0-9]{18}$"
```

```bash
cd tests && npm run test:bdd          # R4 BDD tests
cd r5/tests && npm run test:bdd       # R5 BDD tests
```

### Layer 4: FHIR Validator CLI

The [HL7 FHIR Validator](https://confluence.hl7.org/display/FHIR/Using+the+FHIR+Validator) validates all example instances against their declared profiles. This is the same tool used by NHS England and other national programmes.

```bash
# R4
cd tests
npm run download:validator   # one-time download
npm run test:validate        # validate all R4 examples

# R5
cd r5/tests
npm run download:validator   # one-time download
npm run test:validate        # validate all R5 examples (uses -version 5.0.0)
```

### Layer 5: Full IG Publisher Build

The HL7 IG Publisher performs the most comprehensive validation including:

- All SUSHI compilation
- Full profile validation
- Terminology binding checks
- Cross-reference validation
- Narrative generation
- QA report with warnings and errors

Both the **R4** and **R5** editions receive a full IG Publisher build. The R5
edition is built from the `r5/` directory using its own `sushi-config.yaml` and
`ig.ini`.

### FHIR TestScript Resources

Following the [Denmark MedCom](https://medcomfhir.dk/ig/) pattern, IE Core publishes FHIR TestScript resources that can be executed against a FHIR server using [TouchStone](https://touchstone.aegis.net/) or other TestScript engines.

Available TestScripts:

| TestScript | Description |
|------------|-------------|
| `ie-core-testscript-patient-read` | Validates Patient read operations and IE Core conformance |
| `ie-core-testscript-patient-search` | Validates Patient search by name, IHI, and birthdate |
| `ie-core-testscript-encounter-read` | Validates Encounter read and profile conformance |

### CI/CD Pipeline

All tests run automatically in GitHub Actions:

| Workflow | Trigger | R4 Tests | R5 Tests |
|----------|---------|----------|----------|
| `build-ig.yml` | Push to main/develop | SUSHI, BDD, Quality, FHIR Validator, IG Publisher | SUSHI, BDD, Quality, FHIR Validator, IG Publisher |
| `pr-validation.yml` | Pull requests | SUSHI, BDD, Quality, IG Publisher (dry run) | SUSHI, BDD, Quality, IG Publisher (dry run) |

#### Build Pipeline Flow

```
push / PR
  ├── sushi-r4 ──┬── bdd-tests ──────────┐
  │              ├── quality-checks ──────┼── ig-publish-r4 ──┐
  │              └── fhir-validation      │                   │
  │                                       │                   ├── deploy-pages
  └── sushi-r5 ──┬── bdd-tests-r5 ───────┼── ig-publish-r5 ──┘
                 ├── quality-checks-r5 ───┘
                 └── fhir-validation-r5
                                          (site/ = R4, site/R5/ = R5)
```

On merge to `main`, the deploy step publishes both editions to GitHub Pages:
- **R4** is served at the site root (`/`)
- **R5** is served under `/R5/`
- A version index page at `/versions.html` links to both

The pipeline ensures no regression in profile definitions, examples, or documentation.

### Viewing Test Reports

Test results are published in three ways so that team members and reviewers can easily inspect them:

| Channel | When | What You See |
|---------|------|--------------|
| **Test Dashboard** (GitHub Pages) | Every merge to `main` | A combined HTML dashboard at `/test-reports/` with tabbed R4/R5 BDD scenario tables, quality results, and FHIR Validator outcomes. Includes shields.io badges. |
| **GitHub Actions Step Summary** | Every push and PR | Each test job writes a rich Markdown summary directly on the workflow run page. Scenario-level BDD tables, quality issue lists, and per-resource validator results are visible without downloading artifacts. |
| **PR Comment** | Every pull request | A sticky comment is posted (and updated) on the PR with a full summary table, shields.io badges, and collapsible scenario/issue detail sections. |

The test dashboard is accessible at:

```
https://<org>.github.io/<repo>/test-reports/
```

Individual Cucumber HTML reports are also available:
- `/test-reports/r4-bdd.html` — R4 BDD scenario report
- `/test-reports/r5-bdd.html` — R5 BDD scenario report

### Running Tests Locally

```bash
# Prerequisites: Node.js 20+, Java 17+ (for FHIR Validator and IG Publisher)

# ── R4 Tests ──
sushi .                              # compile R4 FSH
cd tests && npm install              # one-time dependency install
npm test                             # BDD + FHIR Validator
npm run test:quality                 # quality checks
npm run test:all                     # all suites

# ── R5 Tests ──
sushi r5/                            # compile R5 FSH (from repo root)
cd r5/tests && npm install           # one-time dependency install
npm test                             # BDD + FHIR Validator
npm run test:quality                 # quality checks
npm run test:all                     # all suites
```

### Building the Full IG Locally

```bash
# R4 only
./_genonce.sh          # Linux / macOS
_genonce.bat           # Windows

# R5 only (from the r5/ directory)
cd r5 && ./_genonce.sh   # Linux / macOS
cd r5 && _genonce.bat    # Windows

# Both editions together
./_genonce_all.sh      # Linux / macOS
_genonce_all.bat       # Windows
```

After a successful build, open:
- `output/index.html` for the R4 IG
- `r5/output/index.html` for the R5 IG

### Contributing Tests

When adding new profiles or examples, add corresponding tests:

1. **Add BDD scenarios** in `tests/features/` (R4) or `r5/tests/features/` (R5)
2. **Update quality checks** in `tests/quality/` (R4) or `r5/tests/quality/` (R5)
3. **Create TestScript instances** in `input/fsh/testscripts/` for server-side testing
4. **Ensure examples** are provided for every new profile
5. **Keep R4 and R5 test suites in sync** when adding shared concepts (identifiers, invariants)
