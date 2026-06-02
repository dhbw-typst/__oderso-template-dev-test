#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge, shapes.diamond
#import "@preview/pintorita:0.1.4"
#import "@preview/primaviz:0.7.0" : bar-chart, line-chart

#show raw.where(lang: "pintora"): it => pintorita.render(it.text, style: "light")


= Illustriate Workflows and plot data 😃
This section is completely optional and only serves for helping you. You can deactivate it in the 'main' file of your university.

== Visualize workflows
You can visualize workflows!

#diagram(
	node-stroke: 1pt,
	node((0,0), [Start], corner-radius: 2pt, extrude: (0, 3)),
	edge("-|>"),
	node((0,1), align(center)[
		Hey, wait,\ this flowchart\ is a trap!
	], shape: diamond),
	edge("d,r,u,l", "-|>", [Yes], label-pos: 0.1)
)


== Visualize graphs
You can draw some diagrams to illustriate workflows to explain the things you learned in your team! This is implemented using the #link("https://typst.app/universe/package/fletcher/", "Fletcher") library.

#let nodes = ("A", "B", "C", "D", "E", "F", "G")
#let edges = (
	(3, 2),
	(4, 1),
	(1, 4),
	(0, 4),
	(3, 0),
	(5, 6),
	(6, 5),
)

#diagram({
	for (i, n) in nodes.enumerate() {
		let θ = 90deg - i*360deg/nodes.len()
		node((θ, 18mm), n, stroke: 0.5pt, name: str(i))
	}
	for (from, to) in edges {
		let bend = if (to, from) in edges { 10deg } else { 0deg }
		// refer to nodes by label, e.g., <1>
		edge(label(str(from)), label(str(to)), "-|>", bend: bend)
	}
})

== Computer Science Diagrams
You can also draw some diagrams to plot graphs using pintorita, which uses the pintora notation for diagrams. You can find tutorials in the #link("https://pintorajs.vercel.app/docs/intro/", "reference")

```pintora
componentDiagram
  DataQuery -- [Component]
  [Component] ..> HTTP : use
```

```pintora
sequenceDiagram
  Alice-->>Bob: Definitely,\nMaybe
```

== Plot some data
#bar-chart(
  (
    labels: ("A", "B", "C", "D"),
    values: (25, 40, 30, 45),
  ),
  width: 300pt,
  height: 200pt,
  title: "My Data",
)

#line-chart(
 (
    labels: ("A", "B", "C", "D"),
    values: (25, 40, 30, 45),
  ),
  width: 300pt,
  height: 200pt,
  title: "My Data",
)