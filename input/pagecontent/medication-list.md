### Medication List Guidance

IE Core provides three medication-related profiles to represent the full medication lifecycle:

| Profile | Use Case |
|---------|----------|
| [IE Core MedicationRequest](StructureDefinition-ie-core-medicationrequest.html) | Prescriptions and medication orders |
| [IE Core MedicationDispense](StructureDefinition-ie-core-medicationdispense.html) | Dispensing records from pharmacies |
| [IE Core Medication](StructureDefinition-ie-core-medication.html) | Medication definitions and details |

### Active Medication List

To retrieve a patient's active medication list:

```
GET [base]/MedicationRequest?patient=[id]&status=active
```

### Medication Coding

Medications in Ireland **SHOULD** be coded using one or more of the following code systems:

| Code System | Use |
|-------------|-----|
| ATC (WHO) | International classification of medications |
| RxNorm | Standard terminology for clinical drugs |
| SNOMED CT | Clinical terminology including medications |

### Irish Medication Schemes

Ireland has several medication reimbursement schemes that may be relevant:

- **GMS (General Medical Service)**: Medical card scheme covering full cost of prescribed medicines
- **DPS (Drugs Payment Scheme)**: Limits monthly expenditure on prescribed medicines per family
- **LTI (Long Term Illness)**: Covers medications for specified long-term conditions
- **HAA (Health Amendment Act)**: Covers individuals affected by contaminated blood products

These scheme memberships are captured in the [IE Core Patient](StructureDefinition-ie-core-patient.html) profile's identifier slices.

### Medication Adherence

The [IE Core Medication Adherence Extension](StructureDefinition-ie-core-medication-adherence.html) can be used on MedicationRequest to capture adherence information:

- Whether the patient is adhering to the prescribed regimen
- The source of the adherence information (patient self-report, pharmacy records, etc.)
