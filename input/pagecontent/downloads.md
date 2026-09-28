### Downloads

The following resources are available for download:

#### Definitions

- [Full IG Package (npm)](package.tgz) - The complete IG package for use with FHIR tooling
- [JSON Definitions](definitions.json.zip) - All resource definitions in JSON format
- [XML Definitions](definitions.xml.zip) - All resource definitions in XML format

#### Examples

- [JSON Examples](examples.json.zip) - All examples in JSON format
- [XML Examples](examples.xml.zip) - All examples in XML format

#### Patient Summary Samples

| File | Description |
|------|-------------|
| `IE_Patient_IPS_FHIR.json` | Irish Patient IPS (Seán Murphy) FHIR Bundle |
| `IPS_CDA_Sample.xml` | Generic IPS CDA document (MyHealth@EU format) |

Cross-border ePrescription and eDispensation samples are in IE Medication Events (ADR-009).

#### Schematrons

- [Schematrons](schematrons.zip) - Validation schematrons

#### Implementation Tools

| Tool | Description | Link |
|------|-------------|------|
| FHIR Validator | Official HL7 FHIR Validator | [Download](https://github.com/hapifhir/org.hl7.fhir.core/releases/latest) |
| SUSHI | FHIR Shorthand compiler | [npm install -g fsh-sushi](https://fshschool.org) |
| IG Publisher | HL7 IG Publisher | [Download](https://github.com/HL7/fhir-ig-publisher/releases/latest) |

### Validation

To validate resources against IE Core profiles:

```bash
java -jar validator_cli.jar [resource-file] -ig nostalgic-ie.fhir.core#0.2.0
```

### Package Installation

For use in FHIR servers and tooling:

```bash
npm --registry https://packages.simplifier.net install nostalgic-ie.fhir.core@0.2.0   # once published (see Publishing on Simplifier.net)
```
