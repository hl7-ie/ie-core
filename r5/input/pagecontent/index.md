### IE Core — FHIR R5 Edition

**⚠️ Proof of Concept (PoC):** This Implementation Guide is built as a Proof of Concept by Nithin Mohan. It has no support from the HSE, HSE Standards team, or Department of Health. In future, this may be handed over to a governing body within Ireland for maintaining this implementation guide. This IG is the author's proof of concept to demonstrate how FHIR adoption should be implemented at the national level.

This is the **FHIR R5 edition** of the IE Core Implementation Guide. It mirrors
the [R4 edition](https://hl7-ie.github.io/ie-core/fhir/ie/core) and will progressively adopt
R5-specific capabilities as they mature.

### Relationship to R4

The R4 edition remains the **primary, production-ready** specification. The R5
edition is published for early adopters and to align with the HL7 Europe R5
roadmap.

| Aspect | R4 | R5 |
|--------|----|----|
| Package | `hl7.fhir.ie.core` | `hl7.fhir.ie.core.r5` |
| FHIR version | 4.0.1 | 5.0.0 |
| EU dependency | `hl7.fhir.eu.base` | `hl7.fhir.eu.base-r5` |
| Status | Primary | Early access |

### R5-Specific Features (Planned)

Once stable, the R5 edition will adopt:

- **Subscriptions Framework** — Topic-based subscriptions replacing R4 Subscription
- **SubscriptionTopic** — Declarative event definitions for Irish healthcare events
- **CodeableReference** — Unified coded/reference choices in medication and clinical profiles
- **Evidence-Based Medicine resources** — For clinical guidelines and decision support
- **Requirements resource** — Formalising capability requirements beyond CapabilityStatement
- **NutritionIntake** — Standardised nutritional data capture
- **InventoryItem / InventoryReport** — For medical device and supply chain tracking

### EU EHDS R5 Alignment

HL7 Europe publishes both R4 and R5 editions of the EU Base and Core profiles.
IE Core R5 derives from `hl7.fhir.eu.base-r5` to maintain EHDS conformance on
both FHIR versions.
