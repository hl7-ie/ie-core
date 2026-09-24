This page defines the general conformance requirements and expectations for the IE Core Implementation Guide.

### Conformance Verbs

The conformance verbs - **SHALL**, **SHOULD**, **MAY** - used in this guide are defined in [FHIR Conformance Rules](http://hl7.org/fhir/R4/conformance-rules.html).

### Must Support

IE Core uses the concept of [Must Support](must-support.html) as defined on the Must Support page. In the context of IE Core, Must Support on any element **SHALL** be interpreted as follows:

- **IE Core Responders SHALL** be capable of populating all data elements as part of the query results as specified by the IE Core Server Capability Statement.
- **IE Core Requestors SHALL** be capable of processing resource instances containing the data elements without generating an error or causing the application to fail.

### Conformance Obligations (XT-EHR Obligations Framework)

In addition to the narrative Must Support rules above, IE Core profiles that derive from **XT-EHR-aligned** HL7 Europe artifacts (Patient Summary, Hospital Discharge Report, Laboratory Report, ePrescription/eDispensation) **SHOULD** be read together with the corresponding EU Base, EU Laboratory, and EU MPD CapabilityStatements. Those CapabilityStatements declare actor-specific `SHALL`/`SHOULD` obligations. These obligations use the [HL7 FHIR Obligations extension](http://hl7.org/fhir/extensions/StructureDefinition-obligation.html) (`http://hl7.org/fhir/tools/StructureDefinition/obligation`). This machine-readable obligations approach is the pattern adopted by the XT-EHR Obligations Framework. It has also been adopted by 2026-era national Core IGs (e.g. US Core, AU Core) as the successor to purely narrative must-support tables. It:

- Allows automated conformance testing tools (e.g. Touchstone, Inferno, XT-EHR test suites) to verify actor obligations directly from the CapabilityStatement rather than free-text guidance
- Distinguishes obligations by actor (e.g. `send-data`, `receive-data`) rather than a single blanket Must Support rule
- Is tracked as a formal verification item in the [Future of IE Core](future-of-ie-core.html) roadmap ("XT-EHR Obligations compliance") pending full mapping of every IE Core profile against the XT-EHR 1.0.0 Obligations Framework

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

The identifiers below are those named in the HIQA draft national standards (September 2026). Identifiers without an
authoritative source were removed (ADR-006). The `system` URIs are placeholders under this IG's canonical until the
issuing bodies publish FHIR identifier systems (OI-003).

| Identifier | HIQA element | Where in IE Core | Issuing authority |
|------------|-------------|------------------|-------------------|
| IHI (Individual Health Identifier) | EP/PS 1.3.1 (Required) | `Patient.identifier:IHI` | HSE |
| PPSN (Personal Public Service Number) | EP/PS 1.3.2 (Required) | `Patient.identifier:PPSN`, no MustSupport (legal basis Requires Clarification, OI-008) | Department of Social Protection |
| PCRS scheme numbers (medical card, GP visit card, DPS, LTI, Health (Amendment) Act card) | EP/PS 1.3.3 "other identifier" | `Patient.identifier` with `type` from `IECorePCRSSchemeType`; no format enforced | HSE PCRS |
| Medical Council (IMC) registration number | EP/PS 2.6.2 | `Practitioner.identifier:IMC` | Medical Council |
| PSI registration number (pharmacists) | EP/PS 2.6.2 | `Practitioner.identifier:PSI` (up to 8 digits) | Pharmaceutical Society of Ireland |
| NMBI registration number (nurse and midwife prescribers) | EP/PS 2.6.2 | `Practitioner.identifier:NMBI` | Nursing and Midwifery Board of Ireland |
| Dental Council registration number | EP (prescriber definition) | `Practitioner.identifier:DentalCouncil` | Dental Council |
| PSI Retail Pharmacy Business number | EP/PS 2.8 | `Organization.identifier:PSIRPB` | Pharmaceutical Society of Ireland |
| GMS Panel ID | EP/PS 2.12 | `Organization.identifier:GMSPanel` | HSE PCRS |
| GLN (Global Location Number) | EP/PS 2.11 | `Location.identifier:GLN` (`http://www.gs1.org/gln`, check digit enforced) | GS1 |
| NePS electronic prescription identifier | EP 3.1 | `MedicationRequest.groupIdentifier` / `identifier` | HSE (NePS) |
| Eircode | EP/PS 1.2.1 | `address.postalCode` | Eircode |

#### IHI format

HIQA EP/PS 1.3.1 describes the IHI as "a unique 18 or 10-digit number". IE Core accepts either form (invariant
`ie-pat-1`). How the two forms relate, and whether either has a check digit, is not stated by HIQA and is Requires
Clarification (OI-002), so IE Core enforces no check digit.

#### PCRS scheme numbers

HIQA does not define formats for PCRS scheme numbers, so IE Core enforces none (ADR-006).
