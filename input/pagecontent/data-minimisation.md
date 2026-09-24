<div class="note-to-balloters" markdown="1">

**Based on consultation drafts.** The datasets below follow the HIQA draft national standards (September
2026). This page explains how IE Core applies them. It is not legal advice.

</div>

### Principle

Under GDPR Article 5(1)(c), personal data must be *adequate, relevant and limited to what is necessary*.
Ethnicity is also special-category data (Article 9). HIQA defines a separate patient dataset for each
use case, so IE Core uses a separate patient profile for each (ADR-002):

| Profile | Used by | What it carries |
|---|---|---|
| [IE Core Patient](StructureDefinition-ie-core-patient.html) | every other use case | A permissive base. The sensitive elements are allowed but carry no MustSupport, so no system is obliged to send or process them |
| [IE Core Patient (ePrescription)](StructureDefinition-ie-core-patient-eprescription.html) | ePrescription and eDispensation | **Only** the HIQA EP Section 1 dataset. Everything else is prohibited (`0..0`) |
| [IE Core Patient (Patient Summary)](StructureDefinition-ie-core-patient-summary-patient.html) | Patient Summary | The HIQA PS Section 1 dataset, including the Required demographics that the ePrescription does not use, and a nominated contact person (PS Section 3) |
{:.grid}

### What an ePrescription may not carry

A pharmacist dispensing a medicine does not need these, and HIQA does not include them in the EP dataset:

| Data | ePrescription | Patient Summary | Why |
|---|---|---|---|
| Ethnicity | **prohibited** | Required (PS 1.4.10; CSO Data Standard for Ethnicity v1.0) | Special-category data; not needed to dispense |
| Mother's maiden or former surnames | **prohibited** | Required (PS 1.4.6) | Identity matching uses the IHI, name, date of birth and address |
| Nationality | **prohibited** | Required (PS 1.4.7) | Not needed to dispense |
| Citizenship | **prohibited** | not a HIQA PS element (allowed by EU Base, no MustSupport) | Not needed to dispense |
| Place of birth, country of affiliation | **prohibited** | Required (PS 1.4.3, 1.4.8) | Not needed to dispense |
| Religion, marital status, pronouns | **prohibited** | **prohibited** | In neither HIQA dataset |
| Photo, contacts, multiple-birth indicator | **prohibited** | contacts: the nominated contact person (PS 3) | Not in the EP dataset |
| Sex assigned at birth | **required** (EP 1.4.3, Mandatory) | required (PS 1.4.4) | Clinically relevant to dosing and contraindications; recorded separately from administrative gender and gender identity |
| PPSN | allowed, no MustSupport | allowed, no MustSupport | The legal basis for health use is Requires Clarification (OI-008) |
{:.grid}

The prohibitions are enforced by the profile, so a validator rejects a non-conformant prescription. The
[traceability matrix](hiqa-traceability.html) lists each prohibited element as *Prohibited (enforced)*.

### How it is checked

- **Profiles.** `IECorePatientEPrescription` sets each prohibited extension slice and element to `0..0`.
  The prescription and dispense profiles only accept that patient profile as their subject.
- **Tests.** `data-minimisation.feature` checks the profile constraints and every ePrescription patient in
  the examples, including patients inside ePrescription Bundles.
- **Guard script.** `scripts/qa/check_ep_data_minimisation.py` fails the build if any ePrescription or
  eDispensation example, sample payload, CDA document, Postman body or test fixture mentions ethnicity,
  maiden name, nationality, citizenship, religion or marital status.

### Identity matching without the mother's maiden name

Removing the mother's maiden name from prescriptions could make identity matching harder (hazard HZ-06).
The HIQA EP dataset still carries the IHI (Required), forename and surname, date of birth and address
(all Mandatory), so matching relies on the IHI plus these demographics. IE Core accepts the IHI in its
18-digit and 10-digit forms (EP 1.3.1). The residual risk is recorded in the clinical-safety log.

### Patient Summary safeguards

The Patient Summary carries the extra demographics because HIQA requires them for continuity of care.
HIQA notes that ethnicity is "not used for patient identification" and should be collected with
appropriate safeguards. See [Security](security.html) for access control and audit expectations.
