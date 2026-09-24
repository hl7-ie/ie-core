# ADR-008: Package id and distribution through Simplifier.net

- **Status:** Accepted (24 September 2026; package id and release code name chosen by the project owner).
- **Breaking:** yes, for anyone who installed the (never published) `hl7.fhir.ie.core` package from a local build.

## Context

The project owner wants the complete IG publishable through Simplifier.net as well as GitHub Pages. Simplifier
releases packages to its registry, which feeds the public FHIR package ecosystem. Three facts constrain this:

- The FHIR package specification: "HL7 manages all the packages that start with `hl7.`"
  ([FHIR packages](https://hl7.org/fhir/packages.html)). IE Core is a proof of concept, not an HL7 publication, so
  it must not publish `hl7.fhir.ie.core`.
- Simplifier never deletes a released package; mistakes can only be unlisted or superseded
  ([package policy](https://github.com/FirelyTeam/firely-docs-simplifier/blob/main/package_releases/simplifierPackageCreationCheck.rst)).
- Simplifier imports JSON/XML (not FSH), and its GitHub integration needs a Team plan
  ([GitHub integration](https://github.com/FirelyTeam/firely-docs-simplifier/blob/main/adding_content/github.rst)).
  SUSHI output is not committed.

## Options

| | A. Code-name id `nostalgic-ie.fhir.core` | B. Author-scoped id (e.g. `<author>.fhir.ie.core`) | C. `ie.fhir.core` | D. Keep `hl7.fhir.ie.core`, guide only |
|---|---|---|---|---|
| Allowed | yes | yes | yes | no registry package |
| Can be mistaken for official | no | no | yes: looks national | yes |
| Blocks a future official Irish package | no | no | could pre-empt `ie.*` | no |
| Personal name in every dependency | no | yes | no | no |
| Installable as a dependency | yes | yes | yes | no |

## Decision

**A.** Package id `nostalgic-ie.fhir.core` (R5 track: `nostalgic-ie.fhir.core.r5`), from the project code name **nostalgic-ie**.

**Release code names.** Like Ubuntu or kernel releases, each release also gets a name of the form
"*Adjective* IE". 0.2.0 is **Nostalgic IE**. Later releases take the next adjective alphabetically (O, P, …),
chosen when the release is prepared. The code name appears in the release notes, `changes.md`, the IG's
`releaseLabel` and the Simplifier release notes; the package id stays `nostalgic-ie.fhir.core` across releases. The canonical URL is
unchanged. Distribution: `scripts/simplifier/build_bundle.py` builds a Simplifier bundle from a fresh SUSHI run and
checks the id, dependencies and canonical. CI attaches it to every build. A manual-only workflow can push it to a
`simplifier-sync` branch for Simplifier's GitHub integration. Releasing a package stays a manual step in Simplifier,
first as a prerelease.

## Consequences

- If a governing body adopts IE Core, it publishes under an official id; this package then points to it.
- Simplifier guide rendering of the IG Publisher pages is untested (OI-029).
- `docs/`, the README and the registry-guidance page describe the new id.
