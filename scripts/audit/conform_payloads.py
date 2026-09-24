"""Make the illustrative payloads in input/examples conform to the current IE Core profiles (Phase 9).

SUSHI adds input/examples/*.json to the IG, so the IG Publisher validates them. Run after
scripts/audit/remediate_payloads.py. Idempotent. No clinical content is invented: where a profile needs a
value the payload lacks, the rule below says where it comes from.
  * `_comment` (not FHIR) is removed.
  * fullUrls and references like `urn:uuid:patient-sean-murphy` (not UUIDs) become deterministic UUIDs.
  * Other countries' identifiers keep their value, drop the invented system and name the issuing country
    in `assigner.display` (the systems were invented; see remediate_payloads.py).
  * MedicationDispense gets the HL7 Europe MPD `recorded` extension (HIQA EP 6.2) = whenHandedOver,
    else whenPrepared, else the Bundle timestamp. A dispense that names its product only as a
    CodeableConcept gets a Medication entry with that same code (MPD requires a reference).
  * Patients in ePrescription payloads get sex assigned at birth = their administrative gender (the
    payloads record nothing else), and `address.state` = the city without a postal district number.
  * v3-ActCode `PF` (not a code) becomes FFP (first part fill) or RFP (later part fills).
  * 'Do Not Substitute' without a reason gets the reason text "Reason not stated in the source example".
  * IPS sections without narrative get a generated narrative from the section title.
  * Invented national product codes inside text/display (e.g. "(HPRA: IE-HPRA-ATV40)") are removed.
  * Medication.ingredient (1..*) is derived from the SNOMED CT substance code (product -> its verified
    substance); no strength is added.
  * An ePrescription patient address with no street line gets the data-absent-reason `unknown`; the one
    copy of Sean Murphy with no address gets his address from the other payloads.
Run: python scripts/audit/conform_payloads.py
"""
import glob
import json
import os
import re
import uuid

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..'))
IE = 'https://hl7-ie.github.io/ie-core/fhir/ie/core'
RECORDED = 'http://hl7.org/fhir/5.0/StructureDefinition/extension-MedicationDispense.recorded'
RECORDED_SEX = 'http://hl7.org/fhir/StructureDefinition/individual-recordedSexOrGender'
UUID_RE = re.compile(r'^urn:uuid:[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$')
COUNTRIES = {'at': 'Austria', 'be': 'Belgium', 'de': 'Germany', 'dk': 'Denmark', 'es': 'Spain', 'fi': 'Finland',
             'fr': 'France', 'lv': 'Latvia', 'nl': 'Netherlands', 'pt': 'Portugal', 'se': 'Sweden'}


def new_uuid(name):
    return 'urn:uuid:' + str(uuid.uuid5(uuid.NAMESPACE_URL, 'hl7-ie-core-payload-ref/' + name))


def collect_bad_uuids(node, out):
    if isinstance(node, dict):
        for v in node.values():
            collect_bad_uuids(v, out)
    elif isinstance(node, list):
        for v in node:
            collect_bad_uuids(v, out)
    elif isinstance(node, str) and node.startswith('urn:uuid:') and not UUID_RE.match(node):
        out[node] = new_uuid(node[len('urn:uuid:'):])


def replace_strings(node, mapping):
    if isinstance(node, dict):
        return {k: replace_strings(v, mapping) for k, v in node.items()}
    if isinstance(node, list):
        return [replace_strings(v, mapping) for v in node]
    if isinstance(node, str):
        return mapping.get(node, node)
    return node


INVENTED_CODE_TEXT = [re.compile(r'\s*\((?:HPRA|INFARMED|ZRA|BASG|PZN|CIP|DKMA/VNR)\b[^)]*\)'),
                      re.compile(r'\s*\(ZRA-\d+\)'),
                      re.compile(r'\s*→ IE: HPRA-\w+')]
# SNOMED CT product -> substance, for products whose ingredient must be derived (verified on tx.fhir.org)
PRODUCT_SUBSTANCE = {'317291008': ('387137007', 'Omeprazole')}
DAR = 'http://hl7.org/fhir/StructureDefinition/data-absent-reason'
# Seán Murphy's address as recorded in the other payloads of the same synthetic dataset
SEAN_ADDRESS = {'use': 'home', 'type': 'physical', 'line': ['14 Grafton Street'], 'city': 'Dublin 2',
                'state': 'Dublin', 'postalCode': 'D02 XY45', 'country': 'IE'}


def strip_invented_codes(node):
    if isinstance(node, dict):
        return {k: (strip_invented_codes(v) if k not in ('text', 'display') or not isinstance(v, str)
                    else _strip(v)) for k, v in node.items()}
    if isinstance(node, list):
        return [strip_invented_codes(v) for v in node]
    return node


def _strip(s):
    for rx in INVENTED_CODE_TEXT:
        s = rx.sub('', s)
    return s


def derive_ingredient(med):
    """Medication.ingredient (1..* in IE Core) from the SNOMED CT substance or product code: no strength."""
    if med.get('ingredient'):
        return
    for c in med.get('code', {}).get('coding', []):
        if c.get('system') != 'http://snomed.info/sct':
            continue
        code, display = PRODUCT_SUBSTANCE.get(c['code'], (c['code'], c.get('display')))
        med['ingredient'] = [{'itemCodeableConcept': {'coding': [
            {'system': 'http://snomed.info/sct', 'code': code, 'display': display}]}, 'isActive': True}]
        return


