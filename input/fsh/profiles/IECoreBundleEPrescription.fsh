// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core ePrescription Bundle, allergy statement and signature      │
// │  ADR-003. HIQA EP Sections 1.4.2, 1.6, 2.10, 2.13, 3.1.             │
// ╰──────────────────────────────────────────────────────────────────────╯

Profile: IECoreBundleEPrescription
Parent: Bundle
Id: ie-core-bundle-eprescription
Title: "IE Core Bundle (ePrescription)"
Description: "An Irish electronic prescription as exchanged: one patient (IECorePatientEPrescription), one or more prescription items (IECoreMedicationRequestEPrescription) sharing a group identifier, the prescriber, the prescriber's facility, the medicinal products, and the allergy statement (IECoreListAllergiesAtPrescribing). Prescription-level legal and safety rules (HIQA EP 1.4.2, 1.6.1, 2.10.1, 3.1) are enforced here because they span resources."
* ^status = #draft
* identifier 1..1 MS
* identifier ^comment = "Bundle identifier; typically the NePS electronic prescription (group) identifier (HIQA EP 3.1)."
* type = #collection
* timestamp 1..1 MS
* entry 1..* MS
* entry.fullUrl 1..1
* entry.resource 1..1
* entry ^slicing.discriminator.type = #type
* entry ^slicing.discriminator.path = "resource"
* entry ^slicing.rules = #open
* entry contains
    patient 1..1 MS and
    prescriptionItem 1..* MS and
    allergyStatement 1..1 MS and
    allergy 0..* MS and
    practitioner 0..* MS and
    practitionerRole 0..* MS and
    organization 0..* MS and
    medication 0..* MS and
    signature 0..* MS
* entry[patient].resource only IECorePatientEPrescription
* entry[prescriptionItem].resource only IECoreMedicationRequestEPrescription
* entry[allergyStatement].resource only IECoreListAllergiesAtPrescribing
* entry[allergyStatement] ^comment = "HIQA EP 1.6.1 / 1.6.2: exactly one allergy statement per prescription, either listing the allergies or giving the reason none are recorded."
* entry[allergy].resource only IECoreAllergyIntolerance
* entry[practitioner].resource only IECorePractitioner
* entry[practitionerRole].resource only IECorePractitionerRole
* entry[organization].resource only IECoreOrganization
* entry[medication].resource only IECoreMedicationEPrescription
* entry[signature].resource only IECoreProvenanceEPrescriptionSignature
* obeys ie-bnd-rx-1 and ie-bnd-rx-2 and ie-bnd-rx-3 and ie-bnd-rx-4


Profile: IECoreBundleEPrescriptionCrossBorder
Parent: IECoreBundleEPrescription
Id: ie-core-bundle-eprescription-crossborder
Title: "IE Core Bundle (ePrescription, cross-border)"
Description: "An ePrescription issued in Ireland to be dispensed in another EU Member State, or issued in another Member State to be dispensed in Ireland. A sender (NePS or the National Contact Point for eHealth) marks a cross-border prescription by claiming this profile in Bundle.meta.profile. No invented tag is used (ADR-003). It adds the legal requirements HIQA cites for cross-border prescriptions: patient date of birth (EP 1.4.1), prescriber telephone and secure email (EP 2.10.1, 2.10.2), and an electronic signature (EP 2.13)."
* ^status = #draft
* entry[signature] 1..*
* entry[signature] ^comment = "HIQA EP 2.13 Signature: a legal requirement for a prescription issued in another EU Member State to be dispensed in Ireland. Required in both directions here for symmetry (see open issues)."
* obeys ie-bnd-xb-1 and ie-bnd-xb-2


Profile: IECoreListAllergiesAtPrescribing
Parent: List
Id: ie-core-list-allergies-at-prescribing
Title: "IE Core Allergy Statement at Prescribing"
Description: "The patient's allergy and intolerance statement sent with an ePrescription (HIQA EP 1.6.1 / 1.6.2). Either it lists the allergies (entry → IECoreAllergyIntolerance), or it states why none are recorded (emptyReason: e.g. nilknown = no known allergies, notasked, unavailable). A prescription cannot be sent without one, so a pharmacist can always tell 'no known allergies' from 'not asked' (clinical-safety hazard HZ-03)."
* ^status = #draft
* status = #current
* mode = #snapshot
* code 1..1 MS
* code = $LOINC#48765-2 "Allergies and adverse reactions Document"
* subject 1..1 MS
* subject only Reference(IECorePatientEPrescription)
* date 1..1 MS
* date ^comment = "When the allergy statement was confirmed."
* source MS
* source ^comment = "Who confirmed the allergy statement (HIQA EP 1.6.2.4.2 record entry author)."
* entry MS
* entry.item only Reference(IECoreAllergyIntolerance)
* entry ^comment = "HIQA EP 1.6.2 Allergies and intolerances (Required 0..*)."
* emptyReason MS
* emptyReason from http://hl7.org/fhir/ValueSet/list-empty-reason (extensible)
* emptyReason ^comment = "HIQA EP 1.6.1 Reason for not recording allergies and intolerances (Required 0..1; only when no allergies are recorded). nilknown = the patient has no known allergies."
* obeys ie-list-allergy-1


