#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import "@preview/pintorita:0.1.4"
#import "@preview/primaviz:0.7.0": bar-chart, multi-line-chart, resolve-theme
#import "@preview/linguify:0.5.0": linguify-raw
#import "../template/lib.typ": tablefigure
#import "../template/utils.typ": __linguify-content

#show raw.where(lang: "pintora"): it => pintorita.render(it.text, style="dark")

#let diagram-preview(caption, typst-code, content) = tablefigure(
  caption: caption,
  columns: 2,
  align: (_, row) => if row == 0 { center } else { horizon + left },
  table-content: (
    table.header(
      context eval(linguify-raw("diagrams-code-column"), mode: "markup"),
      context eval(linguify-raw("diagrams-output-column"), mode: "markup"),
    ),
    align(horizon, box(width: 100%, raw(typst-code, lang: "typ", block: true))),
    box(width: 100%, {
      set heading(outlined: false)
      content
    }),
  ),
)

= #context eval(linguify-raw("diagrams-heading"), mode: "markup")

#context eval(linguify-raw("diagrams-intro"), mode: "markup")

== #context eval(linguify-raw("diagrams-workflows-heading"), mode: "markup")

#context eval(linguify-raw("diagrams-workflows-text"), mode: "markup")

#diagram-preview(
  context eval(linguify-raw("diagrams-caption-flowchart"), mode: "markup"),
  "#import \"@preview/fletcher:0.5.8\" as fletcher: diagram, node, edge

#diagram(
  node-stroke: 1pt,
  node((0, 0), [Start], corner-radius: 2pt, extrude: (0, 3)),
  edge(\"-|>\"),
  node(
    (0, 1),
    align(center)[Hey, wait,\\ this flowchart\\ is a trap!],
    shape: fletcher.shapes.diamond,
  ),
  edge(\"d,r,u,l\", \"-|>\", [Yes], label-pos: 0.1),
)",
  diagram(
    node-stroke: 1pt,
    node((0, 0), [Start], corner-radius: 2pt, extrude: (0, 3)),
    edge("-|>"),
    node(
      (0, 1),
      align(center)[Hey, wait,\ this flowchart\ is a trap!],
      shape: fletcher.shapes.diamond,
    ),
    edge("d,r,u,l", "-|>", [Yes], label-pos: 0.1),
  ),
)

== #context eval(linguify-raw("diagrams-cs-heading"), mode: "markup")

#context eval(linguify-raw("diagrams-cs-text"), mode: "markup")

#diagram-preview(
  context eval(linguify-raw("diagrams-caption-sequence"), mode: "markup"),
  "#import \"@preview/pintorita:0.1.4\"

#show raw.where(lang: \"pintora\"): it => pintorita.render(it.text, style=\"dark\")

```pintora
sequenceDiagram
  Alice-->>Bob: Shared Secret
```",
  pintorita.render("sequenceDiagram\n  Alice-->>Bob: Shared Secret", style: "light"),
)

#pagebreak()

== #context eval(linguify-raw("diagrams-data-heading"), mode: "markup")

#context eval(linguify-raw("diagrams-data-text"), mode: "markup")

#let two-color-theme = resolve-theme((palette: (black, blue)))

#diagram-preview(
  context eval(linguify-raw("diagrams-caption-multi-line"), mode: "markup"),
  "#import \"@preview/primaviz:0.7.0\": multi-line-chart, resolve-theme

#let two-color-theme = resolve-theme((palette: (black, blue)))

#multi-line-chart(
  (
    labels: (\"Q1\", \"Q2\", \"Q3\", \"Q4\"),
    series: (
      (name: \"Series A\", values: (10, 25, 18, 35)),
      (name: \"Series B\", values: (5, 15, 30, 20)),
    ),
  ),
  width: 300pt,
  height: 200pt,
  title: \"Multi Line Chart\",
  theme: two-color-theme,
)",
  multi-line-chart(
    (
      labels: ("Q1", "Q2", "Q3", "Q4"),
      series: (
        (name: "Series A", values: (10, 25, 18, 35)),
        (name: "Series B", values: (5, 15, 30, 20)),
      ),
    ),
    width: 300pt,
    height: 200pt,
    title: "Multi Line Chart",
    theme: two-color-theme,
  ),
)
