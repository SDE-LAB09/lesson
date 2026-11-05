// Marco's chapter. Replace example prompts only after reviewing test data.
#import "@preview/touying:0.7.4": *
#show: touying-set-config.with(config-info(author: [Marco Toniolo]))

= Exercise 3 — Queue insights with LiteLLM

== From a queue to a question
- The e-CREAM API exposes data about a patient queue.
- Structured JSON can be used as context for an LLM.
- LiteLLM offers an OpenAI-compatible interface.
- Summaries assist operators, but do not replace clinical judgment.

== Retrieve the patient queue
1. Locate the queue operation in the e-CREAM API documentation.
2. Submit the request and inspect the response status.
3. Save the JSON response for the next step.
4. Check whether identifiers must be removed before sharing.

*Use only synthetic or appropriately de-identified data.*

== Ask LiteLLM for a summary
- Use the LiteLLM URL and credentials provided by the instructors.
- Send the queue JSON in a user message.
- Example prompt: _Summarize the current hospital queue using only this JSON. Identify any missing information._
- Compare the response against the original queue.

== Check the model's claims
- Are patient counts and priority descriptions supported by the JSON?
- Does the model invent information about staffing or waiting times?
- Could stale or incomplete data change the conclusion?
- What should the user verify before relying on a summary?

*Expected result:* a justified summary and its limitations.
