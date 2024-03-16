#show heading: set text(font: "Linux Biolinum")
// 为链接加入下划线
#show link: underline
// 推荐的简历文本大小为“10pt”到“12pt”
#set text(size: 16pt)
// 设置页边距
#set page(margin: (x: 0.9cm, y: 1.3cm))
#set par(justify: true)
// 横线
#let chiline() = {v(-3pt); line(length: 100%); v(-5pt)}

= Alex Chi

skyzh\@cmu.edu | #link("https://github.com/skyzh")[github.com/skyzh] | #link("https://skyzh.dev")[skyzh.dev]

== Education
#chiline()

#link("https://typst.app/")[*#lorem(2)*] #h(1fr) 2333/23 -- 2333/23 \
#lorem(5) #h(1fr) #lorem(2) \
- #lorem(10)

*#lorem(2)* #h(1fr) 2333/23 -- 2333/23 \
#lorem(5) #h(1fr) #lorem(2) \
- #lorem(10)

== Work Experience
#chiline()

*#lorem(2)* #h(1fr) 2333/23 -- 2333/23 \
#lorem(5) #h(1fr) #lorem(2) \
- #lorem(20)
- #lorem(30)
- #lorem(40)

*#lorem(2)* #h(1fr) 2333/23 -- 2333/23 \
#lorem(5) #h(1fr) #lorem(2) \
- #lorem(20)
- #lorem(30)
- #lorem(40)