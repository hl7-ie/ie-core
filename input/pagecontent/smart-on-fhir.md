### SMART on FHIR Obligations and Capabilities

IE Core implementations **SHOULD** support [SMART App Launch Framework v2.2](http://hl7.org/fhir/smart-app-launch/2.2.0/) for authorization and authentication. This enables third-party applications to securely access patient data with appropriate consent, and aligns with the SMART on FHIR conformance approach adopted by the HL7 Europe Health Data API IG for EHDS/XT-EHR data access.

### Authorization Scopes

IE Core defines the following recommended authorization scopes using the **v2 granular scope syntax** (`.rs`/`.cruds`) defined by [SMART App Launch v2.2](http://hl7.org/fhir/smart-app-launch/2.2.0/scopes-and-launch-context.html#quick-start). Legacy v1 scopes (`.read`/`.write`) **SHOULD NOT** be used for new implementations, as v1 scope syntax is deprecated by SMART App Launch v2 and is being retired across 2026-era national Core IGs (e.g. US Core, AU Core):

| Scope | Description |
|-------|-------------|
| `patient/Patient.rs` | Read and search access to patient demographics |
| `patient/Observation.rs` | Read and search access to observations including vital signs and lab results |
| `patient/Condition.rs` | Read and search access to conditions and diagnoses |
| `patient/MedicationRequest.rs` | Read and search access to medication prescriptions |
| `patient/AllergyIntolerance.rs` | Read and search access to allergies and intolerances |
| `patient/Procedure.rs` | Read and search access to procedures |
| `patient/Encounter.rs` | Read and search access to encounters |
| `patient/DiagnosticReport.rs` | Read and search access to diagnostic reports |
| `patient/DocumentReference.rs` | Read and search access to clinical documents |
| `patient/Immunization.rs` | Read and search access to immunization records |
| `patient/CarePlan.rs` | Read and search access to care plans |
| `patient/CareTeam.rs` | Read and search access to care team information |
| `patient/Goal.rs` | Read and search access to clinical goals |
| `patient/Coverage.rs` | Read and search access to insurance coverage |

For fine-grained data segmentation (e.g. restricting access to sensitive categories under GDPR Article 9), servers **MAY** additionally support [SMART v2 search-parameter-scoped scopes](http://hl7.org/fhir/smart-app-launch/2.2.0/scopes-and-launch-context.html#finer-grained-resource-constraints) (e.g. `patient/Observation.rs?category=vital-signs`).

### Server Obligations

Servers implementing SMART on FHIR **SHALL**:

1. Support the `.well-known/smart-configuration` endpoint
2. Support the `authorize` and `token` endpoints
3. Support the `launch-standalone` and `launch-ehr` capabilities
4. Support the `client-confidential-symmetric` capability for backend services
5. Implement token introspection or validation for all FHIR API requests

### Client Obligations

Client applications **SHALL**:

1. Obtain authorization before accessing patient data
2. Request only the minimum scopes needed
3. Handle token expiration and refresh appropriately
4. Respect scope limitations when accessing resources

### Irish-Specific Considerations

In the context of Ireland's healthcare system:

- Authorization servers **SHOULD** integrate with HSE identity management systems
- Patient consent **SHALL** be obtained in accordance with the Health Information and Patient Safety (HIPS) Bill requirements
- Data access logging **SHALL** comply with GDPR requirements
- Cross-organizational data sharing **SHOULD** leverage the national health information exchange infrastructure
