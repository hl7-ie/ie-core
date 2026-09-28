// ╭──────────────────────────────────────────────────────────────────────╮
// │  IE Core Medication Scenario Examples                               │
// │  Covers: Local IE dispensing (full/partial/repeat/multiple Rx),     │
// │  Cross-border IE→ES, Cross-border ES→IE (MyHealth@EU / EHDS)        │
// ╰──────────────────────────────────────────────────────────────────────╯


// ====================================================================
// SUPPORTING RESOURCES – MEDICATIONS
// ====================================================================

Instance: ie-core-medication-metformin-500
InstanceOf: IECoreMedication
Usage: #example
Title: "Medication – Metformin 500mg Tablets"
Description: "Metformin hydrochloride 500mg film-coated tablets (generic), coded with the NMPC VMP (SNOMED CT Irish Edition) as the primary code and the International SNOMED CT substance as a secondary code."

* code = $SCT#718271000220105 "Metformin hydrochloride 500 mg oral tablet"
* code.coding[0].version = "http://snomed.info/sct/1601000220105"
* code.coding[+] = $SCT#372567009 "Metformin"
* code.text = "Metformin 500mg tablets"
* form = $SCT#385055001 "Tablet"
* amount.numerator = 60 '{tablet}' "tablets"
* amount.denominator = 1 '{pack}' "pack"
* ingredient[0].itemCodeableConcept = $SCT#372567009 "Metformin"
* ingredient[=].isActive = true
* ingredient[=].strength.numerator = 500 'mg' "mg"
* ingredient[=].strength.denominator = 1 '{tablet}' "tablet"


Instance: ie-core-medication-atorvastatin-20
InstanceOf: IECoreMedication
Usage: #example
Title: "Medication – Atorvastatin 20mg Tablets"
Description: "Atorvastatin 20mg film-coated tablets (generic), coded with the NMPC VMP (SNOMED CT Irish Edition) as the primary code and the International SNOMED CT substance as a secondary code."

* code = $SCT#254311000220102 "Atorvastatin 20 mg oral tablet"
* code.coding[0].version = "http://snomed.info/sct/1601000220105"
* code.coding[+] = $SCT#373444002 "Atorvastatin"
* code.text = "Atorvastatin 20mg tablets"
* form = $SCT#385055001 "Tablet"
* amount.numerator = 30 '{tablet}' "tablets"
* amount.denominator = 1 '{pack}' "pack"
* ingredient[0].itemCodeableConcept = $SCT#373444002 "Atorvastatin"
* ingredient[=].isActive = true
* ingredient[=].strength.numerator = 20 'mg' "mg"
* ingredient[=].strength.denominator = 1 '{tablet}' "tablet"


Instance: ie-core-medication-ramipril-5
InstanceOf: IECoreMedication
Usage: #example
Title: "Medication – Ramipril 5mg Capsules"
Description: "Ramipril 5mg capsules (generic), coded with the NMPC VMP (SNOMED CT Irish Edition) as the primary code and the International SNOMED CT substance as a secondary code."

* code = $SCT#716371000220101 "Ramipril 5 mg oral capsule"
* code.coding[0].version = "http://snomed.info/sct/1601000220105"
* code.coding[+] = $SCT#386872004 "Ramipril"
* code.text = "Ramipril 5mg capsules"
* form = $SCT#385049006 "Capsule"
* amount.numerator = 28 '{capsule}' "capsules"
* amount.denominator = 1 '{pack}' "pack"
* ingredient[0].itemCodeableConcept = $SCT#386872004 "Ramipril"
* ingredient[=].isActive = true
* ingredient[=].strength.numerator = 5 'mg' "mg"
* ingredient[=].strength.denominator = 1 '{capsule}' "capsule"


Instance: ie-core-medication-amlodipine-5
InstanceOf: IECoreMedication
Usage: #example
Title: "Medication – Amlodipine 5mg Tablets"
Description: "Amlodipine 5mg tablets (generic), coded with the NMPC VMP (SNOMED CT Irish Edition) as the primary code and the International SNOMED CT substance as a secondary code. Used in cross-border dispensing scenario."

* code = $SCT#267451000220105 "Amlodipine 5 mg oral tablet"
* code.coding[0].version = "http://snomed.info/sct/1601000220105"
* code.coding[+] = $SCT#386864001 "Amlodipine"
* code.text = "Amlodipine 5mg tablets"
* form = $SCT#385055001 "Tablet"
* amount.numerator = 30 '{tablet}' "tablets"
* amount.denominator = 1 '{pack}' "pack"
* ingredient[0].itemCodeableConcept = $SCT#386864001 "Amlodipine"
* ingredient[=].isActive = true
* ingredient[=].strength.numerator = 5 'mg' "mg"
* ingredient[=].strength.denominator = 1 '{tablet}' "tablet"
