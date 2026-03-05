### Basic Provenance Guidance

The [IE Core Provenance](StructureDefinition-ie-core-provenance.html) profile provides a mechanism to track the origin, authorship, and transmission history of clinical data.

### When to Use Provenance

Provenance **SHOULD** be recorded when:

- A clinical record is created or modified
- Data is transmitted between systems
- Data is imported from an external source
- A record is attested or verified by a clinician

### Provenance Agent Types

The IE Core Provenance profile supports the following agent types:

| Agent Type | Code | Description |
|------------|------|-------------|
| Author | `author` | The agent that created the resource |
| Transmitter | `transmitter` | The agent that transmitted the resource |
| Assembler | `assembler` | The agent that assembled the resource from components |

### Targeted Provenance

IE Core supports "targeted provenance" where a Provenance resource targets a specific FHIR resource. This is accomplished using the `Provenance.target` element.

Example: Recording who authored a patient's allergy record:

```json
{
  "resourceType": "Provenance",
  "target": [
    { "reference": "AllergyIntolerance/example" }
  ],
  "recorded": "2025-01-15T10:30:00+00:00",
  "agent": [
    {
      "type": {
        "coding": [
          {
            "system": "http://terminology.hl7.org/CodeSystem/provenance-participant-type",
            "code": "author",
            "display": "Author"
          }
        ]
      },
      "who": { "reference": "Practitioner/example" },
      "onBehalfOf": { "reference": "Organization/example" }
    }
  ]
}
```

### GDPR and Provenance

In the Irish healthcare context, provenance records support GDPR compliance by documenting:

- Who accessed or modified patient data
- When the access or modification occurred
- On behalf of which organization the action was taken
