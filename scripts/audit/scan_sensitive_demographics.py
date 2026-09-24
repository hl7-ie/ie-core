"""Scan the IG sources for sensitive / special-category demographic elements.

Writes docs/audit/sensitive-demographics-usage.csv (file, line, element, context).
Used by the Phase 1 baseline audit (HIQA 2026 alignment) and re-runnable in CI.
"""
import csv
import os
import re
import sys
from collections import Counter

SKIP_DIRS = {'.git', 'node_modules', 'fsh-generated', 'output', 'temp', 'template',
             'input-cache', 'sources', 'audit', '.claude'}
EXTS = ('.fsh', '.json', '.xml', '.md', '.feature', '.js', '.mjs', '.yml', '.yaml', '.html', '.ini', '.sh')
PATTERNS = [
    ('ethnicity', r'ethnic'),
    ('mothersMaidenName', r'maiden|mother.?s.?former|mothersMaiden'),
    ('nationality', r'nationality|citizenship'),
    ('religion', r'religio'),
    ('maritalStatus', r'marital'),
    ('genderIdentity', r'gender.?identity|genderIdentity'),
    ('pronouns', r'pronoun'),
    ('sexForClinicalUse/recordedSex', r'recordedSexOrGender|sexParameterForClinicalUse|birthsex|birthSex'),
]


def main(root='.', out='docs/audit/sensitive-demographics-usage.csv'):
    rows = []
    for dirpath, dirnames, filenames in os.walk(root):
        dirnames[:] = sorted(d for d in dirnames if d not in SKIP_DIRS)
        for name in sorted(filenames):
            if not name.endswith(EXTS):
                continue
            path = os.path.join(dirpath, name)
            rel = os.path.relpath(path, root).replace(os.sep, '/')
            with open(path, encoding='utf-8', errors='replace') as fh:
                for lineno, line in enumerate(fh, 1):
                    for element, pat in PATTERNS:
                        if not re.search(pat, line, re.I):
                            continue
                        # "family or marital name" is surname guidance, not marital status
                        if element == 'maritalStatus' and re.search(r'marital name', line, re.I):
                            continue
                        rows.append([rel, lineno, element, line.strip()[:200]])
    os.makedirs(os.path.dirname(out), exist_ok=True)
    with open(out, 'w', newline='', encoding='utf-8') as fh:
        writer = csv.writer(fh)
        writer.writerow(['file', 'line', 'element', 'context'])
        writer.writerows(rows)
    return rows


if __name__ == '__main__':
    rows = main(*sys.argv[1:])
    print(f'{len(rows)} occurrences')
    for (area, element), n in sorted(Counter(('/'.join(r[0].split('/')[:2]), r[2]) for r in rows).items()):
        print(f'{n:5}  {element:32} {area}')
