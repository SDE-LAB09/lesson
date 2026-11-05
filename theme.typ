// Shared Touying University theme; colors match the reference screenshot.
// https://touying-typ.github.io/docs/themes/university/
#import "@preview/touying:0.7.4": *
#import themes.university: *

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
    short-title: [e-CREAM Workshop],
    subtitle: [Emergency care APIs, observability and AI],
    author: [e-CREAM Team],
    institution: [Software Design and Engineering Lab],
    date: datetime.today(),
    logo: none,
  ),
  // The active chapter overrides self.info.author for the left footer.
  footer-a: self => self.info.author,
  footer-b: self => self.info.short-title,
)
