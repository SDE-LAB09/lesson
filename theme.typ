// Shared Touying theme: update this file only when changing the whole deck.
// The University theme provides the teal progress line, header, footer and section slides.
// Documentation: https://touying-typ.github.io/docs/themes/university
#import "@preview/touying:0.8.0": *
#import themes.university: *

// Keep all colors and metadata in one place for consistent slides.
#let presentation-theme = university-theme.with(
  aspect-ratio: "16-9",
  progress-bar: true,
  config-colors(
    primary: rgb("#04364A"),
    secondary: rgb("#176B87"),
    tertiary: rgb("#448C95"),
    neutral-lightest: white,
    neutral-darkest: black,
  ),
  config-info(
    title: [e-CREAM],
    short-title: [e-CREAM API Workshop],
    subtitle: [Emergency care APIs, observability and AI],
    author: [e-CREAM Team],
    institution: [Software Design and Engineering Lab],
    date: datetime.today(),
    logo: none,
  ),
  // The author is read per slide; each chapter overrides config-info(author: ...).
  footer-a: self => self.info.author,
  footer-b: self => self.info.short-title,
)
