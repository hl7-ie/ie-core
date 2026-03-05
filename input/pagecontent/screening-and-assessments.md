### Screening and Assessments Guidance

IE Core supports the recording and exchange of screening and assessment data through the [IE Core Observation Screening Assessment](StructureDefinition-ie-core-observation-screening-assessment.html) profile.

### Use Cases

Common screening and assessment scenarios in Irish healthcare include:

- **Social Determinants of Health (SDOH)**: Housing, food security, employment status
- **Mental Health Screening**: PHQ-9 (depression), GAD-7 (anxiety), AUDIT-C (alcohol)
- **Falls Risk Assessment**: Elderly care falls risk screening
- **Nutrition Screening**: Malnutrition Universal Screening Tool (MUST)
- **Developmental Screening**: Ages and Stages Questionnaires (ASQ) for children

### Structure

Screening assessments are represented using a panel structure:

1. **Panel Observation**: The top-level observation representing the complete screening tool
   - `category`: `survey` (and optionally `sdoh` for social determinants)
   - `code`: LOINC code for the screening instrument
   - `hasMember`: References to individual question observations

2. **Question Observations**: Individual responses to screening questions
   - `derivedFrom`: Reference to the QuestionnaireResponse
   - `value[x]`: The coded or numeric response

### Linking to QuestionnaireResponse

When screening data originates from a questionnaire:

1. Record the complete questionnaire response using [IE Core QuestionnaireResponse](StructureDefinition-ie-core-questionnaireresponse.html)
2. Extract relevant observations and store them as Observation resources
3. Link the observations back to the QuestionnaireResponse using `Observation.derivedFrom`

### Conditions from Screening

When a screening assessment identifies a health concern:

- Create a [Condition](StructureDefinition-ie-core-condition-problems-health-concerns.html) with category `health-concern`
- Link the condition to the screening observation using `Condition.evidence.detail`
