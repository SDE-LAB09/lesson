// Tanvir Ahmed: perform each numbered step before moving to the next slide.
// Replace placeholder paths and payloads with operations from the live OpenAPI.
// The architecture deliverable does not define exact endpoint schemas.
#import "@preview/touying:0.7.4": *
#import "../components/terminal.typ": terminal
#show: touying-set-config.with(config-info(author: [Tanvir Ahmed]))

= Exercise 1 — Registration and triage

== The mission: complete one triage
1. Register a *fictional patient*.
2. Start triage in the related EpisodeOfCare.
3. End triage.
4. Read the returned *priority code*.

*Keep the patient and episode IDs for later exercises.*

== Step 0 — Find the real operations
1. Open #link("https://ehr-test.ecreamproject.eu/dev")[the developer portal].
2. Locate patient registration; record its method and path.
3. Locate the EpisodeOfCare triage start and end operations.
4. Check required fields, authorization and documented response status.

*The paths on the next slides are placeholders, not confirmed endpoints.*

== Step 1 — Prepare a shell
// Use the actual server URL and paths from OpenAPI; do not guess them.
#terminal("export API_BASE='https://SERVER_FROM_OPENAPI'\nexport PATIENT_PATH='/PATH_FROM_OPENAPI'\nexport TRIAGE_START_PATH='/START_PATH'\nexport TRIAGE_END_PATH='/END_PATH'",
  title: [shell / configuration], font-size: 9.5pt)

- Replace the placeholders with the real OpenAPI values.
- Obtain a test access token using the instructors' instructions.

#terminal("read -rs -p 'Access token: ' TOKEN; echo\nexport TOKEN",
  title: [shell / credentials], font-size: 9.5pt)

== Step 2 — Write the patient request
1. Open the registration request-body schema in OpenAPI.
2. Copy its example JSON to a local file called patient.json.
3. Enter a fictional name, surname, birth date and sex.
4. Verify every required field and its type.

#terminal("$EDITOR patient.json\njq . patient.json",
  title: [shell / check JSON], font-size: 10pt)

*Use the actual field names from the schema.*

== Step 3 — Register the patient
#terminal("curl -sS -D patient-headers.txt \\\n  -o patient-response.json -X POST \\\n  \"$API_BASE$PATIENT_PATH\" \\\n  -H \"Authorization: Bearer $TOKEN\" \\\n  -H 'Content-Type: application/json' \\\n  --data-binary @patient.json",
  title: [shell / registration], font-size: 9pt)

- Check the HTTP status in patient-headers.txt.
- Inspect patient-response.json and save the patient identifier.
- If the documented method is not POST, adapt the command.

== Step 4 — Inspect the response
#terminal("cat patient-headers.txt\njq . patient-response.json",
  title: [shell / inspect], font-size: 10pt)

- Which field identifies the patient?
- Is there an EpisodeOfCare ID, or is it created separately?
- Is the response a FHIR resource or a wrapper object?
- Record the actual JSON paths for IDs you will reuse.

*Never assume the identifier must be a top-level ID field.*

== Step 5 — Start triage
1. Open the triage start operation and inspect the request schema.
2. Copy the *instructor-provided payload* to triage-start.json.
3. Add the patient or episode reference where required.
4. Execute the documented operation.

#terminal("curl -sS -D triage-start-headers.txt \\\n  -o triage-start-response.json -X POST \\\n  \"$API_BASE$TRIAGE_START_PATH\" \\\n  -H \"Authorization: Bearer $TOKEN\" \\\n  -H 'Content-Type: application/json' \\\n  --data-binary @triage-start.json",
  title: [shell / triage start], font-size: 9pt)

== Step 6 — End triage
1. Locate the triage end operation and its request schema.
2. Create triage-end.json using the provided exercise data.
3. Execute the documented route and method.

#terminal("curl -sS -D triage-end-headers.txt \\\n  -o triage-end-response.json -X POST \\\n  \"$API_BASE$TRIAGE_END_PATH\" \\\n  -H \"Authorization: Bearer $TOKEN\" \\\n  -H 'Content-Type: application/json' \\\n  --data-binary @triage-end.json",
  title: [shell / triage end], font-size: 9pt)

== Step 7 — Find the priority code
#terminal("cat triage-end-headers.txt\njq . triage-end-response.json",
  title: [shell / triage result], font-size: 10pt)

- Find the priority code and consult the documented meaning.
- Confirm the response refers to your patient and episode.
- Save the JSON response and identifiers for the next exercises.

*Checkpoint:* patient registered; triage started, ended and verified.
