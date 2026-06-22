### HSE Central Terminology Server (CTS) & NMPC

The **HSE Central Terminology Server (CTS)** is the authoritative national FHIR terminology service for Ireland, operated by the Health Service Executive (HSE). It exposes a standard FHIR R4 terminology API and hosts all national code systems required for Irish healthcare interoperability, including:

| Terminology | Description |
|-------------|-------------|
| **SNOMED CT Irish Edition** | SNOMED International + HSE Irish Extension (module `1601000220105`), maintained by eHealth Ireland |
| **NMPC** (National Medicinal Product Catalogue) | Irish medicinal product catalogue modelled as SNOMED CT Irish Extension concepts |
| **PCRS** (Primary Care Reimbursement Service) | Reimbursement scheme category codes, exposed as an NMPC supplement property |
| **HPRA** Drug Catalogue | Health Products Regulatory Authority authorisation numbers, mapped via SNOMED ConceptMap |
| **ATC** (WHO) | Anatomical Therapeutic Chemical classification codes, mapped via SNOMED ConceptMap |

**FHIR endpoint:** `https://nmpc.hse.ie/production1/fhir`

**Guidance & API examples:** [https://github.com/hsenmpc/nmpc-api-examples](https://github.com/hsenmpc/nmpc-api-examples)

> **Authentication**: The CTS requires OAuth2 bearer token authentication. Token endpoint: `https://nmpc.hse.ie/authorisation/auth/realms/terminology/`. See the [NMPC API Examples repository](https://github.com/hsenmpc/nmpc-api-examples) for detailed authentication guidance.

---

### National Medicinal Product Catalogue (NMPC)

The **NMPC** is Ireland's national registry of medicinal products, maintained by the HSE in collaboration with the HPRA. It is modelled as a **SNOMED CT-based** product hierarchy within the SNOMED CT Irish Extension. Real product identifiers are SNOMED CT concept IDs — not local code strings.

#### NMPC Product Hierarchy

NMPC products are organised in a six-level hierarchy, each level represented as a SNOMED CT refset within the Irish Extension (module `1601000220105`):

| Level | Full Name | SNOMED Refset ID | Description |
|-------|-----------|-----------------|-------------|
| **VTM** | Virtual Therapeutic Moiety | `660351000220100` | Generic therapeutic substance (e.g. "Metformin") |
| **ATM** | Actual Therapeutic Moiety | `660361000220103` | Branded therapeutic substance |
| **VMP** | Virtual Medicinal Product | `660371000220109` | Generic product (e.g. "Metformin 500mg tablet") — use for generic prescribing |
| **AMP** | Actual Medicinal Product | `660381000220107` | Authorised branded product (e.g. "Glucophage 500mg") |
| **VMPP** | Virtual Medicinal Product Pack | `660391000220105` | Generic product with specific pack size |
| **AMPP** | Actual Medicinal Product Pack | `660401000220107` | Authorised branded pack — dispensable unit; use for dispensing records |

**Prescribing guidance:**
- Use **VMP** concepts for generic prescribing (MedicationRequest)
- Use **AMP** concepts for branded prescribing where required
- Use **AMPP** concepts in dispensing records (MedicationDispense)

**IE Core ValueSets** for NMPC product levels are defined in the IE Core terminology:

| ValueSet | IE Core ID | SNOMED Refset |
|----------|-----------|---------------|
| [IE Core NMPC VMP](ValueSet-ie-core-nmpc-vmp.html) | `ie-core-nmpc-vmp` | `660371000220109` |
| [IE Core NMPC AMP](ValueSet-ie-core-nmpc-amp.html) | `ie-core-nmpc-amp` | `660381000220107` |
| [IE Core NMPC VMPP](ValueSet-ie-core-nmpc-vmpp.html) | `ie-core-nmpc-vmpp` | `660391000220105` |
| [IE Core NMPC AMPP](ValueSet-ie-core-nmpc-ampp.html) | `ie-core-nmpc-ampp` | `660401000220107` |

---

### Querying the CTS

#### Expand a ValueSet (AMPP — dispensable packs)

To retrieve all current AMPP concepts from the CTS using the NMPC supplement:

```
GET https://nmpc.hse.ie/production1/fhir/ValueSet/$expand
  ?url=https://hl7-ie.github.io/ie-core-fhir-ig-draft/fhir/ie/core/ValueSet/ie-core-nmpc-ampp
  &useSupplement=https://nmpc.hse.ie/CodeSystem/nmpc-supplement
Authorization: ******
```

The `useSupplement` parameter enables the CTS to return NMPC-specific properties (PCRS category, HPRA authorisation number, shortage status, ATC code, etc.) alongside the SNOMED CT display names.

#### Lookup a specific product

```
GET https://nmpc.hse.ie/production1/fhir/CodeSystem/$lookup
  ?system=http://snomed.info/sct/1601000220105
  &code=<SNOMED concept ID>
  &useSupplement=https://nmpc.hse.ie/CodeSystem/nmpc-supplement
Authorization: ******
```

#### Filter by PCRS reimbursement category

PCRS scheme membership is exposed as an NMPC supplement property. To filter products available under the GMS scheme:

```
GET https://nmpc.hse.ie/production1/fhir/ValueSet/$expand
  ?url=https://hl7-ie.github.io/ie-core-fhir-ig-draft/fhir/ie/core/ValueSet/ie-core-nmpc-ampp
  &useSupplement=https://nmpc.hse.ie/CodeSystem/nmpc-supplement
  &filter=PCRS:GMS
Authorization: ******
```

PCRS categories are defined at: `https://nmpc.hse.ie/PCRS/Category`

---

### HPRA Drug Catalogue

The **HPRA** (Health Products Regulatory Authority) maintains the authoritative registry of medicinal products licensed for use in Ireland. HPRA product identifiers are mapped to NMPC SNOMED concepts via a SNOMED ConceptMap refset (`690021000220108`).

To look up an HPRA authorisation number for a product use the NMPC supplement lookup, which includes the HPRA identifier as a property on the SNOMED CT concept.

The system URL for HPRA codes in IE Core resources is: `https://www.hpra.ie/drug-catalogue`

---

### ATC Mapping

WHO **ATC** (Anatomical Therapeutic Chemical) codes are mapped to NMPC VTM-level SNOMED concepts via ConceptMap refset `680441000220106` on the CTS. To retrieve the ATC code for a product:

```
GET https://nmpc.hse.ie/production1/fhir/ConceptMap/$translate
  ?system=http://snomed.info/sct/1601000220105
  &code=<SNOMED VTM concept ID>
  &target=http://www.whocc.no/atc
Authorization: ******
```

---

### Coding Patterns in IE Core Resources

#### MedicationRequest (generic prescribing — VMP)

```json
{
  "resourceType": "MedicationRequest",
  "medicationCodeableConcept": {
    "coding": [
      {
        "system": "http://snomed.info/sct/1601000220105",
        "code": "<VMP SNOMED concept ID>",
        "display": "<VMP display name from NMPC>"
      },
      {
        "system": "http://www.whocc.no/atc",
        "code": "<ATC code>",
        "display": "<ATC description>"
      }
    ]
  }
}
```

#### MedicationDispense (AMPP — dispensed pack)

```json
{
  "resourceType": "MedicationDispense",
  "medicationCodeableConcept": {
    "coding": [
      {
        "system": "http://snomed.info/sct/1601000220105",
        "code": "<AMPP SNOMED concept ID>",
        "display": "<AMPP display name from NMPC>"
      },
      {
        "system": "https://www.hpra.ie/drug-catalogue",
        "code": "<HPRA authorisation number>",
        "display": "<HPRA product name>"
      }
    ]
  }
}
```

> **Note on existing examples**: Some IE Core examples currently use placeholder NMPC codes (e.g., `NMPC-MET500TAB`) with the local system `https://hl7-ie.github.io/ie-core-fhir-ig-draft/fhir/ie/core/sid/nmpc`. These are illustrative examples only. Real implementations must use SNOMED CT concept IDs from the CTS (system: `http://snomed.info/sct/1601000220105`).

---

### SNOMED CT Irish Edition

The SNOMED CT Irish Edition extends the SNOMED CT International Edition with Irish-specific content, maintained by [eHealth Ireland](https://www.ehealthireland.ie/technology-and-transformation-functions/chief-data-and-analytics-office-cdao/standards-and-terminologies/snomed-ct/) in partnership with SNOMED International.

- **Module ID**: `1601000220105`
- **System URL for FHIR**: `http://snomed.info/sct/1601000220105`
- **International SNOMED CT system URL**: `http://snomed.info/sct` (use for concepts from the international release)
- **Release schedule**: Aligned with SNOMED International biannual releases

The Irish Extension includes:
- All NMPC medicinal product concepts (the full product hierarchy)
- Irish-specific clinical concepts as required by HSE clinical terminology programs
- Mapping refsets for HPRA, PCRS, and ATC

---

### Further Resources

| Resource | Link |
|----------|------|
| NMPC API Examples | [https://github.com/hsenmpc/nmpc-api-examples](https://github.com/hsenmpc/nmpc-api-examples) |
| CTS FHIR Endpoint | [https://nmpc.hse.ie/production1/fhir](https://nmpc.hse.ie/production1/fhir) |
| eHealth Ireland SNOMED CT | [https://www.ehealthireland.ie/.../snomed-ct/](https://www.ehealthireland.ie/technology-and-transformation-functions/chief-data-and-analytics-office-cdao/standards-and-terminologies/snomed-ct/) |
| HPRA Drug Catalogue | [https://www.hpra.ie/homepage/medicines/medicines-information/find-a-medicine](https://www.hpra.ie/homepage/medicines/medicines-information/find-a-medicine) |
| PCRS | [https://www.hse.ie/eng/staff/pcrs/](https://www.hse.ie/eng/staff/pcrs/) |
| WHO ATC / DDD Index | [https://www.whocc.no/atc_ddd_index/](https://www.whocc.no/atc_ddd_index/) |
