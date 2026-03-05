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
