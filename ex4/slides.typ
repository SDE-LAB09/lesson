// Federico's chapter. Each == heading adds a slide in Touying.
#import "@preview/touying:0.7.4": *
#show: touying-set-config.with(config-info(author: [Federico]))

= Exercise 4 — Snapshot and discharge

== Inspect the care episode
- Call the documented /fhir/epofcare/$snapshot operation.
- Inspect the JSON snapshot for the current EpisodeOfCare.
- Identify relevant patient information and triage details.
- Note any fields that are missing or unclear.

*Verify route parameters and authorization in the developer portal.*

== Summarize the snapshot
- Imagine a busy doctor who needs a concise overview.
- Send the fictional or de-identified snapshot to LiteLLM.
- Example prompt: _Summarize this patient record, list uncertainties and do not invent diagnoses._
- Save the response for the final assignment.

== Discharge and submit
1. In this fictional scenario, the patient is ready for discharge.
2. Locate the discharge operation in OpenAPI.
3. Perform discharge and confirm the resulting episode state.
4. Submit the saved LiteLLM summary to the instructors.

*Expected result:* discharged demo patient and saved summary.

== Key takeaways
- OpenAPI helps discover API operations and request schemas.
- Observability supports debugging in distributed systems.
- LLM-generated summaries require validation and privacy safeguards.
- The exercises cover the workflow from registration to discharge.
