// Lorys's chapter. All headings and comments are in English.
#import "@preview/touying:0.7.4": *
#show: touying-set-config.with(config-info(author: [Lorys]))

= Exercise 2 — Observability

== Microservices and observability
- An HTTP error tells the client what failed, but not always why.
- Logs contain details about errors and request handling.
- Grafana can help inspect service events.
- Timestamps and request identifiers can correlate observations.

== Make an API request fail
1. Start from a valid request used in Exercise 1.
2. Change a required field, its type or its value.
3. Record the status code and diagnostic message.
4. Compare this response with the valid request.

*Use fictional data and the provided test environment.*

== Find the failure in Grafana
- Open the logs view in the supplied Grafana environment.
- Filter by timestamp, service or correlation ID.
- Locate the event corresponding to the invalid request.
- Explain what the API response reveals versus the server logs.

*Expected result:* the failed request and its matching log entry.
