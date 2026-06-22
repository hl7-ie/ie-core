### HL7 FHIR Registry & Publication Guidance

**⚠️ Current Status:** This page provides aspirational guidance on formal HL7 publication. This IG is currently a Proof of Concept maintained by Nithin Mohan and hosted on GitHub Pages. These steps outline the future path when a governing body is established to oversee the Irish national IG.

This page provides step-by-step guidance on how to formally publish an Implementation Guide through the official HL7 FHIR registry, ensuring it is recognized as an authentic, standards-compliant IG.

### Why Publish Through HL7?

Publishing through the official HL7 FHIR registry:

- **Legitimacy**: Establishes the IG as an official, peer-reviewed standard
- **Discoverability**: Makes the IG findable through the [HL7 FHIR Registry](http://hl7.org/fhir/registry)
- **Trust**: Provides confidence to implementers that the IG follows HL7 processes
- **Interoperability**: Ensures the IG is compatible with the broader FHIR ecosystem
- **Package Distribution**: Enables distribution through the [FHIR Package Registry](https://packages.fhir.org)

### Step 1: Establish an HL7 Affiliate or Working Group

To publish an IG through HL7, you need an organizational relationship with HL7:

#### Option A: HL7 International Affiliate

1. **Contact HL7 International**: Visit [hl7.org](http://hl7.org) to establish an affiliate relationship for Ireland
2. **Establish HL7 Ireland**: Form a national HL7 affiliate organization
   - Requires a formal agreement with HL7 International
   - Requires governance structure (board, membership, working groups)
   - Annual affiliate fees apply
3. **Register the affiliate** at [hl7.org/affiliates](http://hl7.org/Special/Committees/Affiliates/affiliates.cfm)

#### Option B: HL7 FHIR Working Group Sponsorship

1. **Identify a sponsoring Work Group**: Work with an existing HL7 Work Group (e.g., Patient Administration, Clinical Quality, etc.)
2. **Submit a Project Scope Statement (PSS)**: Document the scope and purpose of the IG
3. **Get PSS approval** from the HL7 Technical Steering Committee (TSC)

#### Option C: FHIR Community Process (Recommended for initial publication)

1. **Use the HL7 FHIR Community Process** for community-developed IGs
2. **Register at** [https://confluence.hl7.org/display/FHIR/Community+Process](https://confluence.hl7.org/display/FHIR/Community+Process)
3. This allows publication without full HL7 membership while maintaining visibility

### Step 2: Canonical URL and Package Registration

#### Reserve Your Canonical URL

The canonical URL (`https://hl7-ie.github.io/ie-fhir-ig-core-draft/fhir/ie/core`) must be:

1. **Registered with HL7**: Contact HL7 to register the canonical URL namespace (future governance body)
2. **Under your control**: You must own or have authority over the domain
3. **Stable**: The URL must remain accessible for the life of the IG

#### Register the NPM Package

Register the package name (`hl7.fhir.ie.core`) on the [FHIR Package Registry](https://packages.fhir.org):

1. Build the IG using the HL7 IG Publisher (see build instructions)
2. The package will be named based on `sushi-config.yaml` settings
3. Contact the FHIR Package Registry administrators to register the package namespace

### Step 3: HL7 Ballot Process

The HL7 ballot process ensures quality and community consensus:

#### Pre-Ballot

1. **Prepare ballot content**: Ensure all profiles, examples, and documentation are complete
2. **QA Review**: Run the IG Publisher QA checks and resolve all errors
3. **Connectathon Testing**: Test the IG at HL7 FHIR Connectathon events

#### Ballot Submission

1. **Submit for ballot**: Work with your HL7 affiliate or sponsoring work group
2. **Ballot types**:
   - **For Comment**: Initial review, no formal vote required
   - **Standard for Trial Use (STU)**: Formal ballot requiring majority approval
   - **Normative**: Highest level, requires supermajority

#### Ballot Reconciliation

1. Review all ballot comments
2. Address negative votes and substantive comments
3. Publish a reconciliation document
4. Re-ballot if necessary

### Step 4: Publication

#### Publication on HL7 FHIR Registry

1. **Final QA**: Ensure the IG passes all HL7 publication QA checks
2. **Submit publication request**: Through the HL7 publication process
3. **Assigned URL**: The IG will be published at a URL under the HL7 FHIR registry

#### Package Publication

1. The IG package will be published to [packages.fhir.org](https://packages.fhir.org)
2. Implementers can then install it: `npm --registry https://packages.fhir.org install hl7.fhir.ie.core`

#### Ongoing Maintenance

1. **Issue tracking**: Maintain a Jira project for issue tracking
2. **Regular updates**: Publish updates through the ballot process
3. **Version management**: Follow semantic versioning

### Step 5: Domain Registration for hl7.hse.ie

To establish the `hl7.hse.ie` domain:

1. **Coordinate with HSE IT**: Request a subdomain under `hse.ie`
2. **DNS Configuration**: Point the domain to either:
   - A dedicated server hosting the IG
   - HL7's publication infrastructure (if using HL7's publishing pipeline)
   - A GitHub Pages deployment of the built IG
3. **HTTPS Certificate**: Obtain and configure SSL/TLS certificates

#### Alternative: Use HL7's Infrastructure

If the `hl7.hse.ie` domain is not immediately available:
1. Use `http://hl7.org/fhir/ie/core` as the canonical URL (requires HL7 affiliate status)
2. Publish through HL7's standard publication pipeline
3. Redirect `hl7.hse.ie` to the HL7-hosted content when the domain becomes available

### Key Contacts and Resources

| Resource | Link |
|----------|------|
| HL7 International | [hl7.org](http://hl7.org) |
| HL7 Affiliates | [hl7.org/affiliates](http://hl7.org/Special/Committees/Affiliates/affiliates.cfm) |
| FHIR Community Process | [confluence.hl7.org](https://confluence.hl7.org/display/FHIR/Community+Process) |
| FHIR Package Registry | [packages.fhir.org](https://packages.fhir.org) |
| IG Publisher | [github.com/HL7/fhir-ig-publisher](https://github.com/HL7/fhir-ig-publisher) |
| SUSHI (FSH Compiler) | [fshschool.org](https://fshschool.org) |
| FSH Documentation | [build.fhir.org/ig/HL7/fhir-shorthand](http://build.fhir.org/ig/HL7/fhir-shorthand/) |
| HL7 Jira | [jira.hl7.org](https://jira.hl7.org) |
| FHIR Chat (Zulip) | [chat.fhir.org](https://chat.fhir.org) |
| HL7 Confluence | [confluence.hl7.org](https://confluence.hl7.org) |

### Comparison: Authentic vs. Unofficial IGs

| Aspect | Authentic HL7 IG | Unofficial/Vendor IG |
|--------|------------------|---------------------|
| **Canonical URL** | Under hl7.org or registered national domain | Arbitrary vendor domain |
| **Package Registry** | Listed on packages.fhir.org | Not listed or self-hosted |
| **Ballot Process** | Formal HL7 ballot with community review | No formal review |
| **OID Assignment** | Official OID from HL7 | Self-assigned OID |
| **Governance** | HL7 work group oversight | Vendor-controlled |
| **Conformance Testing** | Connectathon-tested | Limited or no testing |
| **Long-term Stability** | HL7 commitment to maintenance | Depends on vendor viability |
| **FHIR Registry Listed** | Yes | No |
