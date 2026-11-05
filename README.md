# e-CREAM — Typst Lesson Slides

This repository contains the shared presentation for the e-CREAM Software Design and Engineering lab. It uses [Typst](https://typst.app/) with the [Touying University theme](https://touying-typ.github.io/docs/themes/university/) (version 0.7.4).

## Lesson flow and speakers

| Chapter | Speaker | Lesson content |
| --- | --- | --- |
| Theory | Matteo Girardi | e-CREAM architecture, service-oriented systems, OpenAPI and FHIR resources; approximately 10–15 minutes |
| Exercise 1 | Tanvir Ahmed | Register a patient, start triage through EpisodeOfCare, end triage and inspect the priority code |
| Exercise 2 | Lorys Mutti | Introduce microservice observability, generate invalid API requests and inspect Grafana logs |
| Exercise 3 | Marco Toniolo | Introduce the OpenAI-compatible LiteLLM endpoint, retrieve a patient queue and ask an LLM to summarize the hospital situation |
| Exercise 4 | Federico Frigerio | Retrieve the EpisodeOfCare snapshot, use LiteLLM to summarize it, discharge the fictional patient and submit the saved summary |

**Important:** The chapter content is a starting draft, not verified API documentation. For exact routes, payloads, authentication and response schemas, consult [the e-CREAM developer portal](https://ehr-test.ecreamproject.eu/dev). The snapshot route referenced by the lesson plan is `/fhir/epofcare/$snapshot`. Other operations should be discovered from the deployed OpenAPI specification.

Use fictional or appropriately de-identified data for every exercise, especially when sending JSON to LiteLLM. Do not use an LLM-generated summary as a clinical decision.

## Repository structure

```text
.
├── main.typ                  # Shared presentation entry point and slide order
├── theme.typ                 # Shared Touying University theme
├── theory/slides.typ         # Matteo
├── ex1/slides.typ            # Tanvir
├── ex2/slides.typ            # Lorys
├── ex3/slides.typ            # Marco
├── ex4/slides.typ            # Federico
├── components/
│   ├── terminal.typ         # Shared dark terminal window
│   └── diagrams.typ         # Fletcher architecture/flow diagrams
├── font/README.md           # Optional custom font directory
├── .github/workflows/
│   └── build-slides.yml      # Compile and publish PDF artifacts
├── .gitignore
└── README.md
```

## Compile locally

Install [Typst](https://typst.app/) (the CI build uses version 0.15.1). From the repository root:

```bash
typst compile --font-path font main.typ slides.pdf
```

For live recompilation during editing:

```bash
typst watch --font-path font main.typ slides.pdf
```

Touying is fetched automatically from Typst Universe on first compilation, so the first build requires package download access. No custom fonts are required. PDFs are ignored by Git and should not be committed.

## Editing your own chapter

1. Work in a separate feature branch and modify only your `slides.typ` file whenever possible.
2. Keep all names, comments and slide text in English.
3. Add a section divider using `= Section title` and a regular slide using `== Slide title`. The Touying theme creates the slide layout.
4. Use `#pause` inside a slide to reveal the next item in a later PDF page (animation step).
5. Your chapter sets the speaker's footer using `#show: touying-set-config.with(config-info(author: [Your name]))`. Do not change the global author in `theme.typ`.
6. Use `#import "../components/terminal.typ": terminal` for shell and JSON examples. Do not reimplement terminal window styling in each chapter.
7. Use the shared diagrams in `components/diagrams.typ` (Fletcher 0.5.8). Diagrams should be updated centrally and reviewed for accuracy.
8. Compile locally before opening a pull request. Avoid editing `main.typ` or `theme.typ` unless everyone agrees.

Basic example:

```typst
// This heading creates a new slide automatically.
== Example slide

- A key fact
- Another key fact

// Reveal this item on the next presentation step.
#pause

- A follow-up fact
```

## PDF builds on GitHub Actions

Every push to **any branch** triggers the **Build Typst slides** workflow. A successful build uploads the compiled `slides.pdf` as a GitHub Actions artifact. There is no need to place generated PDFs in a Git branch or commit them.

To download the PDF, open **Actions → Build Typst slides → select the relevant run → Artifacts**. Each artifact is named `e-cream-slides-<branch>-<run-id>` (slashes in branch names become hyphens), so multiple branches can coexist without collisions. The **main** branch builds are retained for **90 days** and other branches for **14 days**, subject to the repository's GitHub retention limits.

Each run is an immutable snapshot of the branch at the triggering commit. When changes are merged into `main`, a new build generates the presentation that includes everyone's work. For an indefinitely available PDF, a future GitHub Release could be created from a reviewed `main` commit; workflow artifacts are not permanent archives.

### Documentation

- [Typst](https://typst.app/docs/)
- [Touying University theme](https://touying-typ.github.io/docs/themes/university/)
- [e-CREAM developer portal](https://ehr-test.ecreamproject.eu/dev)

## Course material and source accuracy

The theory chapter and diagrams are teaching adaptations of **eCREAM Deliverable D3.2: Architectural Design**, final version dated **29 November 2024**. That document describes a **hybrid approach**: begin as a modular monolith, with the possibility of later separating highly cohesive, loosely coupled modules. Its conceptual architecture covers ER and admin dashboards, Web and FHIR APIs, process modules, data stores, OIDC/JWT authentication, authorization and the patient journey. Its diagrams are design-stage views, not proof that today's test instance is deployed exactly in that form.

The exercises follow the team's lesson plan. The live test portal was not accessible during drafting, so the slides **do not claim verified endpoint signatures**. Paths shown as placeholders and sample HTTP methods must be replaced with the values listed in [the current e-CREAM OpenAPI portal](https://ehr-test.ecreamproject.eu/dev). The snapshot path comes from the team's own plan and must also be checked before the lesson.

### Student preparation checklist

1. Install Typst for preparing slides; for API exercises install curl and jq (or an equivalent API client).
2. Obtain the sandbox server URL and an authorized test access token from the instructors.
3. In the OpenAPI portal, find the operations for registration, triage start/end, patient queue, EpisodeOfCare snapshot and discharge.
4. Copy valid JSON request examples from the actual schema. Do not substitute invented field names.
5. Obtain the LiteLLM chat-completions URL, model identifier and demonstration key from the instructors.
6. Obtain access to the designated Grafana instance and its logs data source.
7. Use synthetic patient data only. Keep secrets out of Git and screenshots.

### Reusable visual components

`components/terminal.typ` exposes a terminal window with a dark background and red, yellow and green controls. The argument is a plain string, so shell symbols are displayed literally:

```typst
#import "../components/terminal.typ": terminal

#terminal("curl -sS \"$API_BASE$QUEUE_PATH\"", title: [shell])
```

`components/diagrams.typ` uses [Fletcher](https://typst.app/universe/package/fletcher/) to express editable architecture diagrams as Typst source. Its functions are imported into the theory chapter. The figures intentionally simplify D3.2: review changes against the source document and avoid misrepresenting architecture *proposals* as verified details of the current deployment.

### Footer and speaker ownership

The cover lists all five full names in the order decided by the team. The opening Lesson roadmap uses a footer-free focus slide; chapters set their own author footer, with the current speaker's full name. The closing Questions slide is also a team-wide focus slide.
