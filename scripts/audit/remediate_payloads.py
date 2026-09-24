"""Remove invented URIs, OIDs and codes from the illustrative payloads (Phase 8, ADR-006/ADR-007).

Scope: input/examples/*.json, input/examples/*.xml (CDA), input/postman/*.postman_collection.json.
Rules (idempotent; run again after editing a payload):
  * http://hl7.hse.ie/fhir/ie/core ...  -> the IE Core canonical https://hl7-ie.github.io/ie-core/fhir/ie/core
    (hl7.hse.ie was never an IE Core namespace; see baseline C-01. The planned future domain is
    fhir.hl7.studio/ie, which is conceptual; payloads use the live canonical.) The legacy host stays in this
    script only as the pattern it removes.
  * Prescription identifiers (sid/pcrs-rx, sid/prescription-group) -> the NePS identifier (HIQA EP 3.1).
  * Dispense / document identifiers (sid/dispense-id, sid/ips-document-id) -> urn:ietf:rfc:3986 + urn:uuid
    (deterministic UUID derived from the old value).
  * sid/crn identifiers are removed (ADR-006: unsourced). sid/gms gets its PCRS scheme type.
  * Patients in ePrescription/eDispensation payloads claim ie-core-patient-eprescription (ADR-002).
  * Other countries' identifier systems (invented /fhir/sid/ paths under real authority domains)
    -> http://example.org/fhir/sid/<country>/<name>.
  * National product codings with invented codes in real-looking systems (HPRA, BASG, DKMA, ...) are
    removed; every such CodeableConcept keeps its SNOMED CT/ATC coding or text.
  * The invented Bundle tag ehealth.ec.europa.eu/fhir/tag#xt-ehr and the misused v3-ActCode#PBILLACCT
    tag are removed (ADR-003: cross-border is signalled by the Bundle profile).
  * JSON/CDA: unsourced sub-OIDs of 2.16.840.1.113883.2.16.1 and the misused DICOM / foreign OIDs move to the
    HL7 example OID arc 2.16.840.1.113883.19 (OI-020).
Run: python scripts/audit/remediate_payloads.py
"""
import glob
import json
import os
import re
import uuid

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..'))
IE = 'https://hl7-ie.github.io/ie-core/fhir/ie/core'
NEPS = IE + '/sid/neps'
PCRS_TYPE = {'coding': [{'system': IE + '/CodeSystem/ie-core-pcrs-scheme-type', 'code': 'medical-card',
                         'display': 'Medical card scheme number'}]}
FOREIGN_SID = re.compile(r'^https?://(?:www\.)?([a-z0-9.\-]+)/(?:fhir/sid|sid|NamingSystem)/(.+)$')
FOREIGN_HOSTS = ('kela.fi', 'mscbs.gob.es', 'infarmed.pt', 'zva.gov.lv', 'cnpv.be', 'lakemedelsverket.se', 'dkma.dk',
                 'basg.gv.at', 'gipdatabank.nl', 'ansm.sante.fr', 'nihdi.fgov.be', 'fhir.de')
NATIONAL_PRODUCT_SYSTEMS = ('hpra.ie/drug-catalogue', 'basg.gv.at', 'dkma.dk', 'lakemedelsverket.se', 'zva.gov.lv',
                            'infarmed.pt', 'idref.fr', 'gipdatabank.nl', 'cesec.org', 'fhir.de/CodeSystem/ifa/pzn')
BAD_TAGS = {('http://ehealth.ec.europa.eu/fhir/tag', 'xt-ehr'),
            ('http://terminology.hl7.org/CodeSystem/v3-ActCode', 'PBILLACCT')}
TEXT_MAP = [('http://hl7.hse.ie/fhir/ie/core', IE),
            (IE + '/sid/pcrs-rx', NEPS),
            (IE + '/sid/prescription-group', NEPS),
            ('urn:oid:2.16.840.1.113883.2.16.1', 'urn:oid:2.16.840.1.113883.19.1'),
            ('http://www.mscbs.gob.es/fhir/sid/cip', 'http://example.org/fhir/sid/es/cip')]
OID_MAP = [('2.16.840.1.113883.2.16.1', '2.16.840.1.113883.19.1'),
           ('1.2.840.10008.2.16.4', '2.16.840.1.113883.19.2.1'),
           ('1.2.276.0.76.4.291', '2.16.840.1.113883.19.3.1')]


def as_uuid(value):
    if str(value).startswith('urn:uuid:'):
        return value
    return 'urn:uuid:' + str(uuid.uuid5(uuid.NAMESPACE_URL, 'hl7-ie-core-payload/' + str(value)))


def fix_identifier(ident):
    """Return the fixed identifier, or None to drop it."""
    system = ident.get('system', '')
    if system.endswith('/sid/crn'):
        return None
    if system.endswith(('/sid/pcrs-rx', '/sid/prescription-group')):
        ident['system'] = NEPS
    elif system.endswith(('/sid/dispense-id', '/sid/ips-document-id')):
        ident['system'] = 'urn:ietf:rfc:3986'
        ident['value'] = as_uuid(ident.get('value', ''))
    elif system.endswith('/sid/gms') and 'type' not in ident:
        ident['type'] = PCRS_TYPE
    else:
        m = FOREIGN_SID.match(system)
        if m and m.group(1).endswith(FOREIGN_HOSTS):
            country = m.group(1).rsplit('.', 1)[-1]
            ident['system'] = f'http://example.org/fhir/sid/{country}/{m.group(2).strip("/").replace("/", "-")}'
    return ident


