// Architecture diagrams built from code with Fletcher 0.5.8.
// Adapted and simplified for teaching from eCREAM deliverable D3.2 (2024),
// especially Figure 1 (p. 9), Figures 2–4 (pp. 14–16) and Figure 5 (p. 17).
// These are conceptual diagrams, not a verified snapshot of the test deployment.
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

#let platform-architecture() = diagram(
  spacing: (72mm, 17mm),
  node-stroke: 0.8pt + rgb("#176B87"),
  edge-stroke: 0.9pt + rgb("#176B87"),
  node-fill: rgb("#E7F4F2"),
  node((0, 0), text(size: 13pt)[ER dashboard], corner-radius: 3pt),
  node((0, 1), text(size: 13pt)[Admin dashboard], corner-radius: 3pt),
  node((1, 0), text(size: 13pt)[Web API (BFF)], corner-radius: 3pt),
  node((1, 1), text(size: 13pt)[FHIR API], corner-radius: 3pt),
  node((2, 0), text(size: 13pt)[Patient Process Manager], corner-radius: 3pt),
  node((2, 1), text(size: 13pt)[Clinical Data], corner-radius: 3pt),
  edge((0, 0), (1, 0), "->"),
  edge((0, 1), (1, 0), "->"),
  edge((1, 0), (2, 0), "->"),
  edge((1, 1), (2, 1), "->"),
  edge((2, 0), (2, 1), "->"),
)

// The lesson follows one successful path; the real workflow has branches
// and hospital-specific configurations (D3.2, Figure 5, p. 17).
#let patient-journey() = diagram(
  spacing: (43mm, 13mm),
  node-stroke: 0.8pt + rgb("#176B87"),
  edge-stroke: 1pt + rgb("#176B87"),
  node-fill: rgb("#E7F4F2"),
  node((0, 0), text(size: 12pt)[Registration], corner-radius: 3pt),
  node((1, 0), text(size: 12pt)[Triage], corner-radius: 3pt),
  node((2, 0), text(size: 12pt)[Waiting list], corner-radius: 3pt),
  node((3, 0), text(size: 12pt)[Clinical care], corner-radius: 3pt),
  node((4, 0), text(size: 12pt)[Discharge], corner-radius: 3pt),
  edge((0, 0), (1, 0), "->"),
  edge((1, 0), (2, 0), "->"),
  edge((2, 0), (3, 0), "->"),
  edge((3, 0), (4, 0), "->"),
)

// The documents describe token validation using JWKS and separate ABAC checks.
// These calls represent responsibilities; they omit implementation details.
#let access-checks() = diagram(
  spacing: (66mm, 16mm),
  node-stroke: 0.8pt + rgb("#176B87"),
  edge-stroke: 0.9pt + rgb("#176B87"),
  node-fill: rgb("#E7F4F2"),
  node((0, 0), text(size: 12pt)[API client], corner-radius: 3pt),
  node((1, 0), text(size: 12pt)[Platform service], corner-radius: 3pt),
  node((2, -1), text(size: 12pt)[Authentication / JWKS], corner-radius: 3pt),
  node((2, 1), text(size: 12pt)[Permissions / ABAC], corner-radius: 3pt),
  edge((0, 0), (1, 0), "->"),
  edge((1, 0), (2, -1), "->"),
  edge((1, 0), (2, 1), "->"),
)
