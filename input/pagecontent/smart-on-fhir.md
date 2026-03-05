### SMART on FHIR Obligations and Capabilities

IE Core implementations **SHOULD** support [SMART App Launch Framework](http://hl7.org/fhir/smart-app-launch/) for authorization and authentication. This enables third-party applications to securely access patient data with appropriate consent.

### Authorization Scopes

IE Core defines the following recommended authorization scopes aligned with SMART on FHIR v2.0:

| Scope | Description |
|-------|-------------|
| `patient/Patient.read` | Read access to patient demographics |
| `patient/Observation.read` | Read access to observations including vital signs and lab results |
| `patient/Condition.read` | Read access to conditions and diagnoses |
| `patient/MedicationRequest.read` | Read access to medication prescriptions |
| `patient/AllergyIntolerance.read` | Read access to allergies and intolerances |
| `patient/Procedure.read` | Read access to procedures |
| `patient/Encounter.read` | Read access to encounters |
| `patient/DiagnosticReport.read` | Read access to diagnostic reports |
| `patient/DocumentReference.read` | Read access to clinical documents |
| `patient/Immunization.read` | Read access to immunization records |
| `patient/CarePlan.read` | Read access to care plans |
| `patient/CareTeam.read` | Read access to care team information |
| `patient/Goal.read` | Read access to clinical goals |
| `patient/Coverage.read` | Read access to insurance coverage |

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
