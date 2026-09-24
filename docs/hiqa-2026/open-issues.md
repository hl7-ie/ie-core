# Open issues: Requires Clarification

Items that the HIQA drafts, or other authoritative sources available to this PoC, do not settle.
Nothing here is invented. Where the IG needs a value in the meantime, it uses a clearly named
placeholder and points back to this list.

| ID | Topic | What is unclear | Source | Placeholder / interim handling | Owner to ask |
|---|---|---|---|---|---|
| OI-001 | IG Publisher and validator baseline | `publisher.jar` and `validator_cli.jar` are not installed locally, so there are no QA or validation counts for the baseline | Phase 1 | QA gate disabled until a baseline is recorded | Project owner (approve download) |
| OI-002 | IHI format | HIQA says "18 or 10-digit". How the forms relate (legacy vs current, check digit) is not stated | EP/PS 1.3.1 | Accept `^[0-9]{18}$` or `^[0-9]{10}$` | HSE (IHI Register) |
| OI-003 | Identifier system URIs | No HSE-published FHIR `system` URIs for IHI, PPSN, PCRS schemes, NePS or PSI. The current `sid/*` URIs are minted under this IG's canonical | EP/PS 1.3, 2.6, 2.8, 3.1 | Keep the IG-minted URIs, marked "placeholder" in the NamingSystem description | HSE / NePS team |
| OI-004 | SNOMED CT Irish edition module | The brief says `11000220105`. The HSE CTS reports `1601000220105`. Anonymous `$lookup` fails on both; tx.fhir.org does not host the IE edition | — | Keep `1601000220105` (what the HSE CTS serves) | HSE CTTO terminology team |
| OI-005 | Ethnicity classification | Which CSO classification (Census 2022?) and code representation HIQA intends. The current CS looks out of date | PS 1.4.10; PS p. 15 names CSO as a source | Keep the CS scoped to the Patient Summary; verify in Phase 7 | CSO / HIQA |
| OI-006 | Anomalies in the HIQA drafts | "Mandatory 0..n" (EP 1.6.x.4.2/3, PS 13.3.2, 15.2.1, 19.1.12.x); "Required 1..1" (PS 16.2); numbering (PS 4.4.6, PS 6.3.11.1, EP 3.6.1); PS 6.3 Medication 0..1; Table 3 numbering differs from the dataset | See `docs/audit/baseline.md` I-01 | Mandatory-inside-an-optional-cluster is read as "1..1 if the parent is present" | HIQA (consultation feedback) |
| OI-007 | Coded values in general | HIQA: "Coded values have not yet been specified in this standard" | EP p. 18, PS p. 15 | Bindings chosen from recognised standards, labelled as IE Core choices | HIQA |
| OI-008 | PPSN in health records | The legal basis and limits for using the PPSN as a health identifier. HIQA includes it (Required), but PPSN use is restricted by statute | EP/PS 1.3.2 | Slice with **no MustSupport** | DoH / DPC / HIQA |
