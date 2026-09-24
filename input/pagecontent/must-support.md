### Must Support Definition

For the purposes of the IE Core Implementation Guide, Must Support on any data element **SHALL** be interpreted as follows:

#### IE Core Responder (Server)

- The server **SHALL** be capable of including the data element as part of the query results.
- When data is available, the server **SHALL** populate the element.
- When data is not available and the element has a minimum cardinality of 0, the server **MAY** omit the element.
- When data is not available and the element has a minimum cardinality > 0, the server **SHALL** populate the element with either a valid value or the Data Absent Reason extension.

#### IE Core Requestor (Client)

- The client application **SHALL** be capable of processing resource instances containing Must Support data elements without generating an error or causing the application to fail.
- The client application **SHOULD** be capable of displaying Must Support data elements for human use, or processing them for other purposes (e.g. storing, further processing).
- The client application **SHALL NOT** modify or remove Must Support elements when updating resources on the server.

### HIQA conformance levels

The HIQA draft national standards (September 2026) classify every data element as Mandatory, Required or Optional.
IE Core maps them as follows (ADR-001):

| HIQA | IE Core | Meaning for a sender |
|---|---|---|
| **Mandatory** | minimum cardinality ≥ 1 **and** MustSupport | SHALL always be sent |
| **Required** | MustSupport | SHALL be sent when the data is available |
| **Optional** | allowed, no MustSupport | MAY be sent |
| Not in the dataset for the use case | `0..0` in the use-case profile | SHALL NOT be sent (e.g. ethnicity in an ePrescription) |
{:.grid}

Where HIQA marks an element Mandatory only *within* an optional group (for example the lines of the facility address),
IE Core enforces it only when the group is present, or by an invariant. Each case is listed on the
[HIQA Traceability](hiqa-traceability.html) page.

### Mandatory Elements

Mandatory elements (minimum cardinality ≥ 1) **SHALL** always be present in the resource. If the data is not available:

- Use the `Data Absent Reason` extension to indicate why the data is absent
- Use a null value where the type allows it

### Additional IECDI Requirements

Some elements are marked as "Additional IECDI Requirements". These elements:

- Are not Mandatory or Must Support in the base profile
- Are required for IE Core certification testing
- **SHOULD** be supported by all implementations where the data is available
- Are included in the formal definition and examples

These are marked in the profile tables with the label **ADDITIONAL IECDI**.
