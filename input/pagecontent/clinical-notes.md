### Clinical Notes Guidance

Clinical notes in IE Core are represented using a combination of the [IE Core DiagnosticReport for Report and Note Exchange](StructureDefinition-ie-core-diagnosticreport-note.html) and [IE Core DocumentReference](StructureDefinition-ie-core-documentreference.html) profiles.

### Clinical Note Types

The following clinical note types are supported:

| Note Type | LOINC Code | Description |
|-----------|------------|-------------|
| Consultation Note | 11488-4 | Notes from clinical consultations |
| Discharge Summary | 18842-5 | Discharge summaries from hospital stays |
| History and Physical | 34117-2 | History and physical examination notes |
| Progress Note | 11506-3 | Clinical progress notes |
| Procedure Note | 28570-0 | Notes about procedures performed |
| Operative Note | 11504-8 | Notes about surgical operations |
| Imaging Narrative | 18748-4 | Radiology and imaging reports |
| Laboratory Narrative | 11502-2 | Laboratory result narratives |
| Pathology Report | 11526-1 | Pathology examination reports |
| Referral Note | 57133-1 | Referral letters and notes |

### Searching for Clinical Notes

To search for clinical notes, use the following approach:

```
GET [base]/DocumentReference?patient=[id]&category=clinical-note&type=[LOINC code]
```

```
GET [base]/DiagnosticReport?patient=[id]&category=[category code]&code=[LOINC code]
```

### Guidance for GP Practices

In the context of Irish general practice:

- GP consultation notes **SHOULD** use the Consultation Note type (LOINC 11488-4)
- Referral letters to hospital consultants **SHOULD** use the Referral Note type (LOINC 57133-1)
- Discharge summaries from hospitals **SHOULD** be received as Discharge Summary type (LOINC 18842-5)
- All clinical notes **SHALL** reference the patient and encounter where applicable
