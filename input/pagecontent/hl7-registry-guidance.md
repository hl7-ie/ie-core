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

#### Package Naming Convention

The package id is `nostalgic-ie.fhir.core` (ADR-008). The FHIR package specification says "HL7 manages all the packages that start with `hl7.`", so an unofficial proof of concept must not publish under `hl7.fhir.ie.core`. That name is left for HL7 and a future Irish governing body; if one adopts this work, it can publish it under an official id.

#### Reserve Your Canonical URL

The canonical URL (`https://hl7-ie.github.io/ie-core/fhir/ie/core`) must be:

1. **Registered with HL7**: Contact HL7 to register the canonical URL namespace (future governance body)
2. **Under your control**: You must own or have authority over the domain
3. **Stable**: The URL must remain accessible for the life of the IG

**Current status**: The canonical URL above is a **GitHub Pages placeholder** under the `hl7-ie` GitHub organization, used only while this IG remains a Proof of Concept. It is not a claim of official HL7 registration and will be replaced once a formal governance body registers a permanent namespace.

#### Register the NPM Package

Publish the package (`nostalgic-ie.fhir.core`) through Simplifier.net, which feeds the [FHIR Package Registry](https://packages.fhir.org) (see [Publishing on Simplifier.net](simplifier-publishing.html)):

1. Build the IG using the HL7 IG Publisher (see build instructions)
2. The package will be named based on `sushi-config.yaml` settings
3. Public Simplifier.net packages are listed on the FHIR Package Registry; no separate namespace registration is needed for a non-`hl7.` id

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
2. Implementers can then install it: `npm --registry https://packages.simplifier.net install nostalgic-ie.fhir.core`

#### Ongoing Maintenance

1. **Issue tracking**: Maintain a Jira project for issue tracking
2. **Regular updates**: Publish updates through the ballot process
3. **Version management**: Follow semantic versioning

### Step 5: A stable domain: fhir.hl7.studio (conceptual)

> **Conceptual, not live.** `fhir.hl7.studio` is a domain registered by the author of this proof of concept.
> It is **not** an HL7 International, HL7 Ireland or HSE domain. The IG's canonical remains
> `https://hl7-ie.github.io/ie-core/fhir/ie/core` until a decision is made to move it.

The plan is one host for FHIR work (`fhir.hl7.studio`), with a path per jurisdiction (`fhir.hl7.studio/ie`).
A future IE Core canonical would then be `https://fhir.hl7.studio/ie/core`.

1. **DNS**: point `fhir.hl7.studio` at the hosting (see the records below).
2. **Hosting**: publish the built IG so that `https://fhir.hl7.studio/ie/core/` serves the IG home page and
   every canonical URL (`.../StructureDefinition/<id>`) resolves to its page.
3. **HTTPS**: required; GitHub Pages provisions a Let's Encrypt certificate once DNS resolves.
4. **Canonical change**: moving the canonical is a breaking change for every profile, extension,
   ValueSet and CodeSystem URL. It needs an ADR, a `changes.md` entry and redirects from the old URLs.
5. **Package registry**: validators resolve canonicals from FHIR packages, not from DNS. To make
   `fhir.hl7.studio/ie/core` resolvable for validation, publish the package with a `package-feed.xml` at a
   stable URL and ask for it to be added to the packages.fhir.org feed list.

#### Suggested DNS records (hosting on GitHub Pages)

| Name | Type | Value | Purpose |
|---|---|---|---|
| `fhir.hl7.studio` | CNAME | `hl7-ie.github.io.` (the owner of the Pages site) | Serves the IG; set the same custom domain in the repository's Pages settings and enable "Enforce HTTPS" |
| `_github-pages-challenge-<owner>.hl7.studio` | TXT | the value GitHub shows when you verify the domain | Domain verification: stops another GitHub account from claiming the domain |
| `hl7.studio` | CAA | `0 issue "letsencrypt.org"` | Only Let's Encrypt (used by GitHub Pages) may issue certificates |
| `hl7.studio` | MX | `0 .` (null MX, RFC 7505) | The domain receives no email (if no mailbox is used) |
| `hl7.studio` | TXT | `v=spf1 -all` | Nobody may send email as the domain |
| `_dmarc.hl7.studio` | TXT | `v=DMARC1; p=reject;` | Receivers reject mail spoofing the domain |
{:.grid}

Also turn on **DNSSEC** at the registrar. If `www.hl7.studio` or the apex should also serve a site on
GitHub Pages, add `www` CNAME `<owner>.github.io.` and apex A/AAAA records to the IP addresses listed in
GitHub's Pages documentation (check them there rather than copying them from here).

The `/ie` path needs the site layout to match: either publish the IG output under `ie/core/` in the Pages
site that owns `fhir.hl7.studio`, or keep the IE Core repository's Pages site and serve it from a subdomain
(for example `ie.fhir.hl7.studio`). The generator `scripts/generate-canonical-redirects.mjs` would need the
new base.

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
