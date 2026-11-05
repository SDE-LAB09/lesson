// Shared entry point: edit only to change the order of chapters.
#import "@preview/touying:0.7.4": *
#import themes.university: title-slide, focus-slide
#import "theme.typ": presentation-theme

#set document(
  title: "e-CREAM — Emergency Care API Workshop",
  author: ("Matteo", "Tanvir", "Lorys", "Marco", "Federico"),
)
#show: presentation-theme

// The title slide shows all five speakers.
#title-slide(authors: (
  [Matteo], [Tanvir], [Lorys], [Marco], [Federico],
))

// Two equals signs create a slide; hidden slides do not appear in the outline.
== Workshop roadmap <touying:hidden>
- *Theory* — architecture and OpenAPI (Matteo)
- *Exercise 1* — patient registration and triage (Tanvir)
- *Exercise 2* — observability and Grafana (Lorys)
- *Exercise 3* — queue analysis with LiteLLM (Marco)
- *Exercise 4* — snapshot and discharge (Federico)

// Keep chapter content in the separate files to reduce merge conflicts.
#include "theory/slides.typ"
#include "ex1/slides.typ"
#include "ex2/slides.typ"
#include "ex3/slides.typ"
#include "ex4/slides.typ"

#focus-slide[
  *Questions?*

  e-CREAM API workshop
]
