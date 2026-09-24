"""Verify every explicit SNOMED CT, LOINC and UCUM code used in the FSH sources against tx.fhir.org.

Scans input/fsh/**/*.fsh for $SCT#, $LOINC# and $UCUM# codes, looks each one up with $lookup
(SNOMED CT: International edition; codes from national extensions are reported as not found),
and writes docs/hiqa-2026/terminology-verification.csv:
    system, code, display_in_fsh, found, tx_display, inactive, files
Run: python scripts/terminology/verify_codes.py
"""
import csv
import glob
import json
import os
import re
import sys
import time
import urllib.parse
import urllib.request

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..'))
TX = 'https://tx.fhir.org/r4'
SYSTEMS = {'$SCT': 'http://snomed.info/sct', '$LOINC': 'http://loinc.org', '$UCUM': 'http://unitsofmeasure.org'}
PAT = re.compile(r'(\$SCT|\$LOINC|\$UCUM)#([A-Za-z0-9\-\.\[\]/%{}]+)(?:\s+"([^"]*)")?')


def lookup(system, code):
    url = f'{TX}/CodeSystem/$lookup?' + urllib.parse.urlencode({'system': system, 'code': code})
    req = urllib.request.Request(url, headers={'Accept': 'application/fhir+json'})
    for attempt in range(3):
        try:
            with urllib.request.urlopen(req, timeout=60) as r:
                d = json.load(r)
            break
        except urllib.error.HTTPError as e:
            try:
                d = json.load(e)
            except Exception:
                d = {'resourceType': 'OperationOutcome'}
            break
        except Exception:
            time.sleep(2 * (attempt + 1))
    else:
        return None, '', ''
    if d.get('resourceType') == 'OperationOutcome':
        return False, '', ''
    params = {p['name']: p for p in d.get('parameter', [])}
    display = params.get('display', {}).get('valueString', '')
    inactive = ''
    for p in d.get('parameter', []):
        if p['name'] == 'property':
            parts = {x['name']: x for x in p.get('part', [])}
            if parts.get('code', {}).get('valueCode') == 'inactive':
                inactive = str(parts.get('value', {}).get('valueBoolean', ''))
    if 'inactive' in params:
        inactive = str(params['inactive'].get('valueBoolean', ''))
    return True, display, inactive


SYSTEMS['$ATC'] = 'http://www.whocc.no/atc'
# Multi-line coding style:  * x.system = $SCT   /   * x.code = #123   /   * x.display = "..."
SYS_LINE = re.compile(r'^\*\s+(\S+)\.system\s*=\s*(\$SCT|\$LOINC|\$UCUM|\$ATC)\s*$')
CODE_LINE = re.compile(r'^\*\s+(\S+)\.code\s*=\s*#([A-Za-z0-9\-\.]+)')
DISP_LINE = re.compile(r'^\*\s+(\S+)\.display\s*=\s*"([^"]*)"')


def scan_multiline(text):
    pending = None
    for line in text.splitlines():
        m = SYS_LINE.match(line)
        if m:
            pending = [m.group(2), None, '']
            continue
        if pending and pending[1] is None:
            m = CODE_LINE.match(line)
            if m:
                pending[1] = m.group(2)
                continue
        if pending and pending[1]:
            m = DISP_LINE.match(line)
            if m:
                pending[2] = m.group(2)
            yield tuple(pending)
            pending = None
    if pending and pending[1]:
        yield tuple(pending)


def load_aliases():
    """All `Alias: $X = url` declarations in the FSH (global and file-local)."""
    aliases = {}
    for f in glob.glob(os.path.join(ROOT, 'input', 'fsh', '**', '*.fsh'), recursive=True):
        for m in re.finditer(r'^Alias:\s*(\$[\w\-]+)\s*=\s*(\S+)', open(f, encoding='utf-8').read(), re.M):
            aliases[m.group(1)] = m.group(2)
    return aliases


IE_CANONICAL = 'https://hl7-ie.github.io/ie-core/'
ANY_PAT = re.compile(r'(\$[\w\-]+|https?://[^\s#"]+)#([A-Za-z0-9\-\.\[\]/%{}_]+)(?:\s+"([^"]*)")?')


def main():
    aliases = load_aliases()
    for a, url in aliases.items():
        # external code systems only; IE Core's own code systems are validated by SUSHI/the Publisher,
        # and identifier-system aliases (sid/) are not code systems
        if not url.startswith(IE_CANONICAL) and not url.startswith('urn:') and '/StructureDefinition/' not in url \
                and '/ValueSet/' not in url and '/ImplementationGuide/' not in url:
            SYSTEMS.setdefault(a, url)
    found = {}
    for f in glob.glob(os.path.join(ROOT, 'input', 'fsh', '**', '*.fsh'), recursive=True):
        rel = os.path.relpath(f, ROOT).replace(os.sep, '/')
        text = open(f, encoding='utf-8').read()
        for m in ANY_PAT.finditer(text):  # full-URL codes (external systems only)
            if m.group(1).startswith('http') and not m.group(1).startswith(IE_CANONICAL):
                SYSTEMS.setdefault(m.group(1), m.group(1))
        hits = [(m.group(1), m.group(2), m.group(3) or '') for m in ANY_PAT.finditer(text) if m.group(1) in SYSTEMS]
        hits += list(scan_multiline(text))
        for alias, code, display in hits:
            if "{" in code:  # RuleSet template parameter, not a code
                continue
            key = (SYSTEMS[alias], code)
            entry = found.setdefault(key, {'display': display, 'files': set()})
            if display and not entry['display']:
                entry['display'] = display
            entry['files'].add(rel.split('/')[-1])
    rows = []
    for (system, code), e in sorted(found.items()):
        ok, disp, inactive = lookup(system, code)
        rows.append([system, code, e['display'], {True: 'yes', False: 'NO', None: 'error'}[ok], disp, inactive,
                     ';'.join(sorted(e['files']))])
    out = os.path.join(ROOT, 'docs', 'hiqa-2026', 'terminology-verification.csv')
    with open(out, 'w', newline='', encoding='utf-8') as fh:
        w = csv.writer(fh, lineterminator='\n')
        w.writerow(['system', 'code', 'display_in_fsh', 'found_on_tx', 'tx_display', 'inactive', 'files'])
        w.writerows(rows)
    bad = [r for r in rows if r[3] != 'yes' or r[5] == 'True']
    print(f'{len(rows)} codes checked; {len(bad)} not found, errored or inactive')
    for r in bad:
        print('  ' + ' | '.join(r[:6]) + ' | ' + r[6][:60])
    return 0


if __name__ == '__main__':
    sys.exit(main())
