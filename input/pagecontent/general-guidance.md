### Representing "Not Present" and "Unknown" Data

If information is not available or not applicable, IE Core profiles provide the following mechanisms:

#### Missing Data for Non-Coded Elements

For non-coded elements (string, date, numeric, etc.):
- If the element has minimum cardinality of 0, omit the element
- If the element has minimum cardinality ≥ 1, use the [Data Absent Reason](http://hl7.org/fhir/R4/extension-data-absent-reason.html) extension

#### Missing Data for Coded Elements

For coded elements:
- If the element has a required binding and the data is not available, use the null flavor code from the bound value set if available
- If no null flavor is available, use the Data Absent Reason extension

### Contained Resources

In some cases, the content referred to in a resource reference does not have an independent existence apart from the referencing resource. In these cases, the content is included as a [contained resource](http://hl7.org/fhir/R4/references.html#contained).

IE Core profiles **SHOULD** use contained resources when:
- The referenced resource only exists in the context of the referencing resource
- The server does not support the referenced resource type as a standalone resource

### Provenance

IE Core defines a [Provenance profile](StructureDefinition-ie-core-provenance.html) that **SHOULD** be used to track the origin and history of clinical data. See the [Basic Provenance](basic-provenance.html) page for detailed guidance.

### Irish Address Format

IE Core uses the standard FHIR Address datatype with the following Irish-specific guidance:

- `address.line`: Street address (e.g., "51 Bracken Road")
- `address.city`: City/town name (e.g., "Sandyford")
- `address.state`: Irish county (bound to Ireland Counties ValueSet)
- `address.postalCode`: Eircode (e.g., "D18 CV48")
- `address.country`: "IE" or "Ireland"

### Language Support

Ireland has two official languages: English (en) and Irish/Gaeilge (ga). IE Core implementations:

- **SHALL** support English language content
- **SHOULD** support Irish language content where available
- **SHOULD** use BCP 47 language tags: `en-IE` for Irish English and `ga-IE` for Irish/Gaeilge

### Timezone

All datetime values in IE Core **SHOULD** include timezone information. Ireland observes:
- Greenwich Mean Time (GMT/UTC+0) during standard time
- Irish Standard Time (IST/UTC+1) during summer time

### Clinical Terminology Standards (HIQA)

In accordance with [HIQA's Guidance on Terminology Standards for Ireland](https://www.hiqa.ie/sites/default/files/2017-07/Guidance-on-terminology-standards-for-Ireland.pdf), IE Core adopts the following terminology standards:

| Domain | Primary Standard | Secondary / Supplementary |
|--------|-----------------|--------------------------|
| **Clinical terms (diagnoses, procedures, findings)** | SNOMED CT | ICD-10-AM/ACHI (aggregation) |
| **Medications** | NMPC | SNOMED CT Irish Edition, ATC (WHO international classification) |
| **Laboratory observations** | LOINC | SNOMED CT (for result values) |
| **Allergies & adverse reactions** | SNOMED CT | — |
| **Immunizations** | SNOMED CT, CVX | ATC (J07 vaccines) |

**SNOMED CT** is Ireland's nationally adopted reference terminology, maintained through the [SNOMED CT Irish Extension](https://www.ehealthireland.ie/technology-and-transformation-functions/chief-data-and-analytics-office-cdao/standards-and-terminologies/snomed-ct/) by eHealth Ireland's National Release Centre. Ireland is a member of [SNOMED International](https://www.snomed.org/).

For medications, IE Core adopts the National Medicinal Product Catalogue (NMPC) as the preferred primary code wherever available. SNOMED CT Irish Edition SHOULD be carried as a secondary coding wherever available to support clinical interoperability, terminology services, and cross-border mapping.

**LOINC** is the recommended standard for laboratory observation identifiers, in line with international best practice and EU cross-border laboratory result exchange.

**ATC (WHO)** is used as a supplementary classification for medications, particularly for EU cross-border interoperability under EHDS and MyHealth@EU.

See the [Medication List](medication-list.html) page for detailed medication terminology guidance.