HSE = 'http://hl7.hse.ie/fhir/ie/core'


def walk(node, is_ep):
    if isinstance(node, str):
        return IE + node[len(HSE):] if node.startswith(HSE) else node
    if isinstance(node, dict):
        for k, v in list(node.items()):
            if k == 'profile' and isinstance(v, list):
                v = node[k] = walk(v, is_ep)
                if is_ep:
                    node[k] = [IE + '/StructureDefinition/ie-core-patient-eprescription'
                               if p == IE + '/StructureDefinition/ie-core-patient' else p for p in v]
                continue
            if k == 'tag' and isinstance(v, list):
                node[k] = [t for t in v if (t.get('system'), t.get('code')) not in BAD_TAGS]
                if not node[k]:
                    del node[k]
                    continue
            if k == 'coding' and isinstance(v, list):
                node[k] = [c for c in v if not any(s in c.get('system', '') for s in NATIONAL_PRODUCT_SYSTEMS)]
                if not node[k]:
                    del node[k]
                    continue
            if k == 'identifier' and isinstance(v, list):
                node[k] = [i for i in (fix_identifier(walk(x, is_ep)) for x in v) if i is not None]
                if not node[k]:
                    del node[k]
                continue
            if k in ('identifier', 'groupIdentifier') and isinstance(v, dict):
                node[k] = fix_identifier(walk(v, is_ep)) or {}
                continue
            node[k] = walk(node[k], is_ep)
    elif isinstance(node, list):
        return [walk(x, is_ep) for x in node]
    return node


def is_ep_payload(text):
    return '"MedicationRequest"' in text or '"MedicationDispense"' in text or '\\"MedicationRequest\\"' in text \
        or '\\"MedicationDispense\\"' in text


def fix_json_file(path):
    text = open(path, encoding='utf-8').read()
    data = json.loads(text)
    if 'item' in data and 'info' in data:  # Postman collection: fix each raw JSON body and the URLs
        def fix_items(items):
            for it in items:
                if 'item' in it:
                    fix_items(it['item'])
                body = it.get('request', {}).get('body', {})
                if body.get('mode') == 'raw' and body.get('raw', '').lstrip().startswith('{'):
                    try:
                        b = json.loads(body['raw'])
                    except ValueError:
                        continue
                    body['raw'] = json.dumps(walk(b, is_ep_payload(body['raw'])), ensure_ascii=False, indent=2)
        fix_items(data['item'])
        data = walk(data, False)
    else:
        data = walk(data, is_ep_payload(text))
    new = json.dumps(data, ensure_ascii=False, indent=2) + '\n'
    for a, b in TEXT_MAP:  # URIs embedded in strings (Postman scripts, queries, descriptions)
        new = new.replace(a, b)
    new = new.replace(IE + '/sid/dispense-id', 'urn:ietf:rfc:3986').replace(IE + '/sid/ips-document-id', 'urn:ietf:rfc:3986')
    new = re.sub(r'https?://(?:www\.)?([a-z0-9.\-]+)/fhir/sid/([A-Za-z0-9\-]+)',
                 lambda m: (f'http://example.org/fhir/sid/{m.group(1).rsplit(".", 1)[-1]}/{m.group(2)}'
                            if m.group(1).endswith(FOREIGN_HOSTS) else m.group(0)), new)
    if new != text:
        open(path, 'w', encoding='utf-8', newline='\n').write(new)
        return True
    return False


NOTE = ('<!-- Illustrative sample (IE Core). Identifier OIDs use the HL7 example arc 2.16.840.1.113883.19: '
        'no Irish OIDs are assigned for these identifiers (OI-020). -->\n')


def fix_cda(path):
    text = open(path, encoding='utf-8').read()
    new = text
    for old, rep in OID_MAP:
        new = re.sub(r'root="' + re.escape(old) + r'(\.[0-9.]+)?"', lambda m: f'root="{rep}{m.group(1) or ""}"', new)
    new = new.replace('http://hl7.hse.ie/fhir/ie/core', IE)
    if 'OI-020' not in new:
        new = re.sub(r'(<\?xml[^>]*\?>\s*\n)', lambda m: m.group(1) + NOTE, new, count=1)
    if new != text:
        open(path, 'w', encoding='utf-8', newline='\n').write(new)
        return True
    return False


def main():
    changed = []
    for p in sorted(glob.glob(os.path.join(ROOT, 'input', 'examples', '*.json')) +
                    glob.glob(os.path.join(ROOT, 'input', 'postman', '*.json'))):
        if fix_json_file(p):
            changed.append(p)
    for p in sorted(glob.glob(os.path.join(ROOT, 'input', 'examples', '*.xml'))):
        if fix_cda(p):
            changed.append(p)
    for p in changed:
        print('fixed', os.path.relpath(p, ROOT))
    print(f'{len(changed)} files changed')


if __name__ == '__main__':
    main()
