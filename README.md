# IE (Ireland) Core FHIR Implementation Guide

**Canonical URL**: `http://hl7.hse.ie/fhir/ie/core`  
**Package**: `hl7.fhir.ie.core`  
**Version**: 0.1.0  
**FHIR Version**: R4 (4.0.1)  
**Status**: Draft (CI Build)

[![Build IE Core FHIR IG](https://github.com/nithinmohantk/hl7-ie-fhir-draft-ig/actions/workflows/build-ig.yml/badge.svg)](https://github.com/nithinmohantk/hl7-ie-fhir-draft-ig/actions/workflows/build-ig.yml)

## Overview

The IE Core Implementation Guide defines the minimum constraints on FHIR resources to create Irish healthcare interoperability profiles. It is developed in collaboration with the Health Service Executive (HSE), the Irish College of General Practitioners (ICGP), and the Department of Health.

This IG establishes a "floor" of standards that promotes interoperability and adoption through common implementation across Ireland's healthcare systems.

## Contents

### Profiles (40+)

| Category | Profiles |
|----------|----------|
| **Patient Demographics** | Patient, RelatedPerson |
| **Provider & Organization** | Practitioner, PractitionerRole, Organization, Location |
| **Clinical** | AllergyIntolerance, Condition (x2), Procedure, CarePlan, CareTeam, Goal, ServiceRequest, Encounter |
| **Medication** | Medication, MedicationRequest, MedicationDispense, Immunization |
| **Diagnostics** | DiagnosticReport (x2), Observation Clinical Result, Lab Result, Simple Observation, Specimen |
| **Vital Signs** | Base Vital Signs + 13 specific vital sign profiles |
| **Documents** | DocumentReference, ADI DocumentReference, Provenance, QuestionnaireResponse |
| **Financial** | Coverage, Implantable Device |
| **Identifiers** | IHI, HPI, IMC, MRN, GMS, DPS, LTI, HAA, IMN, CRN |

### Extensions (12)

Ethnicity, Mother's Maiden Name, Gender Identity, Interpreter Required, IHI Status, IHI Record Status, IHI Verified Date, Medication Adherence, Authentication Time, Questionnaire URI, Direct Email, IECDI Requirement

### Terminology

- 10 CodeSystems (including Ireland-specific: Counties, Ethnicity, IHI Status)
- 49 ValueSets

### Other Artifacts

- 2 CapabilityStatements (Server + Client)
- 20 SearchParameters
- 15 Example instances with realistic Irish healthcare data

## Prerequisites

### Required Software

1. **Node.js** (v18+): [nodejs.org](https://nodejs.org)
2. **Java** (JDK 17+): [adoptium.net](https://adoptium.net)
3. **SUSHI** (FSH Compiler):
   ```bash
   npm install -g fsh-sushi
   ```
4. **Jekyll** (for IG Publisher page generation):
   ```bash
   gem install jekyll
   ```

### Verify Installation

```bash
node --version      # v18.x or higher
java --version      # 17 or higher
sushi --version     # 3.x or higher
```

## Building the IG

### Step 1: Compile FSH to FHIR Resources

```bash
sushi .
```

This reads all `.fsh` files from `input/fsh/` and generates FHIR JSON resources in `fsh-generated/`.

### Step 2: Download the IG Publisher

**Windows:**
```batch
_updatePublisher.bat
```

**macOS/Linux:**
```bash
chmod +x _updatePublisher.sh
./_updatePublisher.sh
```

### Step 3: Build the Full IG

**Windows:**
```batch
_genonce.bat
```

**macOS/Linux:**
```bash
chmod +x _genonce.sh
./_genonce.sh
```

The generated IG website will be in the `output/` directory. Open `output/index.html` to view.

## Project Structure

```
hl7-fhir/
├── sushi-config.yaml              # SUSHI/IG configuration
├── ig.ini                         # IG Publisher configuration
├── _genonce.bat/.sh               # Build scripts
├── _updatePublisher.bat/.sh       # Publisher download scripts
├── README.md                      # This file
│
├── input/
│   ├── fsh/
│   │   ├── aliases.fsh            # Common aliases and URLs
│   │   ├── profiles/              # All resource profiles
│   │   │   ├── IECorePatient.fsh
│   │   │   ├── IECorePractitioner.fsh
│   │   │   ├── IECorePractitionerRole.fsh
│   │   │   ├── IECoreOrganization.fsh
│   │   │   ├── IECoreEncounter.fsh
│   │   │   ├── IECoreLocation.fsh
│   │   │   ├── IECoreAllergyIntolerance.fsh
│   │   │   ├── IECoreCondition.fsh
│   │   │   ├── IECoreProcedure.fsh
│   │   │   ├── IECoreCarePlan.fsh
│   │   │   ├── IECoreCareTeam.fsh
│   │   │   ├── IECoreGoal.fsh
│   │   │   ├── IECoreServiceRequest.fsh
│   │   │   ├── IECoreRelatedPerson.fsh
│   │   │   ├── IECoreMedication.fsh
│   │   │   ├── IECoreMedicationRequest.fsh
│   │   │   ├── IECoreMedicationDispense.fsh
│   │   │   ├── IECoreImmunization.fsh
│   │   │   ├── IECoreDiagnosticReport.fsh
│   │   │   ├── IECoreDocumentReference.fsh
│   │   │   ├── IECoreDevice.fsh
│   │   │   ├── IECoreCoverage.fsh
│   │   │   ├── IECoreProvenance.fsh
│   │   │   ├── IECoreQuestionnaireResponse.fsh
│   │   │   ├── IECoreSpecimen.fsh
│   │   │   ├── IECoreObservation.fsh        # 13 observation profiles
│   │   │   └── IECoreVitalSigns.fsh         # 13 vital signs profiles
│   │   ├── extensions/
│   │   │   └── Extensions.fsh               # 12 extensions
│   │   ├── identifiers/
│   │   │   └── Identifiers.fsh              # 10 identifier profiles
│   │   ├── terminology/
│   │   │   ├── CodeSystems.fsh              # 10 code systems
│   │   │   └── ValueSets.fsh                # 49 value sets
│   │   ├── capability/
│   │   │   └── CapabilityStatements.fsh     # Server + Client
│   │   ├── searchparameters/
│   │   │   └── SearchParameters.fsh         # 20 search parameters
│   │   └── examples/
│   │       └── Examples.fsh                 # 15 example instances
│   │
│   ├── pagecontent/                         # IG documentation pages
│   │   ├── index.md                         # Home page
│   │   ├── conformance.md
│   │   ├── general-requirements.md
│   │   ├── must-support.md
│   │   ├── smart-on-fhir.md
│   │   ├── guidance.md
│   │   ├── general-guidance.md
│   │   ├── clinical-notes.md
│   │   ├── medication-list.md
│   │   ├── basic-provenance.md
│   │   ├── screening-and-assessments.md
│   │   ├── future-of-ie-core.md
│   │   ├── security.md
│   │   ├── downloads.md
│   │   ├── hl7-registry-guidance.md         # HL7 publication guide
│   │   └── changes.md
│   │
│   ├── images/                              # Images for documentation
│   └── includes/                            # Reusable content fragments
│
├── fsh-generated/                           # Generated by SUSHI (git-ignored)
├── output/                                  # Generated by IG Publisher (git-ignored)
└── input-cache/                             # IG Publisher JAR (git-ignored)
```

## Publishing to the HL7 FHIR Registry

### Overview of the Process

1. **Establish HL7 Relationship** → Join/create HL7 Ireland affiliate or get HL7 Work Group sponsorship
2. **Register Canonical URL** → Reserve `http://hl7.hse.ie/fhir/ie/core` with HL7
3. **HL7 Ballot** → Submit for formal ballot (For Comment → STU → Normative)
4. **Publish** → Publish through HL7's publication pipeline to packages.fhir.org

### Detailed Steps

#### 1. Establish HL7 Ireland

Contact HL7 International ([hl7.org](http://hl7.org)) to establish HL7 Ireland as a national affiliate:

- Formal agreement with HL7 International
- Governance structure (board, working groups)
- Annual affiliate fees
- At minimum, form an Ireland FHIR Working Group

Alternatively, use the **HL7 FHIR Community Process** for initial publication without full affiliate status.

#### 2. Domain Setup (hl7.hse.ie)

Coordinate with HSE IT to:

1. Create the `hl7.hse.ie` subdomain
2. Configure DNS (CNAME to hosting platform)
3. Obtain SSL/TLS certificate
4. Deploy the built IG (`output/` directory)

Hosting options:
- **GitHub Pages**: Free, automated via GitHub Actions
- **Azure/AWS**: Scalable cloud hosting
- **HSE Infrastructure**: On-premises hosting

#### 3. Continuous Integration

Set up CI/CD for automated builds:

```yaml
# .github/workflows/build-ig.yml
name: Build IG
on: [push, pull_request]
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-java@v4
        with:
          java-version: '17'
          distribution: 'temurin'
      - uses: actions/setup-node@v4
        with:
          node-version: '18'
      - run: npm install -g fsh-sushi
      - run: sushi .
      - run: ./_updatePublisher.sh
      - run: ./_genonce.sh
      - uses: actions/upload-artifact@v4
        with:
          name: ig-output
          path: output/
```

#### 4. Submit for Ballot

1. Register a Jira project at [jira.hl7.org](https://jira.hl7.org)
2. Submit ballot request through your HL7 affiliate or sponsoring Work Group
3. Allow 90+ days for ballot period
4. Reconcile ballot comments
5. Re-ballot if needed

#### 5. Package Publication

After ballot approval:

1. Build the final release version
2. Submit the package to [packages.fhir.org](https://packages.fhir.org)
3. Update the IG version in `sushi-config.yaml`
4. Tag the release in git

## Key Contacts

| Role | Contact |
|------|---------|
| HL7 International | [hl7.org](http://hl7.org) |
| FHIR Community | [chat.fhir.org](https://chat.fhir.org) (Zulip) |
| HL7 Affiliates | [hl7.org/affiliates](http://hl7.org/Special/Committees/Affiliates/affiliates.cfm) |
| FHIR Package Registry | [packages.fhir.org](https://packages.fhir.org) |
| FSH School | [fshschool.org](https://fshschool.org) |

## Technology Stack

| Component | Tool | Purpose |
|-----------|------|---------|
| Profile Authoring | [FHIR Shorthand (FSH)](http://hl7.org/fhir/uv/shorthand/) | Define profiles, extensions, value sets |
| FSH Compiler | [SUSHI](https://fshschool.org/docs/sushi/) | Compile FSH → FHIR JSON |
| IG Builder | [HL7 IG Publisher](https://github.com/HL7/fhir-ig-publisher) | Build the full IG website |
| Validation | [FHIR Validator](https://github.com/hapifhir/org.hl7.fhir.core) | Validate resources against profiles |
| Template | [fhir.base.template](https://github.com/HL7/ig-template-base) | Standard HL7 IG template |

## License

This Implementation Guide is licensed under [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/).

HL7, FHIR, and the FHIR flame logo are registered trademarks of Health Level Seven International.
