<div class="note-to-balloters" markdown="1">

**Not yet published.** This page describes how to publish IE Core on [Simplifier.net](https://simplifier.net). The
steps that create an account, upload content or release a package are done by the IG's author in Simplifier. A
released package version can never be deleted, only unlisted.

</div>

### What gets published

| Item | Value |
|---|---|
| Package id | `nostalgic-ie.fhir.core` (ADR-008: the FHIR package specification reserves `hl7.*` for HL7) |
| Release name | Nostalgic IE (0.2.0); later releases "*Adjective* IE", alphabetically |
| Version | from `sushi-config.yaml` (currently `0.2.0`, draft) |
| FHIR version | 4.0.1 |
| Canonical | `https://hl7-ie.github.io/ie-core/fhir/ie/core` (unchanged) |
| Content | conformance resources (profiles, extensions, logical models, ValueSets, CodeSystems, NamingSystems, SearchParameters, CapabilityStatements) and every example |
| Dependencies | listed in the bundle's `package.json`, taken from `sushi-config.yaml` (HL7 Europe Base, MPD, EPS, HDR, Laboratory, Imaging, Health Data API, Extensions R4; IPS 2.0.0; IHE MPD; SMART App Launch 2.2.0; FHIR Extensions R4) |
{:.grid}

The HL7 IG Publisher site stays on GitHub Pages. Simplifier hosts the package and, optionally, a Simplifier guide built
from the same Markdown pages.

### The bundle

SUSHI output is not committed, so every route starts from the **Simplifier bundle**, built from a fresh SUSHI run:

```
sushi .
python scripts/simplifier/build_bundle.py      # -> build/simplifier-upload.zip
```

Every CI build of `main` also attaches it as the `simplifier-bundle` artifact. The script fails if the package id
starts with `hl7.`, if a dependency in `sushi-config.yaml` is missing from `package.json`, if two resources share
an id, or if a conformance resource sits outside the canonical.

| Folder | Content |
|---|---|
| `resources/conformance/` | the package content |
| `resources/examples/` | example instances (the eight HIQA scenarios and the other examples) |
| `pages/` | the IG pages (Markdown) and images, for a Simplifier guide |
| `package.json` | the manifest; its dependencies are what the Simplifier package must declare |
{:.grid}

### Route A: upload (any Simplifier plan)

1. Create a Simplifier.net account and a **public** project for IE Core.
2. Upload the files from `resources/conformance/` and `resources/examples/` to the project.
3. In the project's **Dependencies**, add every package listed in the bundle's `package.json`, at the same versions.
4. Run Simplifier's quality control on the project, and fix anything it reports before releasing.
5. **Releases → Create → Create new package**: name `nostalgic-ie.fhir.core`, version as in `sushi-config.yaml`,
   a description and release notes (take them from `docs/release-notes-0.2.0.md`, including the code name "Nostalgic IE").
6. Mark the first release as a **prerelease**, as Simplifier's package policy recommends for a version meant for
   feedback. Check the package's Files and Dependencies tabs before releasing a final version.

### Route B: GitHub integration (Simplifier Team plan or higher)

Simplifier's GitHub integration imports JSON, XML, images and Markdown from a linked branch; it does not run SUSHI.

1. Run the **Simplifier sync branch** workflow (Actions tab → *Simplifier sync branch* → *Run workflow* on `main`,
   confirm with `sync`). It builds the bundle and force-pushes it to the `simplifier-sync` branch. It never
   publishes to Simplifier.
2. In the Simplifier project, **GitHub → Link repository** and choose the `simplifier-sync` branch.
3. Continue with steps 3–6 of Route A. After later releases, run the workflow again; Simplifier imports the change.

### A Simplifier guide (optional)

Simplifier guides are written in Simplifier's IG editor from Markdown pages. The pages in `pages/` are the IG's
own pages. They use features of the HL7 IG Publisher (Liquid includes, `{:.grid}` table classes, links to generated
artefact pages such as `StructureDefinition-…html`, Mermaid diagrams) that may not render the same way in a
Simplifier guide. This has **not been tested** (OI-029); link to the GitHub Pages site for the full IG.

### Before the first release

- [ ] CI is green on `main`, including the IG Publisher QA.
- [ ] The package id is `nostalgic-ie.fhir.core`.
- [ ] The project's dependencies match `package.json`.
- [ ] The release is marked prerelease.
- [ ] The release notes say it is a proof of concept, not endorsed by HIQA, the HSE or HL7 Ireland, and not for clinical use.

Sources: [FHIR package naming](https://hl7.org/fhir/packages.html) ·
[Simplifier packages](https://github.com/FirelyTeam/firely-docs-simplifier/blob/main/package_releases/simplifierPackages.rst) ·
[Simplifier package policy](https://github.com/FirelyTeam/firely-docs-simplifier/blob/main/package_releases/simplifierPackageCreationCheck.rst) ·
[Simplifier GitHub integration](https://github.com/FirelyTeam/firely-docs-simplifier/blob/main/adding_content/github.rst)
