# Consultation feedback: HIQA draft national standards (September 2026)

**Submission type:** individual submission
**From:** Nithin Mohan, as an individual health-informatics practitioner
**On:** *Draft National Standard for Electronic Prescriptions and Electronic Dispensations* (EP) and
*Draft National Standard for a Patient Summary* (PS)
**Consultation closes:** 21 October 2026

This feedback comes from building a proof-of-concept HL7 FHIR implementation guide (IE Core) against both drafts.
It is not made on behalf of any organisation. IE Core is not affiliated with HIQA, the HSE or the Department of
Health. Element references use the drafts' numbering (EP x.y, PS x.y).

---

## Summary

The two drafts are clear, well structured and close to the European standards Ireland will need to meet under the
European Health Data Space. Almost every data element could be represented in FHIR using the HL7 Europe
ePrescription (MPD) and Patient Summary (EPS) specifications with a small Irish layer on top.

My main suggestions:

1. **Publish the coded values** (value sets and code systems) and the **identifier systems**, or say who will. Without
   them, two compliant systems can still fail to understand each other (see G-1, G-2).
2. **Fix a small number of conformance anomalies** where the conformance level and cardinality contradict each other
   (see G-3).
3. **State the controlled-drug rules as testable rules**, especially for instalment prescriptions (see EP-3).
4. **Keep the ePrescription dataset minimal.** I support leaving ethnicity, nationality and the mother's former
   surnames out of the ePrescription dataset. Please say so explicitly, so implementers do not add them "for
   completeness" (see G-4).

---

## General comments

### G-1. Coded values

Both drafts say coded values have not yet been specified. Many elements are coded (statuses, reasons, routes, dose
forms, schedules, empty-section reasons). Please:

- name the code system for each coded element, preferring international ones (SNOMED CT Irish Edition, EDQM Standard
  Terms, UCUM, LOINC, WHO ATC) and those used by MyHealth@EU;
- say who will publish and maintain the Irish value sets (for example, the MDA schedule and supply legal status in
  EP 4.2.2 and 4.2.3), and where.

**Why it matters:** the controlled-drug safeguards depend on knowing a medicine's schedule. Until the schedule is
coded, software cannot check them reliably.

### G-2. Identifiers

The drafts name the identifiers well (IHI, PPSN, PCRS scheme numbers, Medical Council, PSI, NMBI and Dental Council
registration numbers, PSI Retail Pharmacy Business number, GMS Panel ID, GLN, NePS prescription identifier).
Please also:

- say which body will publish a stable identifier "system" (a URI or OID) for each one, so all systems label them
  the same way;
- clarify the relationship between the 18-digit and 10-digit IHI forms (EP/PS 1.3.1), and whether either has a check
  digit;
- clarify the legal basis and limits for recording the PPSN in health records (EP/PS 1.3.2), given the statutory
  restrictions on its use.

### G-3. Conformance anomalies

A few elements combine a conformance level with a cardinality that contradicts it:

- "Mandatory" with a minimum of 0: EP 1.6.x record-entry author and date; PS 13.3.2; PS 15.2.1; PS 19.1.12.x.
- "Required" with 1..1: PS 16.2.
- PS 6.3 (medication record entry) is 0..1, which would allow only one medication in a Patient Summary. I assume
  0..* was intended.
- Numbering: PS 4.4.6 appears to belong under 4.3; PS 6.3.11.1 has no 6.3.11 parent; the examples table uses numbers
  that differ from the dataset (for example validity period).

Where an element is Mandatory only *within* an optional group (for example the lines of an address group), it would
help to say so explicitly.

### G-4. Data minimisation

I support the separate patient datasets for the two standards. The ePrescription dataset omits ethnicity,
nationality, the mother's former surnames and similar data, and a pharmacist does not need them to dispense safely.
Please state explicitly that data outside the EP dataset **should not** be sent with an ePrescription. Without that
statement, systems may send it because the patient summary holds it.

For the Patient Summary, please say which classification should be used for ethnicity (PS 1.4.10). The CSO Data
Standard for Ethnicity v1.0 (February 2025) seems the natural choice.

### G-5. Alignment with European specifications

Aligning with the HL7 Europe ePrescription (MPD) and Patient Summary (EPS) specifications worked well. Three points
would reduce the Irish-specific layer:

