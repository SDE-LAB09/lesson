// Marco Toniolo: step-by-step queue analysis with an OpenAI-compatible API.
// Use only fictional or de-identified queue data. URLs, model IDs and
// credentials must be supplied by the instructors; do not commit secrets.
#import "@preview/touying:0.7.4": *
#import "../components/terminal.typ": terminal
#show: touying-set-config.with(config-info(author: [Marco Toniolo]))

= Exercise 3 — Queue insights with LiteLLM

== Goal: turn a queue into a summary
1. Retrieve the current patient queue as JSON.
2. Inspect its structure and remove sensitive data.
3. Forward the JSON to the instructor-provided LiteLLM endpoint.
4. Ask for an evidence-based summary of the hospital situation.
5. Check the reply against the original JSON.

*An LLM summary is not a clinical recommendation.*

== Step 0 — Find the queue API
1. Open the #link("https://ehr-test.ecreamproject.eu/dev")[e-CREAM developer portal].
2. Locate the operation that returns the patient waiting list/queue.
3. Note the HTTP method, path, query parameters and response schema.
4. Copy its route into the shell variable QUEUE_PATH.

#terminal("export QUEUE_PATH='/QUEUE_PATH_FROM_OPENAPI'\necho \"$API_BASE$QUEUE_PATH\"",
  title: [shell / queue route], font-size: 9.5pt)

== Step 1 — Download the JSON queue
// Replace GET if OpenAPI documents a different HTTP method.
#terminal("curl -sS -D queue-headers.txt \\\n  -o queue.json -X GET \\\n  \"$API_BASE$QUEUE_PATH\" \\\n  -H \"Authorization: Bearer $TOKEN\" \\\n  -H 'Accept: application/json'",
  title: [shell / retrieve queue], font-size: 9pt)

- Confirm a successful HTTP status.
- Retain the raw response for validation and comparison.

== Step 2 — Inspect the result
#terminal("jq . queue.json\njq 'type' queue.json",
  title: [shell / inspect data], font-size: 10pt)

- Is the top-level value an array, object or FHIR Bundle?
- Identify the entries and fields relevant to priorities and waiting times.
- Compare the observed structure with OpenAPI.
- *Do not forward real patient identifiers to the LLM.*

== Step 3 — Configure LiteLLM
// Enter the full OpenAI-compatible chat-completions URL supplied in class.
// A server hostname and model name are not documented in D3.2.
#terminal("export LITELLM_CHAT_URL='https://HOST/CHAT_ENDPOINT'\nexport LITELLM_MODEL='MODEL_FROM_INSTRUCTORS'\nread -rs -p 'LiteLLM key: ' LITELLM_KEY; echo\nexport LITELLM_KEY",
  title: [shell / LLM connection], font-size: 8.8pt)

- Check that the endpoint is authorized for the demonstration data.
- The model identifier is a deployment-specific name, not an assumed default.

== Step 4 — Build the chat payload
// jq --rawfile inserts the entire JSON file as plain text into the prompt.
#terminal("jq -n --rawfile data queue.json \\\n  --arg model \"$LITELLM_MODEL\" \\\n  '{model:$model,messages:[{role:\"user\", \\\n  content:(\"Summarize the hospital queue. \"+\n  \"Use only the JSON; report unknowns.\\n\"+$data)}]}' \\\n  > llm-request.json",
  title: [shell / JSON request], font-size: 8.5pt)

- Verify llm-request.json using jq before sending it.
- If the queue contains identifying data, sanitize it first.

== Step 5 — Send the request
#terminal("curl -sS -D llm-headers.txt \\\n  -o llm-response.json -X POST \\\n  \"$LITELLM_CHAT_URL\" \\\n  -H \"Authorization: Bearer $LITELLM_KEY\" \\\n  -H 'Content-Type: application/json' \\\n  --data-binary @llm-request.json",
  title: [shell / LiteLLM], font-size: 9pt)

- Inspect the status before attempting to parse the answer.

== Step 6 — Read and evaluate
#terminal("jq -r '.choices[0].message.content' \\\n  llm-response.json",
  title: [shell / model answer], font-size: 9.5pt)

- Does the model report counts and priorities actually present in queue.json?
- Does it invent staff availability, waiting times or diagnoses?
- What important information is missing from the source data?

*Checkpoint:* queue JSON, LLM request, and verified summary.
