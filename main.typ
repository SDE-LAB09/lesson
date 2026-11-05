// Entry point: the only file that controls the presentation order.
// Contributors should normally edit only their own chapter's slides.typ file.
#import "@preview/touying:0.8.0": *
#import "theme.typ": presentation-theme

#set document(
  title: "e-CREAM — Emergency Care API Workshop",
  author: ("Matteo", "Tanvir", "Lorys", "Marco", "Federico"),
)

// The theme creates slide pages from level-two headings (==).
// Level-one headings (=) create section divider slides automatically.
#show: presentation-theme

// The title slide lists everyone; individual chapters change the footer author.
#title-slide(authors: (
  [Matteo],
  [Tanvir],
  [Lorys],
  [Marco],
  [Federico],
))

== Workshop roadmap <touying:hidden>

- *Theory* — e-CREAM, service architecture and OpenAPI (Matteo)
- *Exercise 1* — patient registration and triage (Tanvir)
- *Exercise 2* — failed requests and Grafana (Lorys)
- *Exercise 3* — queue analysis with LiteLLM (Marco)
- *Exercise 4* — patient snapshot and discharge (Federico)

// Each include keeps a chapter separate to reduce merge conflicts.
// The order here is the speaking order; do not put chapter text in main.typ.
#include "theory/slides.typ"
#include "ex1/slides.typ"
#include "ex2/slides.typ"
#include "ex3/slides.typ"
#include "ex4/slides.typ"

// Focus slides are useful for transitions and the final discussion.
#focus-slide[
  *Questions?*

  e-CREAM API workshop
]
