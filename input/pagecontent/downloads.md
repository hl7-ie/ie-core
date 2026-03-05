### Downloads

The following resources are available for download:

#### Definitions

- [Full IG Package (npm)](package.tgz) - The complete IG package for use with FHIR tooling
- [JSON Definitions](definitions.json.zip) - All resource definitions in JSON format
- [XML Definitions](definitions.xml.zip) - All resource definitions in XML format

#### Examples

- [JSON Examples](examples.json.zip) - All examples in JSON format
- [XML Examples](examples.xml.zip) - All examples in XML format

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
java -jar validator_cli.jar [resource-file] -ig hl7.fhir.ie.core#0.1.0
```

### Package Installation

For use in FHIR servers and tooling:

```bash
npm --registry https://packages.fhir.org install hl7.fhir.ie.core@0.1.0
```
