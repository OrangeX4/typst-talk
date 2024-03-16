#let conf(
  title: none,
  authors: (),
  abstract: [],
  doc,
) = {
  // 字体应为 11pt 的衬线字体
  set text(font: "Linux Libertine", 11pt)
  // 正文应两端对齐
  set par(justify: true)

  // 页面尺寸应为 US letter，编号在页脚的中心，
  // 每页的左上角应包含论文的标题
  set page(
    "us-letter",
    margin: auto,
    header: align(
      right + horizon,
      title
    ),
    numbering: "1",
  )
  // 一级章节标题应为 13pt，居中并以小写字母呈现
  show heading.where(
    level: 1
  ): it => block(
    align(center,
      text(
        13pt,
        weight: "regular",
        smallcaps(it.body),
      )
    ),
  )

  // 二级标题是短标题，斜体，与正文文本具有相同的大小
  show heading.where(
    level: 2
  ): it => box(
    text(
      11pt,
      weight: "regular",
      style: "italic",
      it.body + [.],
    )
  )

  // 标题应为 17pt 的粗体，居中对齐
  set align(center)
  text(17pt, title)

  // 添加作者列表，最多分为 3 列
  let count = calc.min(authors.len(), 3)
  grid(
    columns: (1fr,) * count,
    row-gutter: 24pt,
    ..authors.map(author => [
      #author.name \
      #author.affiliation \
      #link("mailto:" + author.email)
    ]),
  )

  // 单栏摘要，摘要应居中
  par(justify: false)[
    *Abstract* \
    #abstract
  ]

  // 两栏正文
  set align(left)
  columns(2, doc)
}



#show: doc => conf(
  title: [
    Towards Improved Modelling
  ],
  authors: (
    (
      name: "Theresa Tungsten",
      affiliation: "Artos Institute",
      email: "tung@artos.edu",
    ),
    (
      name: "Eugene Deklan",
      affiliation: "Honduras State",
      email: "e.deklan@hstate.hn",
    ),
  ),
  abstract: lorem(80),
  doc,
)

= Introduction
#lorem(90)

== Motivation
#lorem(140)

== Problem Statement
#lorem(50)

= Related Work
#lorem(200)