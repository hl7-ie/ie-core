### Downloads

The following resources are available for download:

#### Definitions

- [Full IG Package (npm)](package.tgz) - The complete IG package for use with FHIR tooling
- [JSON Definitions](definitions.json.zip) - All resource definitions in JSON format
- [XML Definitions](definitions.xml.zip) - All resource definitions in XML format

#### Examples

- [JSON Examples](examples.json.zip) - All examples in JSON format
- [XML Examples](examples.xml.zip) - All examples in XML format

#### Cross-Border ePrescription Samples

| File | Description |
|------|-------------|
| `IE_to_DE_ePrescription_FHIR.json` | IE→Germany FHIR ePrescription Bundle (PZN codes) |
| `IE_to_ES_ePrescription_FHIR.json` | IE→Spain FHIR ePrescription Bundle (CIMA codes) |
| `IE_to_FR_ePrescription_FHIR.json` | IE→France FHIR ePrescription Bundle (CIP codes) |
| `IE_to_NL_ePrescription_FHIR.json` | IE→Netherlands FHIR ePrescription Bundle (GNK codes) |
| `IE_to_LV_ePrescription_FHIR.json` | IE→Latvia FHIR ePrescription Bundle (ZRA codes) |
| `IE_to_PT_ePrescription_FHIR.json` | IE→Portugal FHIR ePrescription Bundle (INFARMED codes) |
| `IE_to_DK_ePrescription_FHIR.json` | IE→Denmark FHIR ePrescription Bundle (VNR codes, INR note) |
| `IE_to_SE_ePrescription_FHIR.json` | IE→Sweden FHIR ePrescription Bundle (LMV codes, insulins) |
| `IE_to_AT_ePrescription_FHIR.json` | IE→Austria FHIR ePrescription Bundle (BASG codes) |
| `DE_eDispensation_Response_FHIR.json` | German pharmacy eDispensation response |
| `LV_to_IE_eDispensation_FHIR.json` | Latvian pharmacy eDispensation response |
| `PT_to_IE_eDispensation_FHIR.json` | Portuguese pharmacy eDispensation response |
| `FI_to_IE_eDispensation_via_NePS_FHIR.json` | Finnish patient dispensation via NePS |
| `BE_to_IE_eDispensation_via_NePS_FHIR.json` | Belgian patient dispensation via NePS |
| `DE_Patient_to_IE_NePS_Dispensation_FHIR.json` | German patient dispensation via NePS |
| `IE_Patient_IPS_FHIR.json` | Irish Patient IPS (Seán Murphy) FHIR Bundle |
| `IE_to_DE_ePrescription_CDA.xml` | IE→Germany CDA ePrescription (eHDSI format) |
| `IPS_CDA_Sample.xml` | Generic IPS CDA document (MyHealth@EU format) |

All cross-border samples are documented with full scenario context on the [Cross-Border ePrescription](crossborder-eprescription.html) pages.

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
