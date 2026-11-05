// Reusable dark terminal window for shell commands and JSON examples.
// Usage: #terminal("curl -s \"$API_BASE\" | jq .", title: [shell])
// Pass a string, not Typst markup: raw() keeps shell characters literal.
#let terminal(code, title: [terminal], font-size: 10.5pt) = block(
  width: 100%,
  fill: rgb("#111B25"),
  stroke: 0.7pt + rgb("#304251"),
  radius: 7pt,
  inset: 11pt,
)[
  // Conventional macOS-style window controls (red, yellow, green).
  #grid(
    columns: (auto, auto, auto, 1fr),
    gutter: 6pt,
    circle(radius: 3.4pt, fill: rgb("#FF625D")),
    circle(radius: 3.4pt, fill: rgb("#FFC04D")),
    circle(radius: 3.4pt, fill: rgb("#35CA65")),
    align(right, text(fill: rgb("#B5C7D3"), size: 9pt)[#title]),
  )
  #v(10pt)
  #text(font: "DejaVu Sans Mono", size: font-size, fill: rgb("#E2EEF7"))[
    #raw(code, block: true, theme: none)
  ]
]
