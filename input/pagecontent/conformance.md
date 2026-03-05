The IE Core Implementation Guide defines two approaches to conformance:

### 1. Profile Only Support

A system that supports IE Core Profiles **SHALL**:

- Be able to populate all mandatory elements as defined by each IE Core Profile
- Be able to populate all Must Support elements when the data is available
- Use the IE Core Profiles as the structure for FHIR resource instances

### 2. Profile + Interaction Support

A system that supports both IE Core Profiles and RESTful interactions **SHALL**:

- Meet all requirements of Profile Only Support (above)
- Support the RESTful interactions as documented in the [IE Core Server CapabilityStatement](CapabilityStatement-ie-core-server.html) or [IE Core Client CapabilityStatement](CapabilityStatement-ie-core-client.html) as appropriate
- Support the required search parameters for each resource
- Return resources conforming to the IE Core Profiles

See the sub-pages for detailed requirements:

- [General Requirements](general-requirements.html) - Overall conformance expectations
- [Must Support](must-support.html) - Definition and obligations for Must Support elements
- [SMART on FHIR](smart-on-fhir.html) - Authorization and access control requirements
