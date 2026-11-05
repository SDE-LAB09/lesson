// Shared entry point: edit this file only to change the presentation order.
#import "@preview/touying:0.7.4": *
#import themes.university: title-slide, focus-slide
#import "theme.typ": presentation-theme

#set document(
  title: "e-CREAM — Emergency Care API Lesson",
  author: (
    "Marco Toniolo",
    "Federico Frigerio",
    "Lorys Mutti",
    "Matteo Girardi",
    "Tanvir Ahmed",
  ),
)
#show: presentation-theme

// Cover: preserve the order supplied by the team.
#title-slide(authors: (
  [Marco Toniolo],
  [Federico Frigerio],
  [Lorys Mutti],
  [Matteo Girardi],
  [Tanvir Ahmed],
))

// A focus slide does not use the University header/footer. The roadmap
// belongs to the whole team, not to the speaker of the first chapter.
#focus-slide(background-color: white)[
  #text(fill: rgb("#04364A"), size: 29pt, weight: "bold")[Lesson roadmap]

  #v(0.8em)

  #text(fill: rgb("#263845"), size: 18pt)[
    *Theory* — architecture and OpenAPI (Matteo Girardi)

    *Exercise 1* — patient registration and triage (Tanvir Ahmed)

    *Exercise 2* — observability and Grafana (Lorys Mutti)

    *Exercise 3* — queue analysis with LiteLLM (Marco Toniolo)

    *Exercise 4* — snapshot and discharge (Federico Frigerio)
  ]
]

// Keep chapter contents in separate files to reduce merge conflicts.
#include "theory/slides.typ"
#include "ex1/slides.typ"
#include "ex2/slides.typ"
#include "ex3/slides.typ"
#include "ex4/slides.typ"

#focus-slide[
  *Questions?*

  e-CREAM API lesson
]
