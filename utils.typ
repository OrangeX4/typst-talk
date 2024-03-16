#import "@preview/octique:0.1.0": *

// Logos
#let typst-color = rgb("#239DAD")

#let Typst = text(fill: typst-color, weight: "bold", "Typst")

#let Markdown = text(fill: rgb(purple), weight: "bold", "Markdown")

#let TeX = {
  set text(font: "New Computer Modern", weight: "regular")
  box(width: 1.7em, {
    [T]
    place(top, dx: 0.56em, dy: 0.22em)[E]
    place(top, dx: 1.1em)[X]
  })
}

#let LaTeX = {
  set text(font: "New Computer Modern", weight: "regular")
  box(width: 2.55em, {
    [L]
    place(top, dx: 0.3em, text(size: 0.7em)[A])
    place(top, dx: 0.7em)[#TeX]
  })
}


// Functions

#let linkto(url) = link(url, box(baseline: 30%, move(dy: -.15em, octique-inline("link"))))

#let keydown(key) = box(stroke: 2pt, inset: .2em, radius: .2em, baseline: .2em, key)