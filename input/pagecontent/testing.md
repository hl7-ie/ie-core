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

| Check | Description |
|-------|-------------|
| Profile descriptions | Every profile has a meaningful description (>20 chars) |
| Draft status | All artifacts have `status: draft` during development |
| ValueSet composition | Every ValueSet has at least one `compose.include` |
| CodeSystem concepts | Every CodeSystem defines at least one concept |
| Example profile refs | Examples reference valid IE Core profile URLs |
| No active status | No FSH file contains premature `active` status |
| Config completeness | `sushi-config.yaml` has all required fields |
| Canonical consistency | All profile URLs use the `http://hl7.hse.ie/fhir/ie/core/` base |

```bash
cd tests && npm run test:quality
```

### Layer 3: BDD / Cucumber Tests

Behaviour-Driven Development (BDD) tests using [Cucumber.js](https://cucumber.io/) with Gherkin feature files. This approach enables non-technical stakeholders to read and validate test scenarios.

#### Feature Files

| Feature | Coverage |
|---------|----------|
| `profile-validation.feature` | Patient, Practitioner, Organization, Encounter, Observation, Condition examples |
| `eu-conformance.feature` | EU Core profile derivation, canonical URL consistency |
| `terminology.feature` | ValueSet composition, CodeSystem concepts, county codes, draft status |
| `invariants.feature` | IHI format, GMS format, Eircode format (valid and invalid scenarios) |

#### Example Gherkin Scenario

```gherkin
Scenario: IE Core Patient IHI identifier format is valid
  Given I have the example resource "Patient-ie-core-patient-example.json"
  When I extract identifiers with system "http://hl7.hse.ie/fhir/ie/core/sid/ihi"
  Then each identifier value should match pattern "^[0-9]{18}$"
```

```bash
cd tests && npm run test:bdd
```

### Layer 4: FHIR Validator CLI

The [HL7 FHIR Validator](https://confluence.hl7.org/display/FHIR/Using+the+FHIR+Validator) validates all example instances against their declared profiles. This is the same tool used by NHS England and other national programmes.

```bash
cd tests
npm run download:validator   # one-time download
npm run test:validate        # validate all examples
```

### Layer 5: Full IG Publisher Build

The HL7 IG Publisher performs the most comprehensive validation including:

- All SUSHI compilation
- Full profile validation
- Terminology binding checks
- Cross-reference validation
- Narrative generation
- QA report with warnings and errors

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

| Workflow | Trigger | Tests Run |
|----------|---------|-----------|
| `build-ig.yml` | Push to main/develop | SUSHI R4 + R5, BDD, Quality, FHIR Validator, Full IG Build |
| `pr-validation.yml` | Pull requests | SUSHI R4 + R5, BDD, Quality |

The pipeline ensures no regression in profile definitions, examples, or documentation.

### Running Tests Locally

```bash
# Prerequisites: Node.js 20+, Java 17+ (for FHIR Validator and IG Publisher)

# 1. Compile FSH
sushi .

# 2. Install test dependencies (one-time)
cd tests && npm install

# 3. Run all tests
npm test

# 4. Run specific test suites
npm run test:bdd          # Cucumber BDD tests only
npm run test:quality      # Quality control checks only
npm run test:validate     # FHIR Validator (requires Java)
npm run test:all          # All test suites
```

### Contributing Tests

When adding new profiles or examples, add corresponding tests:

1. **Add BDD scenarios** in `tests/features/` for new profiles
2. **Update quality checks** in `tests/quality/` if new rules are needed
3. **Create TestScript instances** in `input/fsh/testscripts/` for server-side testing
4. **Ensure examples** are provided for every new profile
