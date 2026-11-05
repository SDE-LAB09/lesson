// Matteo's chapter. The footer author is configured for this section.
#import "@preview/touying:0.7.4": *
#show: touying-set-config.with(config-info(author: [Matteo Girardi]))

// A single equals sign creates a section divider slide automatically.
= Theory — e-CREAM and its APIs

== Why e-CREAM?
- Emergency departments need a coordinated view of care episodes.
- e-CREAM provides APIs for healthcare workflows and structured resources.
- We will follow a fictional patient from registration through discharge.

== Architecture: conceptual overview
#align(center)[
  #rect(inset: 12pt, radius: 5pt, fill: rgb("#E8F2F4"))[
    *API client*  →  *e-CREAM services*  →  *Healthcare resources*
  ]
]
- Clients call services over HTTP.
- Each service has a responsibility in the care workflow.
- Logs and dashboards help investigate failures across services.

#text(size: 12pt, fill: gray)[Conceptual overview; verify exact service names from the deployment.]

== OpenAPI and FHIR concepts
- OpenAPI describes routes, parameters, request and response schemas.
- Explore #link("https://ehr-test.ecreamproject.eu/dev")[the e-CREAM developer portal].
- Key concepts include Patient and EpisodeOfCare.
- Use the actual schema before writing any request payload.

== Lesson journey
1. Register a patient and complete triage.
2. Send invalid requests and investigate Grafana logs.
3. Retrieve the queue and summarize it with LiteLLM.
4. Inspect the care episode snapshot and discharge the patient.

*Use fictional patient data only.*