def fix_address(patient):
    if not patient.get('address'):
        if patient.get('id', '').startswith('patient-sean-murphy'):
            patient['address'] = [dict(SEAN_ADDRESS)]
        return
    for a in patient['address']:
        if not a.get('line'):
            # HIQA EP 1.2.2 is Mandatory; the source example has no street line, so say it is unknown
            a['line'] = [None]
            a['_line'] = [{'extension': [{'url': DAR, 'valueCode': 'unknown'}]}]


def fix_identifiers(res):
    for ident in res.get('identifier', []) if isinstance(res.get('identifier'), list) else []:
        m = re.match(r'^http://example\.org/fhir/sid/([a-z]{2})/', ident.get('system', ''))
        if m:
            del ident['system']
            ident.setdefault('assigner', {})['display'] = \
                f"Issuing authority in {COUNTRIES.get(m.group(1), m.group(1).upper())} (illustrative)"
        t = ident.get('type', {}).get('coding', [])
        for c in t:
            if c.get('system') == 'http://terminology.hl7.org/CodeSystem/v2-0203' and c.get('code') == 'NI':
                c['display'] = 'National unique individual identifier'


def main():
    changed = 0
    for path in sorted(glob.glob(os.path.join(ROOT, 'input', 'examples', '*.json'))):
        text = open(path, encoding='utf-8').read()
        bundle = json.loads(text)
        bundle.pop('_comment', None)
        bad = {}
        collect_bad_uuids(bundle, bad)
        bundle = replace_strings(bundle, bad)
        entries = bundle.get('entry', [])
        is_ep = any(e['resource']['resourceType'] in ('MedicationRequest', 'MedicationDispense') for e in entries)
        part_fills = 0
        new_entries = []
        for e in entries:
            r = e['resource']
            r.pop('_comment', None)
            fix_identifiers(r)
            rt = r['resourceType']
            if rt == 'MedicationDispense':
                when = r.get('whenHandedOver') or r.get('whenPrepared') or bundle.get('timestamp')
                exts = r.setdefault('extension', [])
                if when and not any(x.get('url') == RECORDED for x in exts):
                    exts.append({'url': RECORDED, 'valueDateTime': when})
                for c in r.get('type', {}).get('coding', []):
                    if c.get('system') == 'http://terminology.hl7.org/CodeSystem/v3-ActCode' and c.get('code') == 'PF':
                        c['code'], c['display'] = ('FFP', 'First Fill - Part Fill') if part_fills == 0 \
                            else ('RFP', 'Refill - Part Fill')
                        part_fills += 1
                if 'medicationCodeableConcept' in r:
                    cc = r.pop('medicationCodeableConcept')
                    med_id = f"med-{r.get('id', 'dispensed')}"
                    full = new_uuid(med_id)
                    new_entries.append({'fullUrl': full, 'resource': {
                        'resourceType': 'Medication', 'id': med_id,
                        'meta': {'profile': [f'{IE}/StructureDefinition/ie-core-medication-eprescription']},
                        'code': cc}})
                    r['medicationReference'] = {'reference': full, 'display': cc.get('text', '')}
            if rt == 'MedicationRequest':
                sub = r.get('substitution', {})
                if sub.get('allowedBoolean') is False and 'reason' not in sub:
                    sub['reason'] = {'text': 'Reason not stated in the source example'}
            if rt == 'Patient' and is_ep:
                exts = r.setdefault('extension', [])
                if r.get('gender') in ('male', 'female') and not any(x.get('url') == RECORDED_SEX for x in exts):
                    exts.append({'url': RECORDED_SEX, 'extension': [
                        {'url': 'value', 'valueCodeableConcept': {'coding': [{
                            'system': 'http://hl7.org/fhir/administrative-gender', 'code': r['gender'],
                            'display': r['gender'].capitalize()}]}},
                        {'url': 'type', 'valueCodeableConcept': {'coding': [{
                            'system': 'http://loinc.org', 'code': '76689-9', 'display': 'Sex assigned at birth'}]}}]})
                for a in r.get('address', []):
                    if 'state' not in a and a.get('city'):
                        a['state'] = re.sub(r'\s+\d+$', '', a['city'])
            if rt == 'Composition':
                for s in r.get('section', []):
                    if 'text' not in s:
                        s['text'] = {'status': 'generated',
                                     'div': f'<div xmlns="http://www.w3.org/1999/xhtml"><p>{s.get("title", "Section")}</p></div>'}
            if not r.get('extension'):
                r.pop('extension', None)
        entries.extend(new_entries)
        for e in entries:
            r = e['resource']
            if r['resourceType'] == 'Medication':
                derive_ingredient(r)
            if r['resourceType'] == 'Patient' and is_ep:
                fix_address(r)
        bundle = strip_invented_codes(bundle)
        new = json.dumps(bundle, ensure_ascii=False, indent=2) + '\n'
        if new != text:
            open(path, 'w', encoding='utf-8', newline='\n').write(new)
            changed += 1
            print('fixed', os.path.relpath(path, ROOT))
    print(f'{changed} files changed')


if __name__ == '__main__':
    main()