- PS 16.3.3 and 16.3.5 separate the vaccine product from the vaccine code; the European model has one code. Please
  say which is primary.
- PS 2.5 makes a practitioner participant Mandatory, whereas the European Patient Summary does not require one.
- EP 3.3 (prescription status) can be derived from the item statuses (EP 3.5.2). Saying so would avoid two sources of
  truth.

---

## ePrescription and eDispensation (EP)

| Ref | Comment | Suggestion |
|---|---|---|
| EP-1 (1.4.2) | The age of a child under 12 is a legal requirement. Software can only check the rule if the date of birth is a full date. | Say that the age must be recorded when the patient is under 12 **or** the date of birth is incomplete. |
| EP-2 (1.6.1, 1.6.2) | Requiring an allergy statement on every prescription is a strong safety measure, and "no known allergies" is clearly different from "not asked". | Say that the statement must be the patient's own, and whether the dispenser should re-confirm allergies at dispensing. |
| EP-3 (3.5.7.2, 3.5.9.1, 3.5.12, 3.5.13) | The controlled-drug rules are spread across guidance text. The 14-day validity and the instalment rule (first dispensation within 14 days, final within two months) interact. It is also unclear whether the number of instalments is needed on every Schedule 2, 3 and 4 Part 1 prescription or only on instalment prescriptions. | State them as rules, per schedule: which elements are required, the validity for single-supply and instalment prescriptions, and which checks are made at dispensing. |
| EP-4 (3.5.7.2) | The words-and-figures quantity is described as required for any controlled drug. | Confirm whether this applies to every schedule, including Schedule 5. |
| EP-5 (2.6) | The prescriber's registration number is Mandatory, but the right register depends on the prescriber (doctor, nurse or midwife prescriber, dentist). | List the register for each prescriber type. |
| EP-6 (2.13) | The signature is described as "electronic or digital". | Specify the format, the eIDAS assurance level and who verifies it (the national service or the National Contact Point), and whether it is also required for prescriptions leaving Ireland. |
| EP-7 (4.11) | "Exempt medication item": it is not clear what the item is exempt from. | Define it, or give an example. |
| EP-8 (6.7) | The dispensed quantity is Mandatory. For a non-dispensation nothing is supplied. | Confirm that a quantity of zero is expected for a non-dispensation, and require a reason (EP 6.3.2) whenever the status is "not dispensed". |
| EP-9 (1.2.6) | Address type (Mandatory) includes homelessness or no fixed abode. That is valuable, but international address standards have no code for it. | Give the code list for address type, including how to represent no fixed abode. |

## Patient Summary (PS)

| Ref | Comment | Suggestion |
|---|---|---|
| PS-1 (empty reasons: 4.2, 5.2, 6.2, 7.2, 9.2, 10.2, 13.2, 16.2) | Requiring a reason when a section is empty is excellent for safety. | Publish the allowed reasons (for example nil known, not asked, unavailable, withheld) and apply them consistently to every section that has one. |
| PS-2 (6.3.9) | The dose is Mandatory, but many records only hold "as directed" or free-text instructions. | Allow the free-text instruction to satisfy the requirement, or make the structured dose Required. |
| PS-3 (1.4.6) | "Mother's former surnames" (plural). | Confirm whether the birth surname alone is intended. |
| PS-4 (13.3) | An advance healthcare directive under the 2015 Act is a written document. | Say that the document itself (the attachment) is authoritative. |
| PS-5 (15.3) | The number of foetuses and the end date of the pregnancy are Mandatory within the outcome. | Confirm this is intended for every outcome, including early loss. |
| PS-6 (19.1.2) | The document identifier must be stable. | Say whether a new version of a summary keeps the identifier or receives a new one. |

---

## Patient-safety points

To summarise the points above that affect safety most:

- Tie the allergy statement to the patient on the prescription (EP-2).
- Make the controlled-drug rules testable (EP-3, G-1).
- Require a reason for every non-dispensation (EP-8).
- Keep "nil known" and "not asked" distinct everywhere (EP-2, PS-1).
- Require the age when the date of birth is incomplete (EP-1).

Thank you for the opportunity to comment. A working FHIR representation of both drafts, with a line-by-line
traceability table, is available if it would help the review.
