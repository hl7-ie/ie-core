### Medication List Guidance

IE Core provides medication-related profiles to represent the full medication lifecycle, from prescribing through dispensing:

| Profile | Use Case |
|---------|----------|
| [IE Core MedicationRequest](StructureDefinition-ie-core-medicationrequest.html) | Prescriptions and medication orders |
| [IE Core MedicationDispense](StructureDefinition-ie-core-medicationdispense.html) | Dispensing records from pharmacies |
| [IE Core Medication](StructureDefinition-ie-core-medication.html) | Medication definitions and details |
| [IE Core MedicationRequest (ePrescription)](StructureDefinition-ie-core-medicationrequest-eprescription.html) | Cross-border electronic prescriptions (EHDS) |
| [IE Core MedicationDispense (eDispensation)](StructureDefinition-ie-core-medicationdispense-edispensation.html) | Cross-border electronic dispensation (EHDS) |
| [IE Core Medication (ePrescription)](StructureDefinition-ie-core-medication-eprescription.html) | Medication for ePrescription/eDispensation |

### Active Medication List

To retrieve a patient's active medication list:

```
GET [base]/MedicationRequest?patient=[id]&status=active
```

### Medication Terminology Standards (HIQA)

In IE Core medication resources, the **National Medicinal Product Catalogue (NMPC)** is the preferred primary medication code wherever available. **SNOMED CT Irish Edition** is the preferred secondary medication coding wherever available, supporting semantic interoperability and cross-border exchange. This aligns the IG with Irish medicines standardisation efforts while continuing to use [SNOMED International](https://www.snomed.org/) and the [Irish National Release Centre](https://www.ehealthireland.ie/technology-and-transformation-functions/chief-data-and-analytics-office-cdao/standards-and-terminologies/snomed-ct/) for secondary clinical terminology.

#### Required and Recommended Code Systems

| Code System | Status | Use | Notes |
|-------------|--------|-----|-------|
| **NMPC** (via CTS) | **Preferred primary** | Primary Irish medicinal product code | NMPC products are SNOMED CT concepts in the Irish Extension (module `1601000220105`). Query the [HSE Central Terminology Server (CTS)](terminology-services.html) at `https://nmpc.hse.ie/production1/fhir`. Use VMP concepts for generic prescribing; AMP/AMPP for branded products and dispensing. |
| **SNOMED CT Irish Edition** | **Preferred secondary** | Secondary clinical drug terminology | System URL: `http://snomed.info/sct/1601000220105`. Carry as an additional coding wherever available. Use concepts under `373873005 \| Pharmaceutical / biologic product` hierarchy. |
| **ATC (WHO)** | Recommended | International classification of drugs | Use alongside NMPC/SNOMED where needed for international classification and EU cross-border interoperability (EHDS/MyHealth@EU). Mapped from NMPC via CTS ConceptMap. |
| **LOINC** | Recommended | Laboratory-related medication observations | Used for observation codes related to medication monitoring. |
| **ICD-10** | Optional | Indication coding | May be used for diagnosis/indication alongside SNOMED CT. |

#### Preferred Coding Pattern

Use the following coding order wherever possible:

1. **NMPC (SNOMED CT Irish Edition concept)** as the primary coding — retrieve from the [CTS](terminology-services.html) using the appropriate product level (VMP for generic, AMP for branded, AMPP for dispensing)
2. **SNOMED CT Irish Edition** as a secondary coding where available (typically the same concept as the NMPC code, with the SNOMED IE system URL)
3. **ATC** as an additional coding where needed for classification or EU exchange

See the [Terminology Services (CTS & NMPC)](terminology-services.html) page for detailed coding examples, FHIR `$expand` queries, PCRS filtering, and HPRA mapping guidance.

#### Why Not RxNorm?

RxNorm is a US-specific drug terminology maintained by the National Library of Medicine (NLM). It is **not recommended** for Irish implementations because:

- It covers only US-marketed drug products
- It does not include Irish or European medicinal product identifiers
- SNOMED CT provides equivalent (and broader) clinical drug coverage with international applicability
- EU cross-border exchange (EHDS) uses SNOMED CT and ATC, not RxNorm

### Irish Medication Schemes

Ireland has several medication reimbursement schemes relevant to ePrescription:

| Scheme | Description | IE Core Support |
|--------|-------------|----------------|
| **GMS (General Medical Service)** | Medical card covering full cost of prescribed medicines | Patient identifier slice (GMS) |
| **DPS (Drugs Payment Scheme)** | Limits monthly expenditure per family | Patient identifier slice (DPS) |
| **LTI (Long Term Illness)** | Covers medications for specified long-term conditions | Patient identifier slice (LTI) |
| **HAA (Health Amendment Act)** | Covers individuals affected by contaminated blood products | Patient identifier slice (HAA) |
| **PCRS (Primary Care Reimbursement Service)** | Processes claims for community drug schemes | ePrescription identifier |

These scheme memberships are captured in the [IE Core Patient](StructureDefinition-ie-core-patient.html) profile's identifier slices.

### Medication Adherence

The [IE Core Medication Adherence Extension](StructureDefinition-ie-core-medication-adherence.html) can be used on MedicationRequest to capture adherence information:

- Whether the patient is adhering to the prescribed regimen
- The source of the adherence information (patient self-report, pharmacy records, etc.)

### EU Cross-Border ePrescription

For cross-border prescription exchange via MyHealth@EU, the ePrescription profiles use:

- **NMPC** as the primary Irish medication code wherever available
- **SNOMED CT Irish Edition** as the preferred secondary medication code wherever available
- **ATC** for anatomical-therapeutic-chemical classification where required by cross-border workflows
- **Substitution** information per Irish pharmacy regulations
- **groupIdentifier** for multi-item prescriptions

See the [EHDS & EU Conformance](ehds-conformance.html) page for the full cross-border workflow.
