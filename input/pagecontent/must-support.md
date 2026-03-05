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
