"""Apply the reviewed terminology remediation (Phase 7, ADR-007).

Every decision below was reviewed against the official display returned by tx.fhir.org
(docs/hiqa-2026/terminology-verification.csv). Rule:
  FIX     - keep the code, correct the label to the official display (the code's real meaning
            still fits the value set / profile it is in)
  REMOVE  - delete the code (its real meaning does not fit, it does not exist in the
            International edition, or it is inactive)
  REPLACE - swap for a code verified on tx.fhir.org
Never guesses a code. Writes a log of every change to docs/hiqa-2026/terminology-remediation.csv.
"""
import csv
import glob
import os
import re

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..'))

FIX = {  # code -> official display (meaning still fits)
    # profile codes: the code is right for the profile, only the label was wrong
    '45473-6': 'Advance healthcare directive completed',
    '75773-2': 'Goals, preferences, and priorities for medical treatment Narrative - Reported',
    # value set members whose real meaning still belongs to the value set
    '81336-0': 'Patient Goals, preferences, and priorities under certain health conditions',
    '81340-2': 'Goals AndOr preferences in order of priority - Reported',
    '228277002': 'Light drinker', '228278007': 'Fairly heavy drinker',
    '21450003': 'Neuropsychiatrist', '224529009': 'Clinical assistant', '224570006': 'Clinical nurse specialist',
    '224587008': 'Occupational therapy helper', '307988006': 'Medical technician',
    '768819009': 'Medically responsible investigator',
    '225928004': 'Patient self-discharge against medical advice', '306705005': 'Discharge to police custody',
    '306706006': 'Discharge to ward', '371827001': 'Patient discharged alive',
    '394863008': 'Non-family member', '309898008': 'Psychogeriatric day hospital', '702871004': 'Infertility clinic',
    '275928001': 'Drugs - partial non-compliance', '735128000': 'Ex-smoker for less than 1 year',
    '62199-5': 'PROMIS short form - physical function 10a - version 1.0',
    '69725-0': 'Feeling nervous, anxious or on edge in last 2 weeks',
    '71354-5': 'Edinburgh Postnatal Depression Scale [EPDS]', '76504-0': 'Total score [HARK]',
    '89206-7': 'Patient Health Questionnaire-9: Modified for Teens [Reported.PHQ.Teen]',
    # cosmetic: same meaning, official wording
    '44054006': 'Type 2 diabetes mellitus', '42348-3': 'Advance healthcare directives',
    '11535-2': 'Hospital discharge diagnosis note', '30954-2': 'Relevant diagnostic tests/laboratory data note',
    '57852-6': 'Problem list Narrative - Reported', '86645-9': 'Pregnancy intention in the next year - Reported',
    '82581004': 'Ex-drinker', '158965000': 'Medical practitioner', '446050000': 'Primary care physician',
    '11488-4': 'Consult note', '34133-9': 'Summary of episode note',
    '47039-3': 'Hospital Admission history and physical note', '394743007': 'Gender unknown',
    '77386006': 'Pregnancy', '409063005': 'Counseling', '38628009': 'Gay', '449868002': 'Smokes tobacco daily',
    '8517006': 'Ex-smoker',
    '96777-8': 'Accountable health communities (AHC) health-related social needs screening (HRSN) tool',
    '97023-6': 'Accountable health communities (AHC) health-related social needs (HRSN) supplemental questions',
}
REMOVE = {  # code -> reason
    '59768-2': 'wrong meaning: Procedure indications narrative, not a procedure report',
    '59770-8': 'wrong meaning: Procedure estimated blood loss narrative, not a procedure reason report',
    '73770003': 'wrong meaning: a care location, not a discharge disposition',
    '75004002': 'wrong meaning: emergency room admission/death event, not a disposition',
    '182841002': 'wrong meaning: Doctor stopped drugs - ineffective (not adherence)',
    '182845006': 'wrong meaning: Doctor stopped drugs - avoid interaction (not adherence)',
    '182890002': 'wrong meaning: Patient requests alternative treatment (not adherence)',
    '275929009': 'wrong meaning: Tablets too large to swallow (a reason, not an adherence status)',
    '36629006': 'wrong meaning: Legally married (not a payer type)',
    '472986005': 'wrong meaning: sexual behaviour (Sexually active with men), not sexual orientation',
    '711338006': 'not found in SNOMED CT International', '407376009': 'not found in SNOMED CT International',
    '407377000': 'not found in SNOMED CT International', '310151008': 'not found (no such SNOMED CT concept)',
    '310152001': 'not found (no such SNOMED CT concept)', '394733004': 'not found (no such SNOMED CT concept)',
    '413195004': 'not found (no such SNOMED CT concept)', '454381000124105': 'US extension; not in the International edition',
    '454391000124108': 'US extension; not in the International edition', '454401000124105': 'US extension; not in the International edition',
    '428061000124105': 'US extension; not in the International edition', '428071000124103': 'US extension; not in the International edition',
    '428081000124100': 'US extension; not in the International edition',
    '160573003': 'inactive', '228274009': 'inactive and mislabelled (Lifetime non-drinker labelled Drinks alcohol daily)',
    '397709008': 'inactive', '264358009': 'inactive', '103693007': 'inactive', '160618006': 'inactive',
}
REPLACE = {  # old code -> (new code, official display, reason)
    '372718005': ('317291008', 'Omeprazole 20 mg oral capsule', 'wrong meaning: 372718005 is Imipramine; replaced with the verified product concept'),
}


