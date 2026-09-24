"""Classify the terminology-verification results and locate each problem code.

Reads docs/hiqa-2026/terminology-verification.csv (from verify_codes.py) and reports, per FSH
entity (ValueSet / Instance / Profile), the codes that are:
  NOT-FOUND  - not in the terminology on tx.fhir.org (SNOMED CT International, LOINC, UCUM)
  INACTIVE   - inactive concept
  WRONG      - display in the FSH has a different meaning from the official display
  COSMETIC   - wording differs but the meaning is the same (official display should be used)
WRONG vs COSMETIC is a human judgement recorded in COSMETIC_OK below (every other mismatch is
treated as WRONG, i.e. the safe default).
"""
import csv
import glob
import os
import re

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..'))

# Reviewed 2026-09-24: official display differs only in wording, not meaning.
COSMETIC_OK = {
    ('loinc', '11488-4'), ('loinc', '11535-2'), ('loinc', '30954-2'), ('loinc', '34133-9'), ('loinc', '42348-3'),
    ('loinc', '47039-3'), ('loinc', '57852-6'), ('loinc', '86645-9'), ('loinc', '96777-8'), ('loinc', '97023-6'),
    ('sct', '158965000'), ('sct', '38628009'), ('sct', '394743007'), ('sct', '409063005'), ('sct', '44054006'),
    ('sct', '446050000'), ('sct', '449868002'), ('sct', '62247001'), ('sct', '77386006'), ('sct', '82581004'),
    ('sct', '8517006'),
}


def norm(s):
    return re.sub(r'[^a-z0-9]', '', s.lower().replace('(disorder)', '').replace('(finding)', ''))


def classify(r):
    sysk = 'sct' if 'snomed' in r['system'] else ('loinc' if 'loinc' in r['system'] else 'ucum')
    if r['found_on_tx'] != 'yes':
        return 'NOT-FOUND'
    if r['inactive'] == 'True':
        return 'INACTIVE'
    a, b = norm(r['display_in_fsh']), norm(r['tx_display'])
    if r['display_in_fsh'] and a != b and not (a in b or b in a):
        return 'COSMETIC' if (sysk, r['code']) in COSMETIC_OK else 'WRONG'
    return 'OK'


def entities():
    """Map code -> list of (file, entity) where it appears."""
    where = {}
    for f in glob.glob(os.path.join(ROOT, 'input', 'fsh', '**', '*.fsh'), recursive=True):
        entity = None
        for line in open(f, encoding='utf-8'):
            m = re.match(r'^(ValueSet|Instance|Profile|CodeSystem|Extension|Logical):\s*(\S+)', line)
            if m:
                entity = f'{m.group(1)} {m.group(2)}'
            for c in re.findall(r'\$(?:SCT|LOINC|UCUM)#([A-Za-z0-9\-\.]+)', line):
                where.setdefault(c, set()).add((os.path.basename(f), entity))
    return where


def main():
    rows = list(csv.DictReader(open(os.path.join(ROOT, 'docs', 'hiqa-2026', 'terminology-verification.csv'), encoding='utf-8')))
    where = entities()
    out = []
    for r in rows:
        c = classify(r)
        r['classification'] = c
        if c not in ('OK',):
            for f, e in sorted(where.get(r['code'], [])):
                out.append((c, e, r['code'], r['display_in_fsh'], r['tx_display']))
    for c in ['WRONG', 'NOT-FOUND', 'INACTIVE', 'COSMETIC']:
        sel = [o for o in out if o[0] == c]
        print(f'\n== {c} ({len({o[2] for o in sel})} codes)')
        for o in sorted(sel, key=lambda o: o[1]):
            print(f'  {o[1]:58} {o[2]:18} FSH="{o[3]}"  TX="{o[4]}"')
    with open(os.path.join(ROOT, 'docs', 'hiqa-2026', 'terminology-verification.csv'), 'w', newline='', encoding='utf-8') as fh:
        w = csv.DictWriter(fh, fieldnames=list(rows[0].keys()), lineterminator='\n')
        w.writeheader()
        w.writerows(rows)


if __name__ == '__main__':
    main()
