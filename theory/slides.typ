// Matteo Girardi: 10–15 minute theory segment.
// Section titles (=) create dividers; slide titles (==) create regular slides.
// Architectural facts are grounded in the public eCREAM D3.2 deliverable (2024).
// The source is a design proposal: it does not prove the test deployment matches it.
#import "@preview/touying:0.7.4": *
#import "../components/diagrams.typ": platform-architecture, patient-journey, access-checks
#import "../components/terminal.typ": terminal
#show: touying-set-config.with(config-info(author: [Matteo Girardi]))

= Theory — e-CREAM and its APIs

== What is eCREAM?
- *eCREAM:* enabling Clinical Research in Emergency and Acute care Medicine through automated data extraction.
- *WP3:* design and develop an Emergency Department Electronic Health Record (ED-EHR).
- The system supports emergency-department work and interoperability with clinical and administrative systems.
- In this lesson we operate a fictional patient journey via APIs.

#text(size: 10pt, fill: gray)[Source: eCREAM D3.2 (2024), pp. 3–5.]

== Why a hybrid architecture?
- *Monolith:* one deployable unit, easier initial development and debugging, but grows harder to maintain.
- *Microservices:* independent services and deployments, but network and distributed-operation failures become harder to manage.
- *eCREAM D3.2 design:* begin with a modular monolith, then separate cohesive modules when appropriate.
- Do not assume every proposed module is an independently deployed microservice today.

#text(size: 10pt, fill: gray)[Source: D3.2, pp. 6–8 (design choice at publication).]

== Architecture: frontend, BFF, backend
#align(center)[#platform-architecture()]

- ER/Admin dashboards are frontends; Web API aggregates backend operations for them.
- FHIR API exposes a standardized interoperability interface to external clients.
- Process and data modules implement patient flow and clinical storage.

#text(size: 10pt, fill: gray)[Simplified from D3.2 Fig. 1 and pp. 10–13; not a deployment map.]

== What lives behind the API?
- *Patient Process Manager:* tracks patient stages and transitions.
- *Waiting List:* provides an overview of current emergency-department flow.
- *Personal Information Data:* stores identifiers and demographics.
- *Clinical Data, Diary, Medications:* store clinical records in FHIR-oriented structures.
- *Bridges:* integrate with other hospital systems.

#text(size: 10pt, fill: gray)[Source: D3.2, pp. 17–20. The module list is non-exhaustive.]

== Requests, identity and permissions
#align(center)[#access-checks()]

- The design uses HTTP endpoints for synchronous module communication.
- OIDC-based login provides tokens; services validate them using published JWKS.
- The separate Permissions module uses Attribute-Based Access Control (ABAC).
- Internal service-to-service protection includes a planned mTLS mechanism.

#text(size: 10pt, fill: gray)[Source: D3.2, pp. 11, 13–16; design, not confirmed runtime.]

== Interoperability: FHIR and OpenAPI
- *FHIR* is a healthcare data interoperability standard; it defines resources such as Patient and EpisodeOfCare.
- *OpenAPI* describes how to call this implementation's actual HTTP endpoints.
- An OpenAPI operation tells us its method, path, required fields, authorization and response schema.
- These are complementary: FHIR models data; OpenAPI documents HTTP interactions.

#terminal("1. Open /dev and select an operation.\n2. Read Parameters, Request body, Responses.\n3. Execute with the provided sandbox credentials.",
  title: [API discovery], font-size: 9.5pt)

== Our simplified patient journey
#align(center)[#patient-journey()]

- Registration creates or identifies the patient.
- Triage assigns a priority and moves the care episode forward.
- The waiting list exposes a global view of the emergency department.
- Snapshot and discharge conclude our exercise scenario.

#text(size: 10pt, fill: gray)[Teaching simplification of D3.2 Fig. 5 (p. 17); real paths can branch.]

== Before the exercises
- Open #link("https://ehr-test.ecreamproject.eu/dev")[e-CREAM API documentation].
- Keep the documented request method and path visible while working.
- Use *fictional data only*; do not paste real patient data into an LLM.
- Keep a copy of response IDs: later steps refer to the same patient and care episode.
- Validate the HTTP response before progressing to the next stage.

*Next:* Tanvir will demonstrate registration and triage.
