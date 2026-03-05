### Security

IE Core implementations **SHALL** address security considerations to protect patient data in accordance with Irish and EU regulations.

### Regulatory Framework

Implementations must comply with:

- **GDPR (General Data Protection Regulation)**: EU regulation on data protection and privacy
- **Health Act 2007**: Irish legislation governing health information
- **Data Protection Act 2018**: Irish implementation of GDPR
- **eIDAS Regulation**: EU regulation on electronic identification and trust services

### Transport Security

All IE Core API communications **SHALL** use:

- **TLS 1.2 or higher** for all communications
- **HTTPS** for all FHIR RESTful API endpoints
- Valid server certificates from a trusted Certificate Authority

### Authentication and Authorization

IE Core implementations **SHOULD** support:

- [SMART on FHIR](http://hl7.org/fhir/smart-app-launch/) for application-level authorization
- OAuth 2.0 for API access control
- OpenID Connect for user authentication

### Access Control

Implementations **SHALL**:

- Implement role-based access control (RBAC) appropriate to the healthcare setting
- Enforce the principle of least privilege
- Support emergency access ("break the glass") procedures with appropriate audit logging
- Restrict access to patient data based on the practitioner's legitimate relationship with the patient

### Audit Logging

All access to patient data **SHALL** be logged in accordance with GDPR requirements:

- **What** data was accessed
- **Who** accessed the data (user identity)
- **When** the access occurred (timestamp)
- **Why** the access occurred (purpose of use)
- **How** the data was accessed (application, API endpoint)

Audit logs **SHOULD** be represented using the [FHIR AuditEvent](http://hl7.org/fhir/R4/auditevent.html) resource.

### Consent Management

Patient consent for data sharing **SHALL** be:

- Recorded and maintained in accordance with GDPR requirements
- Obtainable and revocable by the patient
- Granular where possible (by data category, recipient, time period)

### Data Minimization

In accordance with GDPR's data minimization principle:

- Only request the minimum data needed for the intended purpose
- Use SMART on FHIR scopes to limit data access
- Implement server-side filtering to exclude unnecessary data elements

### Breach Notification

In the event of a data breach:

- Notify the Data Protection Commission (DPC) within 72 hours
- Notify affected patients without undue delay when the breach is likely to result in a high risk to their rights and freedoms
- Document the breach, its effects, and the remedial action taken