def main():
    log = []
    for f in glob.glob(os.path.join(ROOT, 'input', 'fsh', '**', '*.fsh'), recursive=True):
        rel = os.path.relpath(f, ROOT).replace(os.sep, '/')
        lines = open(f, encoding='utf-8').read().replace('\r\n', '\n').split('\n')
        out, changed, i = [], False, 0
        while i < len(lines):
            line = lines[i]
            # single-line style: ... $SCT#code "display"
            m = re.search(r'(\$(?:SCT|LOINC)#)([A-Za-z0-9\-]+)(\s+"([^"]*)")?', line)
            if m and m.group(2) in REMOVE and line.lstrip().startswith('* $'):
                log.append((rel, m.group(2), 'REMOVE', m.group(4) or '', '', REMOVE[m.group(2)]))
                changed = True
                i += 1
                continue
            if m and m.group(2) in FIX and m.group(3):
                new = FIX[m.group(2)]
                if m.group(4) != new:
                    line = line[:m.start(3)] + f' "{new}"' + line[m.end(3):]
                    log.append((rel, m.group(2), 'FIX', m.group(4), new, 'official display'))
                    changed = True
            # multi-line style: * x.code = #code / * x.display = "..."
            mc = re.match(r'^(\*\s+\S+\.code\s*=\s*#)([A-Za-z0-9\-]+)\s*$', line)
            if mc and mc.group(2) in REPLACE:
                new_code, new_disp, reason = REPLACE[mc.group(2)]
                line = mc.group(1) + new_code
                log.append((rel, mc.group(2), 'REPLACE', '', f'{new_code} {new_disp}', reason))
                changed = True
                out.append(line)
                if i + 1 < len(lines) and re.match(r'^\*\s+\S+\.display\s*=', lines[i + 1]):
                    out.append(re.sub(r'"[^"]*"', f'"{new_disp}"', lines[i + 1]))
                    i += 2
                    continue
            if mc and mc.group(2) in FIX and i + 1 < len(lines):
                md = re.match(r'^(\*\s+\S+\.display\s*=\s*)"([^"]*)"', lines[i + 1])
                if md and md.group(2) != FIX[mc.group(2)]:
                    out.append(line)
                    out.append(f'{md.group(1)}"{FIX[mc.group(2)]}"')
                    log.append((rel, mc.group(2), 'FIX', md.group(2), FIX[mc.group(2)], 'official display'))
                    changed = True
                    i += 2
                    continue
            out.append(line)
            i += 1
        if changed:
            open(f, 'w', encoding='utf-8', newline='\n').write('\n'.join(out))
    path = os.path.join(ROOT, 'docs', 'hiqa-2026', 'terminology-remediation.csv')
    with open(path, 'w', newline='', encoding='utf-8') as fh:
        w = csv.writer(fh, lineterminator='\n')
        w.writerow(['file', 'code', 'action', 'old_display', 'new', 'reason'])
        w.writerows(sorted(log))
    from collections import Counter
    print(Counter(a for _, _, a, _, _, _ in log))
    missing = set(REMOVE) - {c for _, c, a, _, _, _ in log if a == 'REMOVE'}
    if missing:
        print('REMOVE codes not found as value-set lines (check by hand):', sorted(missing))


if __name__ == '__main__':
    main()
