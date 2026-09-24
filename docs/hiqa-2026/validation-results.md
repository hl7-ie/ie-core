# Example validation results (Phases 8–10)

| | |
|---|---|
| Date | 2026-09-24 |
| Tool | HL7 FHIR Validator CLI 6.10.4, FHIR 4.0.1 |
| Command | `cd tests && node validator/run-validation.js --tx` (dependencies read from `sushi-config.yaml`) |
| Terminology | tx.fhir.org (codes and displays checked) |
| Result | **168 passed, 0 failed, 168 examples**: 146 SUSHI-generated (including the 52 HIQA scenario resources) and 22 hand-written payload Bundles in `input/examples` |

An example fails when the validator reports an error or fatal issue. Warnings remain; the common ones are:
missing narrative (dom-6, best practice); `address.state` county names against the coded county
ValueSet (OI-021); UCUM annotations such as `{tablet}` (best practice); eHDSI ValueSets not
resolvable on tx.fhir.org; the SNOMED CT Irish edition not hosted on tx.fhir.org (OI-022).

## Whole-IG validator QA (proxy for the IG Publisher QA; OI-001)

`python scripts/qa/validate_all.py . tests/validator/validator_cli.jar <out>` over every generated resource:

| Run | Errors | Resources with errors | Notes |
|---|---|---|---|
| `main` baseline | 48 | 9 | |
| Phase 7 | 30 | 1 | all 30 are ImplementationGuide parameter codes (a validator artefact present on `main` too) |
| Phases 8–10 | 35 | 6 | the same 30, plus 5 ValueSets that filter on the SNOMED CT Irish edition, which tx.fhir.org does not host (OI-022). No example has an error |

## Per example