Profile: IECoreProvenanceEPrescriptionSignature
Parent: IECoreProvenance
Id: ie-core-provenance-eprescription-signature
Title: "IE Core Provenance (ePrescription signature)"
Description: "The prescriber's electronic signature over the prescription items (HIQA EP 2.13 Signature). A Provenance signature is used rather than Bundle.signature so that the signature survives storage in NePS and re-bundling for cross-border exchange (ADR-003). The signature format and eIDAS assurance level are Requires Clarification (OI-009)."
* ^status = #draft
* target 1..* MS
* target only Reference(IECoreMedicationRequestEPrescription)
* target ^comment = "Every prescription item covered by the signature. Use version-specific references where the server supports them."
* recorded 1..1 MS
* agent 1..1 MS
* agent.who 1..1 MS
* agent.who only Reference(IECorePractitionerRole or IECorePractitioner)
* agent.who ^comment = "The prescriber who signed (HIQA EP 2.13: the prescriber's legal name as written with an electronic or digital signature)."
* signature 1..* MS
* signature.type MS
* signature.when MS
* signature.who MS
* signature.who only Reference(IECorePractitionerRole or IECorePractitioner)
* signature.data MS
* signature.data ^comment = "The signature value. Format (e.g. JAdES) Requires Clarification (OI-009)."


// ╭──────────────────────────────────────────────────────────────────────╮
// │  Invariants                                                          │
// ╰──────────────────────────────────────────────────────────────────────╯

Invariant: ie-bnd-rx-1
Description: "A multi-item prescription SHALL share one group identifier across all its items (HIQA EP 3.1)"
Expression: "entry.resource.ofType(MedicationRequest).count() <= 1 or (entry.resource.ofType(MedicationRequest).all(groupIdentifier.exists()) and entry.resource.ofType(MedicationRequest).groupIdentifier.value.distinct().count() = 1)"
Severity: #error

Invariant: ie-bnd-rx-2
Description: "Every prescription item SHALL reference the allergy statement in supportingInformation (HIQA EP 1.6.1 / 1.6.2)"
Expression: "entry.resource.ofType(MedicationRequest).all(supportingInformation.where(resolve() is List).exists())"
Severity: #error

Invariant: ie-bnd-rx-3
Description: "If the patient is under 12 years old at the date of prescribing, every prescription item SHALL record the patient's age (HIQA EP 1.4.2; a legal requirement)"
Expression: "entry.resource.ofType(MedicationRequest).all(extension('https://hl7-ie.github.io/ie-core/fhir/ie/core/StructureDefinition/ie-core-patient-age-at-prescribing').exists() or ((%resource.entry.resource.ofType(Patient).first().birthDate + 12 years).toString() <= authoredOn.toString().substring(0,10)))"
Severity: #error

Invariant: ie-bnd-rx-4
Description: "The prescriber or the prescriber's facility SHALL have a telephone number (HIQA EP 2.10 / 2.10.1, Mandatory)"
Expression: "entry.resource.where((($this is Practitioner) or ($this is PractitionerRole) or ($this is Organization)) and telecom.where(system = 'phone').exists()).exists()"
Severity: #error

Invariant: ie-bnd-xb-1
Description: "A cross-border prescription SHALL give a secure contact email for the prescriber or facility (HIQA EP 2.10.2; a legal requirement cross-border)"
Expression: "entry.resource.where((($this is Practitioner) or ($this is PractitionerRole) or ($this is Organization)) and telecom.where(system = 'email').exists()).exists()"
Severity: #error

Invariant: ie-bnd-xb-2
Description: "A cross-border prescription SHALL carry a prescriber signature covering every prescription item, referenced by fullUrl or by relative reference (HIQA EP 2.13; a legal requirement)"
Expression: "entry.where(resource is MedicationRequest).all((fullUrl in %resource.entry.resource.ofType(Provenance).where(signature.exists()).target.reference) or (('MedicationRequest/' + resource.id) in %resource.entry.resource.ofType(Provenance).where(signature.exists()).target.reference))"
Severity: #error

Invariant: ie-list-allergy-1
Description: "The allergy statement SHALL either list allergies or give the reason none are recorded (HIQA EP 1.6.1 / 1.6.2)"
Expression: "entry.exists() or emptyReason.exists()"
Severity: #error
