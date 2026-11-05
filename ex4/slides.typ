// Federico Frigerio: inspect an EpisodeOfCare and complete the demo workflow.
// The snapshot path comes from the team's lesson plan, not the 2024 D3.2
// architecture document. Confirm its method and parameters in live OpenAPI.
// All care and discharge steps are part of a fictional training scenario.
#import "@preview/touying:0.7.4": *
#import "../components/terminal.typ": terminal
#show: touying-set-config.with(config-info(author: [Federico Frigerio]))

= Exercise 4

== The mission
1. Retrieve the current EpisodeOfCare snapshot.
2. Inspect everything collected since registration.
3. Summarize it through LiteLLM for a time-constrained doctor.
4. Save the summary as the final assignment.
5. Discharge the fictional patient in the test environment.

*The LLM does not decide whether discharge is clinically appropriate.*

== Step 0 — Snapshot API
- The team lesson plan names this route: 
  #raw("/fhir/epofcare/$snapshot")
- Find it in #link("https://ehr-test.ecreamproject.eu/dev")[the e-CREAM developer portal].
- Check HTTP method, episode identifier, required parameters and response schema.
- Copy the exact usable path, including any required parameters, into your shell.

#terminal("export SNAPSHOT_PATH='/fhir/epofcare/$snapshot'\n# Adjust the path/parameters from OpenAPI.",
  title: [shell / snapshot route], font-size: 9.2pt)

== Step 1 — Fetch snapshot
// GET is a demonstration pattern; follow the documented method if different.
// Quoting SNAPSHOT_PATH in single quotes on the previous slide preserves $.
#terminal("curl -sS -D snapshot-headers.txt \\\n  -o snapshot.json -X GET \\\n  \"$API_BASE$SNAPSHOT_PATH\" \\\n  -H \"Authorization: Bearer $TOKEN\" \\\n  -H 'Accept: application/json'",
  title: [shell / snapshot], font-size: 9pt)

- Include any query parameters or episode reference OpenAPI requires.
- Verify the HTTP status before treating the file as an episode snapshot.

== Step 2 — Inspect episode
#terminal("cat snapshot-headers.txt\njq . snapshot.json",
  title: [shell / inspect snapshot], font-size: 10pt)

- Identify the patient and EpisodeOfCare referenced by the JSON.
- Look for triage information, priority code and recorded care data.
- Check whether any parts of the record are missing or not yet available.
- Compare with the ID and priority saved during Exercise 1.

*The architecture describes patient state and clinical data as distinct concerns.*

== Step 3 — Build summary
- Imagine a doctor who has limited time to review a long record.
- Use only fictional or properly de-identified snapshot data.
- Reuse LITELLM_CHAT_URL, LITELLM_MODEL and LITELLM_KEY from Exercise 3.
- Ask for a factual summary without invented findings or diagnoses.

#terminal("jq -n --rawfile data snapshot.json \\\n  --arg model \"$LITELLM_MODEL\" \\\n  '{model:$model,\n    messages:[{role:\"user\",\n      content:(\"Summarize this care episode. \" +\n        \"No invented diagnoses or facts.\\n\" + $data)}]}' > summary-request.json",
  title: [shell / summary request], font-size: 8.5pt)

== Step 4 — Call LiteLLM
#terminal("curl -sS -D summary-headers.txt \\\n  -o summary-response.json -X POST \\\n  \"$LITELLM_CHAT_URL\" \\\n  -H \"Authorization: Bearer $LITELLM_KEY\" \\\n  -H 'Content-Type: application/json' \\\n  --data-binary @summary-request.json",
  title: [shell / LiteLLM], font-size: 8.8pt)

- Confirm that the endpoint returned a successful status.
- Compare key statements with snapshot.json.

== Step 5 — Discharge setup
1. Return to OpenAPI and find the patient/episode discharge operation.
2. Check whether discharge requires a status, reason or JSON request body.
3. Perform this action *only* on the fictional test patient.
4. Save the documented discharge route in DISCHARGE_PATH.

#terminal("export DISCHARGE_PATH='/DISCHARGE_FROM_OPENAPI'\n$EDITOR discharge.json\njq . discharge.json",
  title: [shell / discharge preparation], font-size: 9.2pt)

== Step 6 — Discharge
// Substitute the method and body only as required by the actual OpenAPI.
#terminal("curl -sS -D discharge-headers.txt \\\n  -o discharge-response.json -X POST \\\n  \"$API_BASE$DISCHARGE_PATH\" \\\n  -H \"Authorization: Bearer $TOKEN\" \\\n  -H 'Content-Type: application/json' \\\n  --data-binary @discharge.json",
  title: [shell / discharge], font-size: 8.8pt)

- Read the response status and confirm the resulting episode state.

== Step 7 — Submit result
#terminal("jq -r '.choices[0].message.content' \\\n  summary-response.json > assignment.txt\ncat assignment.txt",
  title: [shell / final artifact], font-size: 9.5pt)

- Verify the summary against snapshot.json before handing it in.
- Submit assignment.txt as instructed by the professors.
- Keep any bearer tokens and private data out of submissions.

*Checkpoint:* snapshot, saved LLM summary and completed demo discharge.

== Lesson takeaways
- API operations guide end-to-end care workflows.
- The hybrid design separates process management and clinical data.
- Grafana helps correlate failures across distributed components.
- LiteLLM can summarize data, but every claim requires verification.
