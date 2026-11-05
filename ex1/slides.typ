// Tanvir's chapter. Add slides using headings that begin with ==.
#import "@preview/touying:0.7.4": *
#show: touying-set-config.with(config-info(author: [Tanvir]))

= Exercise 1 — Registration and triage

== Goal: register a patient
- Register a fictional patient using the e-CREAM API.
- Start triage for the associated EpisodeOfCare.
- End triage and inspect the returned priority code.

*Read the OpenAPI schema before constructing requests.*

== Step 1: patient registration
1. Locate the registration operation in the developer portal.
2. Enter the required name, surname, birth date and sex fields.
3. Submit the request and save the returned patient identifier.
4. Inspect the HTTP status and response.

#text(size: 12pt, fill: gray)[Route and JSON field names must be verified in OpenAPI.]

== Steps 2–3: triage
- Find the EpisodeOfCare triage start operation (the start action).
- Submit the provided workshop payload.
- Finish triage using the end action.
- Inspect the returned priority code.

*Expected result:* a patient registered and triaged successfully.
