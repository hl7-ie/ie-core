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

In accordance with [HIQA's Guidance on Terminology Standards for Ireland](https://www.hiqa.ie/sites/default/files/2017-07/Guidance-on-terminology-standards-for-Ireland.pdf), **SNOMED CT is the primary clinical terminology** for medications in the Irish healthcare system. This aligns with Ireland's membership in [SNOMED International](https://www.snomed.org/) and the work of the [Irish National Release Centre](https://www.ehealthireland.ie/technology-and-transformation-functions/chief-data-and-analytics-office-cdao/standards-and-terminologies/snomed-ct/) within eHealth Ireland.

#### Required and Recommended Code Systems

| Code System | Status | Use | Notes |
|-------------|--------|-----|-------|
| **SNOMED CT** | **Required** | Primary clinical drug terminology | HIQA-recommended. Use the `373873005 \| Pharmaceutical / biologic product` hierarchy for medications. Irish Extension reference sets maintained by eHealth Ireland. |
| **ATC (WHO)** | Recommended | International classification of drugs | Required for EU cross-border exchange (EHDS/MyHealth@EU). Used alongside SNOMED CT for anatomical-therapeutic-chemical classification. |
| **LOINC** | Recommended | Laboratory-related medication observations | Used for observation codes related to medication monitoring. |
| **ICD-10** | Optional | Indication coding | May be used for diagnosis/indication alongside SNOMED CT. |

#### SNOMED CT for Medications

SNOMED CT provides a comprehensive and semantically rich vocabulary for clinical drugs. Key aspects for Irish implementations:

- **Product hierarchy**: Use concepts under `373873005 | Pharmaceutical / biologic product (product)` for medication coding
- **Irish Extension**: The SNOMED CT Irish Extension, maintained by eHealth Ireland, includes Ireland-specific reference sets for clinical domains including medications
- **Release cadence**: Irish Extension releases occur semi-annually (April and October), aligned with SNOMED International release schedules
- **Cross-mapping**: SNOMED CT concepts can be mapped to ATC codes for EU cross-border interoperability

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

- **SNOMED CT** as the primary medication code
- **ATC** for anatomical-therapeutic-chemical classification (required by MyHealth@EU)
- **Substitution** information per Irish pharmacy regulations
- **groupIdentifier** for multi-item prescriptions

See the [EHDS & EU Conformance](ehds-conformance.html) page for the full cross-border workflow.