| Example | Status | Errors | Warnings |
|---|---|---|---|
| `AllergyIntolerance-hiqa-allergy-niamh-penicillin.json` | PASS | 0 | 2 |
| `AllergyIntolerance-hiqa-ps-allergy-niamh.json` | PASS | 0 | 2 |
| `AllergyIntolerance-ie-core-allergy-example.json` | PASS | 0 | 1 |
| `AllergyIntolerance-ie-core-allergy-penicillin-murphy.json` | PASS | 0 | 1 |
| `BE_to_IE_eDispensation_via_NePS_FHIR.json` | PASS | 0 | 13 |
| `Bundle-hiqa-bundle-s1-acute-adult.json` | PASS | 0 | 18 |
| `Bundle-hiqa-bundle-s2-paediatric.json` | PASS | 0 | 15 |
| `Bundle-hiqa-bundle-s3-repeat.json` | PASS | 0 | 23 |
| `Bundle-hiqa-bundle-s4-controlled-drug.json` | PASS | 0 | 18 |
| `Bundle-hiqa-bundle-s5-non-dispensation.json` | PASS | 0 | 19 |
| `Bundle-hiqa-bundle-s6-crossborder.json` | PASS | 0 | 31 |
| `Bundle-hiqa-bundle-s7-patient-summary-full.json` | PASS | 0 | 22 |
| `Bundle-hiqa-bundle-s8-patient-summary-empty.json` | PASS | 0 | 8 |
| `Composition-hiqa-ps-composition-niamh.json` | PASS | 0 | 1 |
| `Composition-hiqa-ps-composition-tomas-empty.json` | PASS | 0 | 1 |
| `Condition-hiqa-ps-condition-asthma.json` | PASS | 0 | 1 |
| `Condition-ie-core-condition-example.json` | PASS | 0 | 1 |
| `Condition-ie-core-condition-hypercholesterolaemia-murphy.json` | PASS | 0 | 1 |
| `Condition-ie-core-condition-hypertension-murphy.json` | PASS | 0 | 1 |
| `Condition-ie-core-condition-t2dm-murphy.json` | PASS | 0 | 1 |
| `Coverage-hiqa-ps-coverage-niamh.json` | PASS | 0 | 1 |
| `DE_Patient_to_IE_NePS_Dispensation_FHIR.json` | PASS | 0 | 14 |
| `DE_eDispensation_Response_FHIR.json` | PASS | 0 | 14 |
| `Encounter-ie-core-encounter-example.json` | PASS | 0 | 1 |
| `FI_to_IE_eDispensation_via_NePS_FHIR.json` | PASS | 0 | 14 |
| `IE_Patient_IPS_FHIR.json` | PASS | 0 | 11 |
| `IE_to_AT_ePrescription_FHIR.json` | PASS | 0 | 13 |
| `IE_to_DE_ePrescription_FHIR.json` | PASS | 0 | 23 |
| `IE_to_DK_ePrescription_FHIR.json` | PASS | 0 | 9 |
| `IE_to_ES_ePrescription_FHIR.json` | PASS | 0 | 21 |
| `IE_to_FR_ePrescription_FHIR.json` | PASS | 0 | 14 |
| `IE_to_LV_ePrescription_FHIR.json` | PASS | 0 | 15 |
| `IE_to_NL_ePrescription_FHIR.json` | PASS | 0 | 21 |
| `IE_to_PT_ePrescription_FHIR.json` | PASS | 0 | 14 |
| `IE_to_SE_ePrescription_FHIR.json` | PASS | 0 | 13 |
| `Immunization-hiqa-ps-immunization-flu.json` | PASS | 0 | 2 |
| `Immunization-ie-core-immunization-example.json` | PASS | 0 | 1 |
| `LV_to_IE_eDispensation_FHIR.json` | PASS | 0 | 13 |
| `List-hiqa-allergies-declan-nilknown.json` | PASS | 0 | 1 |
| `List-hiqa-allergies-niamh.json` | PASS | 0 | 1 |
| `List-hiqa-allergies-oisin-nilknown.json` | PASS | 0 | 1 |
| `List-hiqa-allergies-tomas-nilknown.json` | PASS | 0 | 1 |
| `Location-ie-core-location-example.json` | PASS | 0 | 2 |
| `Medication-hiqa-med-amoxicillin-500-caps.json` | PASS | 0 | 6 |
| `Medication-hiqa-med-amoxicillin-50mgml-susp.json` | PASS | 0 | 5 |
| `Medication-hiqa-med-oxycodone-10-pr.json` | PASS | 0 | 6 |
| `Medication-hiqa-med-salbutamol-inhaler.json` | PASS | 0 | 8 |
| `Medication-ie-core-medication-amlodipine-5.json` | PASS | 0 | 8 |
| `Medication-ie-core-medication-atorvastatin-20.json` | PASS | 0 | 8 |
| `Medication-ie-core-medication-metformin-500.json` | PASS | 0 | 8 |
| `Medication-ie-core-medication-ramipril-5.json` | PASS | 0 | 8 |
| `Medication-ie-medication-atorvastatin-40.json` | PASS | 0 | 6 |
| `Medication-ie-medication-atorvastatin-80.json` | PASS | 0 | 7 |
| `Medication-ie-medication-dispensed-be-to-ie-neps.json` | PASS | 0 | 2 |
| `Medication-ie-medication-dispensed-de-lisinopril.json` | PASS | 0 | 2 |
| `Medication-ie-medication-dispensed-de-metformin.json` | PASS | 0 | 2 |
| `Medication-ie-medication-dispensed-fi-to-ie-neps.json` | PASS | 0 | 2 |
| `Medication-ie-medication-dispensed-lv-metformin.json` | PASS | 0 | 2 |
| `Medication-ie-medication-dispensed-pt-sertraline.json` | PASS | 0 | 2 |
| `Medication-ie-medication-insulin-aspart.json` | PASS | 0 | 6 |
| `Medication-ie-medication-insulin-glargine.json` | PASS | 0 | 6 |
| `Medication-ie-medication-lisinopril-10.json` | PASS | 0 | 7 |
| `Medication-ie-medication-omeprazole-20.json` | PASS | 0 | 7 |
| `Medication-ie-medication-ramipril-10.json` | PASS | 0 | 7 |
| `Medication-ie-medication-sertraline-50.json` | PASS | 0 | 7 |
| `Medication-ie-medication-warfarin-5.json` | PASS | 0 | 7 |
| `MedicationDispense-hiqa-md-s1-amoxicillin.json` | PASS | 0 | 2 |
| `MedicationDispense-hiqa-md-s3-balance.json` | PASS | 0 | 2 |
| `MedicationDispense-hiqa-md-s3-part-fill.json` | PASS | 0 | 2 |
| `MedicationDispense-hiqa-md-s3-repeat-1.json` | PASS | 0 | 2 |
| `MedicationDispense-hiqa-md-s4-instalment-1.json` | PASS | 0 | 2 |
| `MedicationDispense-hiqa-md-s5-declined.json` | PASS | 0 | 2 |
| `MedicationDispense-ie-dispense-be-to-ie-neps.json` | PASS | 0 | 2 |
| `MedicationDispense-ie-dispense-de-lisinopril.json` | PASS | 0 | 2 |
| `MedicationDispense-ie-dispense-de-metformin.json` | PASS | 0 | 2 |
| `MedicationDispense-ie-dispense-fi-to-ie-neps.json` | PASS | 0 | 2 |
| `MedicationDispense-ie-dispense-lv-metformin.json` | PASS | 0 | 2 |
| `MedicationDispense-ie-dispense-pt-sertraline.json` | PASS | 0 | 2 |
| `MedicationDispense-ie-dispense-scenario1-full.json` | PASS | 0 | 2 |
| `MedicationDispense-ie-dispense-scenario2-partial-1.json` | PASS | 0 | 2 |
| `MedicationDispense-ie-dispense-scenario2-partial-2.json` | PASS | 0 | 2 |
| `MedicationDispense-ie-dispense-scenario2-partial-3.json` | PASS | 0 | 2 |
| `MedicationDispense-ie-dispense-scenario3-atorvastatin.json` | PASS | 0 | 2 |
| `MedicationDispense-ie-dispense-scenario3-metformin.json` | PASS | 0 | 2 |
| `MedicationDispense-ie-dispense-scenario3-ramipril.json` | PASS | 0 | 2 |
| `MedicationDispense-ie-dispense-scenario4-es-pharmacy.json` | PASS | 0 | 2 |
| `MedicationDispense-ie-dispense-scenario5-ie-pharmacy.json` | PASS | 0 | 2 |
| `MedicationDispense-ie-dispense-scenario6-repeat-month1.json` | PASS | 0 | 2 |
| `MedicationDispense-ie-dispense-scenario6-repeat-month2.json` | PASS | 0 | 2 |
| `MedicationDispense-ie-dispense-scenario6-repeat-month3.json` | PASS | 0 | 2 |
| `MedicationRequest-hiqa-rx-s1-amoxicillin.json` | PASS | 0 | 3 |
| `MedicationRequest-hiqa-rx-s2-amoxicillin-paeds.json` | PASS | 0 | 1 |
| `MedicationRequest-hiqa-rx-s3-salbutamol-repeat.json` | PASS | 0 | 5 |
| `MedicationRequest-hiqa-rx-s4-oxycodone.json` | PASS | 0 | 4 |
| `MedicationRequest-hiqa-rx-s5-amoxicillin.json` | PASS | 0 | 3 |
| `MedicationRequest-hiqa-rx-s6-atorvastatin.json` | PASS | 0 | 3 |
| `MedicationRequest-hiqa-rx-s6-metformin.json` | PASS | 0 | 3 |
| `MedicationRequest-ie-core-medicationrequest-example.json` | PASS | 0 | 4 |
| `MedicationRequest-ie-prescription-scenario1-full.json` | PASS | 0 | 2 |
| `MedicationRequest-ie-prescription-scenario2-partial.json` | PASS | 0 | 2 |
| `MedicationRequest-ie-prescription-scenario3-multi-atorvastatin.json` | PASS | 0 | 2 |
| `MedicationRequest-ie-prescription-scenario3-multi-metformin.json` | PASS | 0 | 2 |
| `MedicationRequest-ie-prescription-scenario3-multi-ramipril.json` | PASS | 0 | 2 |
| `MedicationRequest-ie-prescription-scenario4-ie-to-es.json` | PASS | 0 | 2 |
| `MedicationRequest-ie-prescription-scenario5-es-to-ie.json` | PASS | 0 | 2 |
| `MedicationRequest-ie-prescription-scenario6-repeat.json` | PASS | 0 | 2 |
| `MedicationRequest-ie-rx-be-atorvastatin-neps.json` | PASS | 0 | 2 |
| `MedicationRequest-ie-rx-fi-metformin-neps.json` | PASS | 0 | 2 |
| `MedicationRequest-ie-rx-sean-at-atorvastatin80.json` | PASS | 0 | 2 |
| `MedicationRequest-ie-rx-sean-de-lisinopril.json` | PASS | 0 | 2 |
| `MedicationRequest-ie-rx-sean-de-metformin.json` | PASS | 0 | 2 |
| `MedicationRequest-ie-rx-sean-dk-warfarin.json` | PASS | 0 | 2 |
| `MedicationRequest-ie-rx-sean-lv-metformin.json` | PASS | 0 | 2 |
| `MedicationRequest-ie-rx-sean-pt-sertraline.json` | PASS | 0 | 2 |
| `MedicationRequest-ie-rx-sean-se-insulin-glargine.json` | PASS | 0 | 2 |
| `MedicationStatement-hiqa-ps-medstatement-niamh.json` | PASS | 0 | 1 |
| `Observation-hiqa-weight-oisin.json` | PASS | 0 | 2 |
| `Observation-ie-core-observation-bp-example.json` | PASS | 0 | 1 |
| `Observation-ie-core-observation-lab-example.json` | PASS | 0 | 1 |
| `Organization-hiqa-org-gp-practice.json` | PASS | 0 | 2 |
| `Organization-hiqa-org-hse.json` | PASS | 0 | 1 |
| `Organization-hiqa-org-pharmacy.json` | PASS | 0 | 2 |
| `Organization-ie-core-organization-es-health-centre.json` | PASS | 0 | 1 |
| `Organization-ie-core-organization-es-pharmacy.json` | PASS | 0 | 1 |
| `Organization-ie-core-organization-example.json` | PASS | 0 | 2 |
| `Organization-ie-core-organization-grafton-medical.json` | PASS | 0 | 1 |
| `Organization-ie-core-organization-pharmacy-example.json` | PASS | 0 | 2 |
| `Organization-ie-org-at-apotheke-goldene-kugel.json` | PASS | 0 | 1 |
| `Organization-ie-org-de-apotheke-brandenburger.json` | PASS | 0 | 1 |
| `Organization-ie-org-dk-apoteket-copenhagen.json` | PASS | 0 | 1 |
| `Organization-ie-org-ie-hickeys-pharmacy.json` | PASS | 0 | 1 |
| `Organization-ie-org-ie-mccauleys-pharmacy.json` | PASS | 0 | 1 |
| `Organization-ie-org-lv-mes-aptieka.json` | PASS | 0 | 1 |
| `Organization-ie-org-pt-farmacia-central-lisbon.json` | PASS | 0 | 1 |
| `Organization-ie-org-se-apoteket-hjartat.json` | PASS | 0 | 1 |
| `PT_to_IE_eDispensation_FHIR.json` | PASS | 0 | 13 |
| `Patient-hiqa-patient-declan-walsh.json` | PASS | 0 | 3 |
| `Patient-hiqa-patient-niamh-keane.json` | PASS | 0 | 3 |
| `Patient-hiqa-patient-oisin-brady.json` | PASS | 0 | 3 |
| `Patient-hiqa-patient-tomas-quinn.json` | PASS | 0 | 4 |
| `Patient-hiqa-ps-patient-niamh.json` | PASS | 0 | 3 |
| `Patient-hiqa-ps-patient-tomas.json` | PASS | 0 | 3 |
| `Patient-ie-core-patient-child-example.json` | PASS | 0 | 3 |
| `Patient-ie-core-patient-ciaran-walsh.json` | PASS | 0 | 4 |
| `Patient-ie-core-patient-deceased-example.json` | PASS | 0 | 4 |
| `Patient-ie-core-patient-es-maria-garcia.json` | PASS | 0 | 4 |
| `Patient-ie-core-patient-example.json` | PASS | 0 | 4 |
| `Patient-ie-core-patient-sean-murphy.json` | PASS | 0 | 5 |
| `Patient-ie-patient-be-lars-janssen.json` | PASS | 0 | 3 |
| `Patient-ie-patient-fi-mikko-korhonen.json` | PASS | 0 | 3 |
| `Practitioner-hiqa-prac-gp-nolan.json` | PASS | 0 | 1 |
| `Practitioner-hiqa-prac-pharmacist-farrell.json` | PASS | 0 | 1 |
| `Practitioner-ie-core-practitioner-aoife-obrien.json` | PASS | 0 | 1 |
| `Practitioner-ie-core-practitioner-es-example.json` | PASS | 0 | 1 |
| `Practitioner-ie-core-practitioner-es-pharmacist.json` | PASS | 0 | 1 |
| `Practitioner-ie-core-practitioner-example.json` | PASS | 0 | 2 |
| `Practitioner-ie-core-practitioner-pharmacist-example.json` | PASS | 0 | 2 |
| `PractitionerRole-hiqa-role-gp-nolan.json` | PASS | 0 | 1 |
| `PractitionerRole-ie-core-practitionerrole-example.json` | PASS | 0 | 1 |
| `Procedure-hiqa-ps-procedure-appendectomy.json` | PASS | 0 | 1 |
| `Provenance-hiqa-provenance-s6-signature.json` | PASS | 0 | 1 |
| `Provenance-ie-core-provenance-example.json` | PASS | 0 | 1 |
| `scenario-1-local-ie-full-dispense.json` | PASS | 0 | 21 |
| `scenario-2-local-ie-partial-dispense.json` | PASS | 0 | 21 |
| `scenario-3-multiple-prescriptions.json` | PASS | 0 | 36 |
| `scenario-4-ie-to-es-crossborder.json` | PASS | 0 | 18 |
| `scenario-5-es-to-ie-crossborder.json` | PASS | 0 | 19 |
| `scenario-6-repeat-prescription.json` | PASS | 0 | 20 |
