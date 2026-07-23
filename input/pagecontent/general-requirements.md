This page defines the general conformance requirements and expectations for the IE Core Implementation Guide.

### Conformance Verbs

The conformance verbs - **SHALL**, **SHOULD**, **MAY** - used in this guide are defined in [FHIR Conformance Rules](http://hl7.org/fhir/R4/conformance-rules.html).

### Must Support

IE Core uses the concept of [Must Support](must-support.html) as defined on the Must Support page. In the context of IE Core, Must Support on any element **SHALL** be interpreted as follows:

- **IE Core Responders SHALL** be capable of populating all data elements as part of the query results as specified by the IE Core Server Capability Statement.
- **IE Core Requestors SHALL** be capable of processing resource instances containing the data elements without generating an error or causing the application to fail.

### Conformance Obligations (XT-EHR Obligations Framework)

In addition to the narrative Must Support rules above, IE Core profiles that derive from **Xt-EHR-aligned** HL7 Europe artifacts (Patient Summary, Hospital Discharge Report, Laboratory Report, ePrescription/eDispensation) **SHOULD** be read together with the actor-specific `SHALL`/`SHOULD` obligations declared by the corresponding EU Base, EU Laboratory, and EU MPD CapabilityStatements, using the [HL7 FHIR Obligations extension](http://hl7.org/fhir/extensions/StructureDefinition-obligation.html) (`http://hl7.org/fhir/tools/StructureDefinition/obligation`). This machine-readable obligations approach is the pattern adopted by the Xt-EHR Obligations Framework and by 2026-era national Core IGs (e.g. US Core, AU Core) as the successor to purely narrative must-support tables, and:

- Allows automated conformance testing tools (e.g. Touchstone, Inferno, Xt-EHR test suites) to verify actor obligations directly from the CapabilityStatement rather than free-text guidance
- Distinguishes obligations by actor (e.g. `send-data`, `receive-data`) rather than a single blanket Must Support rule
- Is tracked as a formal verification item in the [Future of IE Core](future-of-ie-core.html) roadmap ("XT-EHR Obligations compliance") pending full mapping of every IE Core profile against the Xt-EHR 1.0.0 Obligations Framework

### Missing Data

If the source system does not have data for a **Must Support** element:

1. If the element is not required (minimum cardinality = 0), the element may be omitted from the resource.
2. If the element is required (minimum cardinality > 0), the element **SHALL** be present with either:
   - A valid value, or
   - The [Data Absent Reason](http://hl7.org/fhir/R4/extension-data-absent-reason.html) extension with an appropriate code

### FHIR RESTful API Requirements

#### Supported Formats

IE Core Servers **SHALL** support JSON (`application/fhir+json`) and **SHOULD** support XML (`application/fhir+xml`).

#### Authentication and Authorization

IE Core implementations **SHOULD** support [SMART on FHIR](http://hl7.org/fhir/smart-app-launch/) for authentication and authorization.

#### Search

IE Core Servers **SHALL** support the search parameters defined in each profile's Quick Start section and the [IE Core Server CapabilityStatement](CapabilityStatement-ie-core-server.html).

Servers **SHALL** support the following search result parameters:
- `_include`
- `_revinclude`
- `_count`

#### Paging

IE Core Servers **SHOULD** support [paging](http://hl7.org/fhir/R4/http.html#paging) for search results.

### Irish Healthcare Identifiers

Ireland's healthcare system uses several key identifiers:

| Identifier | Description | Issuing Authority |
|------------|-------------|-------------------|
| IHI (Individual Healthcare Identifier) | National unique patient identifier | HSE |
| HPI (Health Service Provider Identifier) | Healthcare provider identifier | HSE |
| IMC (Irish Medical Council) | Medical practitioner registration number | Medical Council of Ireland |
| GMS (General Medical Service) | Medical card number | HSE Primary Care |
| DPS (Drugs Payment Scheme) | DPS card number | HSE Primary Care |
| LTI (Long Term Illness) | LTI scheme number | HSE Primary Care |
| HAA (Health Amendment Act) | HAA card number | HSE Primary Care |
| PPS (Personal Public Service) | Social services identifier (should NOT be used as patient ID) | Department of Social Protection |
| Eircode | Postal address code | An Post / Eircode |

#### IHI Validation Rules

The Individual Healthcare Identifier (IHI) is an 18-digit number with the following validation:
- Exactly 18 digits
- Position 17 must pass modulus 11 check digit validation
- Position 18 must pass GS1 check digit validation

#### GMS/DPS/LTI/HAA Format Rules

| Scheme | Format |
|--------|--------|
| GMS | 8 characters, alphanumeric, always ends in a letter |
| DPS | 8 characters, alphanumeric, always ends in a letter |
| LTI | 7 characters, 6 numbers followed by a letter |
| HAA | 7 characters, starts and ends with a letter, contains 5 numbers |
