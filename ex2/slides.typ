// Lorys Mutti: hands-on observability lab.
// Only use the test environment and the fictional registration payload.
// Grafana dashboard names are environment-specific and must be shown live.
#import "@preview/touying:0.7.4": *
#import "../components/terminal.typ": terminal
#show: touying-set-config.with(config-info(author: [Lorys Mutti]))

= Exercise 2

== Why observability?
- A client sees the HTTP request and response.
- A backend service sees validation, permission and database events.
- Multiple components may be involved in a single operation.
- *Logs* explain individual events; *metrics* show trends; *traces* connect operations across services.

*Goal:* correlate an intentional API error with evidence in Grafana.

== Step 0 — Baseline
1. Reuse the same API_BASE, PATIENT_PATH and TOKEN from Exercise 1.
2. Open your successful request and response from registration.
3. Record the current UTC time before testing.
4. Confirm that you are using the *test* environment.

#terminal("date -u '+%Y-%m-%dT%H:%M:%SZ'\ncat patient-headers.txt",
  title: [shell / baseline], font-size: 10pt)

== Step 1 — Unknown route
// An unknown route tests routing, not application-level validation.
#terminal("curl -sS -i \\\n  \"$API_BASE/this-route-does-not-exist\" \\\n  -H \"Authorization: Bearer $TOKEN\"",
  title: [shell / unknown route], font-size: 9.5pt)

- Note the status and response body; the exact status depends on routing and authentication.
- Ask: did the request reach a service or get rejected earlier?

== Step 2 — Invalid JSON
// Invalid JSON tests parsing; it is not a valid patient registration.
#terminal("curl -sS -i -X POST \\\n  \"$API_BASE$PATIENT_PATH\" \\\n  -H \"Authorization: Bearer $TOKEN\" \\\n  -H 'Content-Type: application/json' \\\n  --data-binary '{invalid-json'",
  title: [shell / malformed JSON], font-size: 9.5pt)

- Capture the HTTP status, message and timestamp.
- What does the response reveal about input validation?
- An authorization error must be fixed before interpreting validation.

== Step 3 — Capture error
#terminal("date -u '+%Y-%m-%dT%H:%M:%SZ'\ncurl -sS -D error-headers.txt \\\n  -o error-body.txt -X POST \\\n  \"$API_BASE$PATIENT_PATH\" \\\n  -H \"Authorization: Bearer $TOKEN\" \\\n  -H 'Content-Type: application/json' \\\n  --data-binary '{invalid-json'",
  title: [shell / capture evidence], font-size: 9pt)

- Read error-headers.txt and error-body.txt.
- If a request or trace ID is returned, record it.
- Do not share bearer tokens, patient identifiers or credentials.

== Step 4 — Search Grafana
1. Open the Grafana instance provided by the instructors.
2. Navigate to *Explore* (or the prepared logs dashboard).
3. Select the configured logs data source.
4. Set an absolute or recent time window around your failed request.
5. Narrow by service, status, message, or request ID when available.

*Do not assume a fixed Grafana data source, label or dashboard name.*

== Step 5 — Explain error
- Find a log event with a matching time and request path.
- Compare the logged error with the HTTP response.
- Distinguish parse/validation errors from authorization and routing errors.
- Discuss whether logs alone are enough to follow a request across modules.

*Checkpoint:* show your request, HTTP result and matching Grafana evidence.
