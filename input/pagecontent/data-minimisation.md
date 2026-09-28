<div class="note-to-balloters" markdown="1">

**Based on a consultation draft.** The datasets below follow the HIQA draft Patient Summary standard (September 2026).
This page explains how IE Core applies them. It is not legal advice.

</div>

### Principle

Under GDPR Article 5(1)(c), personal data must be *adequate, relevant and limited to what is necessary*. Ethnicity
is also special-category data (Article 9). HIQA defines a separate patient dataset for each use case, so each use
case has its own patient profile (ADR-002):

| Profile | Used by | What it carries |
|---|---|---|
| [IE Core Patient](StructureDefinition-ie-core-patient.html) | every other use case | A permissive base. The sensitive elements are allowed but carry no MustSupport, so no system is obliged to send or process them |
| [IE Core Patient (Patient Summary)](StructureDefinition-ie-core-patient-summary-patient.html) | Patient Summary | The HIQA PS Section 1 dataset, including the Required demographics, and a nominated contact person (PS Section 3) |
| ePrescription patient, in [IE Medication Events](https://hl7-ie.github.io/medication-events/) | ePrescription and eDispensation | **Only** the HIQA EP Section 1 dataset; ethnicity, maiden name, nationality and similar data are prohibited (ADR-009) |
{:.grid}

### What the Patient Summary carries

| Data | Patient Summary | Why |
|---|---|---|
| Ethnicity | Required (PS 1.4.10; CSO Data Standard for Ethnicity v1.0) | HIQA requires it for continuity of care; special-category data |
| Mother's former surnames | Required (PS 1.4.6) | Identity disambiguation |
| Nationality, place of birth, country of affiliation | Required (PS 1.4.7, 1.4.3, 1.4.8) | In the HIQA PS dataset |
| Religion, marital status, pronouns | **prohibited** | Not in the HIQA PS dataset |
| Sex assigned at birth | required (PS 1.4.4) | Clinically relevant; recorded separately from administrative gender and gender identity |
| PPSN | allowed, no MustSupport | The legal basis for health use is Requires Clarification (OI-008) |
{:.grid}

The prohibitions are enforced by the profile, so a validator rejects a non-conformant summary. The
[traceability matrix](hiqa-traceability.html) lists each prohibited element as *Prohibited (enforced)*.

### Patient Summary safeguards

The Patient Summary carries the extra demographics because HIQA requires them for continuity of care. HIQA notes that
ethnicity is "not used for patient identification" and should be collected with appropriate safeguards. See
[Security](security.html) for access control and audit expectations.
