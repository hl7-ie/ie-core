"""Terminology audit: every binding in IE Core profiles/extensions, and every IE Core ValueSet /
CodeSystem with its usage (orphans flagged). Run `sushi .` first.

Writes docs/hiqa-2026/terminology-audit.csv (bindings) and prints orphan value sets / code systems.
Columns: profile, element, valueset, strength, source_authority, verified
"""
import csv
import glob
import json
import os
import re

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..'))
IE = 'https://hl7-ie.github.io/ie-core/fhir/ie/core/'
PLACEHOLDER = {'ie-core-pcrs-scheme-type', 'ie-core-mda-schedule', 'ie-core-supply-legal-status', 'ie-core-nmpc-placeholder'}


def authority(url):
    u = url.split('|')[0]
    if u.startswith(IE):
        return 'IE Core'
    if u.startswith('http://hl7.org/fhir/ValueSet/'):
        return 'HL7 FHIR core'
    if u.startswith('http://terminology.hl7.org/'):
        return 'HL7 Terminology (THO)'
    if u.startswith('http://hl7.eu/') or 'ehdsi' in u:
        return 'HL7 Europe / eHDSI'
    if 'ihe.net' in u:
        return 'IHE'
    return 'other'


def main():
    res = os.path.join(ROOT, 'fsh-generated', 'resources')
    vs_defs, cs_defs = {}, {}
    for f in glob.glob(os.path.join(res, 'ValueSet-*.json')):
        d = json.load(open(f, encoding='utf-8'))
        vs_defs[d['url']] = d
    for f in glob.glob(os.path.join(res, 'CodeSystem-*.json')):
        d = json.load(open(f, encoding='utf-8'))
        cs_defs[d['url']] = d
    verified = {r['code'] for r in csv.DictReader(open(os.path.join(ROOT, 'docs', 'hiqa-2026', 'terminology-verification.csv'), encoding='utf-8')) if r['found_on_tx'] == 'yes'}

    def verified_status(vs_url):
        u = vs_url.split('|')[0]
        if not u.startswith(IE):
            return 'external (published by the owner)'
        d = vs_defs.get(u)
        if not d:
            return 'NOT FOUND'
        notes = []
        for inc in d.get('compose', {}).get('include', []):
            sysu = inc.get('system', '')
            if any(p in sysu for p in PLACEHOLDER):
                notes.append('placeholder CS (Requires Clarification)')
            elif sysu.startswith(IE):
                notes.append('IE Core CS')
            elif inc.get('filter'):
                notes.append('intensional' + (' (IE edition; HSE CTS)' if inc.get('version') else ''))
            elif inc.get('concept'):
                codes = [c['code'] for c in inc['concept']]
                ok = all(c in verified for c in codes)
                notes.append(f'{len(codes)} codes ' + ('verified on tx.fhir.org' if ok else 'NOT all verified'))
            elif sysu:
                notes.append('whole code system')
        return '; '.join(sorted(set(notes))) or 'empty'

    rows, used_vs = [], set()
    for f in sorted(glob.glob(os.path.join(res, 'StructureDefinition-*.json'))):
        sd = json.load(open(f, encoding='utf-8'))
        for e in sd.get('differential', {}).get('element', []):
            b = e.get('binding')
            if b and b.get('valueSet'):
                used_vs.add(b['valueSet'].split('|')[0])
                rows.append([sd['name'], e['id'], b['valueSet'], b.get('strength', ''), authority(b['valueSet']), verified_status(b['valueSet'])])
    # value sets referenced from other value sets / used via include valueSet
    for d in vs_defs.values():
        for inc in d.get('compose', {}).get('include', []):
            for v in inc.get('valueSet', []):
                used_vs.add(v.split('|')[0])
    out = os.path.join(ROOT, 'docs', 'hiqa-2026', 'terminology-audit.csv')
    with open(out, 'w', newline='', encoding='utf-8') as fh:
        w = csv.writer(fh, lineterminator='\n')
        w.writerow(['profile', 'element', 'valueset', 'strength', 'source_authority', 'verified'])
        w.writerows(rows)
    used_cs = {inc.get('system') for d in vs_defs.values() for inc in d.get('compose', {}).get('include', [])}
    orphan_vs = sorted(u.split('/')[-1] for u in vs_defs if u not in used_vs)
    orphan_cs = sorted(u.split('/')[-1] for u in cs_defs if u not in used_cs)
    print(f'{len(rows)} bindings; {len(vs_defs)} IE ValueSets; {len(cs_defs)} IE CodeSystems')
    print('orphan ValueSets (not bound, not included):', orphan_vs)
    print('orphan CodeSystems (not in any IE ValueSet):', orphan_cs)
    from collections import Counter
    print('bindings by strength:', Counter(r[3] for r in rows))
    print('bindings by authority:', Counter(r[4] for r in rows))


if __name__ == '__main__':
    main()
