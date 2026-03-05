### R5 Migration Notes

This page documents the differences between the R4 and R5 editions of IE Core
and provides guidance for implementers planning an R5 migration.

### Breaking Changes in FHIR R5

The following FHIR R5 changes affect IE Core profiles:

#### Patient Resource

- `Patient.link.other` changed to `Patient.link.target`
- Gender extensions consolidated under the core sex-and-gender model

#### Observation Resource

- `Observation.referenceRange.appliesTo` renamed to `Observation.referenceRange.normalValue`
- New `Observation.triggeredBy` element for chained observations

#### Subscription Model

- R4 `Subscription` resource is **replaced** by `Subscription` + `SubscriptionTopic`
- Channel types are now extensible via `SubscriptionTopic`

#### Medication Resources

- `MedicationRequest.substitution` model simplified
- `MedicationDispense.whenHandedOver` precision improved
- New `MedicationStatement.adherence` backbone element replaces extension

### Migration Strategy

1. **Phase 1 (Current)**: Publish R5 edition with core profiles (Patient, Practitioner, Organization) derived from EU Core R5
2. **Phase 2**: Migrate clinical profiles (Condition, AllergyIntolerance, Procedure) to R5
3. **Phase 3**: Adopt R5-only features (SubscriptionTopic, CodeableReference)
4. **Phase 4**: Evaluate R4 deprecation timeline based on EU/HSE adoption

### Dual-Version Testing

Both R4 and R5 editions are built and tested in CI. The GitHub Actions pipeline
runs SUSHI compilation for both versions independently:

```bash
# Build R4 (primary)
sushi .

# Build R5
sushi r5/
```

Implementers should validate resources against the appropriate version's profiles.
