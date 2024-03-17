#import "@preview/touying:0.3.2": *
#import "@preview/a2c-nums:0.0.1": int-to-cn-ancient-num
#import "utils.typ": *

#let s = themes.university.register(
  aspect-ratio: "16-9",
  footer-a: self => self.info.subtitle,
  footer-c: self => h(1fr) + utils.info-date(self) + h(1fr) + states.slide-counter.display(int-to-cn-ancient-num) + h(1fr)
)
// 加入空页
#(s.methods.empty-slide = (self: none, ..args) => {
  self = utils.empty-page(self)
  (s.methods.slide)(self: self, ..args)
})
#let s = (s.methods.info)(
  self: s,
  title: [并不复杂的 Typst 讲座],
  subtitle: [Typst is Simple],
  author: [OrangeX4],
  date: datetime(year: 2024, month: 3, day: 17),
  institution: [南京大学],
)
#let s = (s.methods.datetime-format)(self: s, "[year] 年 [month] 月 [day] 日")
// hack for hiding list markers
#let s = (s.methods.update-cover)(self: s, body => box(scale(x: 0%, body)))
// handout mode
#let s = (s.methods.enable-handout-mode)(self: s)
#let (init, slides, touying-outline, alert) = utils.methods(s)
#show: init

// global styles
#set text(font: ("IBM Plex Serif", "Source Han Serif SC", "Noto Serif CJK SC"), lang: "zh", region: "cn")
#set text(weight: "medium")
#set par(justify: true)
#set raw(lang: "typ")
#set underline(stroke: .05em, offset: .25em)
#show raw: set text(font: ("IBM Plex Mono", "Source Han Sans SC", "Noto Sans CJK SC"))
#show raw.where(block: false): box.with(
  fill: luma(240),
  inset: (x: .3em, y: 0em),
  outset: (x: 0em, y: .3em),
  radius: .2em,
)
#show raw.where(block: true): set par(justify: false)
#show strong: alert

#let (slide, empty-slide, title-slide, focus-slide) = utils.slides(s)
#show: slides

= 介绍

== 什么是 Typst？

- *介绍：*
  - #Typst 是为写作而诞生的基于标记的排版系统。#Typst 的目标是成为功能强大的排版工具，并且让用户可以愉快地使用它。#pause

- *简单来说：*
  - #Typst = #LaTeX 的排版能力 + #Markdown 的简洁语法 + 强大且现代的脚本语言 #pause

- *运行环境：*Web Wasm / CLI / LSP Language Server

- *编辑器：*Web App #linkto("https://typst.app/") / VS Code / Neovim / Emacs


#empty-slide[
  #set align(center + horizon)
  #image("images/typst-introduction.png")
  #place(top + right, dx: -.5em, dy: .5em)[#linkto(icon: "mark-github", "https://github.com/typst/typst")]
]


== Typst 速览

#slide[
  #set text(.5em)
  
  ```typ
  #set page(width: 10cm, height: auto)
  #set heading(numbering: "1.")
  
  = Fibonacci sequence
  The Fibonacci sequence is defined through the recurrence relation $F_n = F_(n-1) + F_(n-2)$.
  It can also be expressed in _closed form:_

  $ F_n = round(1 / sqrt(5) phi.alt^n)，quad phi.alt = (1 + sqrt(5)) / 2 $

  #let count = 8
  #let nums = range(1, count + 1)
  #let fib(n) = (
    if n <= 2 { 1 }
    else { fib(n - 1) + fib(n - 2) }
  )

  The first #count numbers of the sequence are:

  #align(center, table(
    columns: count,
    ..nums.map(n => $F_#n$),
    ..nums.map(n => str(fib(n))),
  ))
  ```

  来源：Typst 官方 Repo #linkto("https://github.com/typst/typst")
][
  #set align(center + horizon)

  #image("examples/fibonacci.png")
]


== Typst 优势

- *语法简洁：*上手难度跟 #Markdown 相当，文本源码可阅读性高。#pause

- *编译速度快：*
  - Typst 使用 Rust 语言编写，即 `typ(esetting+ru)st`。
  - 增量编译时间一般维持在*数毫秒*到*数十毫秒*。#pause

- *环境搭建简单：*不像 #LaTeX 安装起来困难重重，#Typst 原生支持中日韩等非拉丁语言，官方 Web App 和本地 VS Code 均能*开箱即用*。#pause

- *现代脚本语言：*
  - 变量、函数、闭包与错误检查 + 函数式编程的纯函数理念
  - 可嵌套的 `[标记模式]`、`{脚本模式}` 与 `$数学模式$` #strike[不就是 JSX 嘛]
  - 统一的包管理，支持导入 WASM 插件和按需自动安装第三方包


== Typst 对比其他排版系统

#slide[
  #set text(.7em)
  #let 难 = text(fill: rgb("#aa0000"), weight: "bold", "难")
  #let 易 = text(fill: rgb("#007700"), weight: "bold", "易")
  #let 多 = text(fill: rgb("#aa0000"), weight: "bold", "多")
  #let 少 = text(fill: rgb("#007700"), weight: "bold", "少")
  #let 慢 = text(fill: rgb("#aa0000"), weight: "bold", "慢")
  #let 快 = text(fill: rgb("#007700"), weight: "bold", "快")
  #let 弱 = text(fill: rgb("#aa0000"), weight: "bold", "弱")
  #let 强 = text(fill: rgb("#007700"), weight: "bold", "强")
  #let 较强 = text(fill: rgb("#007700"), weight: "bold", "较强")
  #let 中 = text(fill: blue, weight: "bold", "中等")
  #let cell(top, bottom) = stack(spacing: .2em, top, block(height: 2em, text(size: .7em, bottom)))

  #v(1em)
  #figure(table(
    columns: 8,
    stroke: none,
    align: center + horizon,
    inset: .5em,
    table.hline(stroke: 2pt),
    [排版系统], [安装难度], [语法难度], [编译速度], [排版能力], [模板能力], [编程能力], [方言数量],
    table.hline(stroke: 1pt),
    [LaTeX], cell[#难][选项多 + 体积大 + 流程复杂], cell[#难][语法繁琐 + 嵌套多 + 难调试], cell[#慢][宏语言编译\ 速度极慢], cell[#强][拥有最多的\ 历史积累], cell[#强][拥有众多的\ 模板和开发者], cell[#中][图灵完备\ 但只是宏语言], cell[#中][众多格式、\ 引擎和发行版],
    [#Markdown], cell[#易][大多编辑器\ 默认支持], cell[#易][入门语法十分简单], cell[#快][语法简单\ 编译速度较快], cell[#弱][基于 HTML排版能力弱], cell[#中][语法简单\ 易于更换模板], cell[#弱][图灵不完备 \ 需要外部脚本], cell[#多][方言众多\ 且难以统一],
    [Word], cell[#易][默认已安装], cell[#易][所见即所得], cell[#中][能实时编辑\ 大文件会卡顿], cell[#强][大公司开发\ 通用排版软件], cell[#弱][二进制格式\ 难以自动化], cell[#弱][编程能力极弱], cell[#少][统一的标准和文件格式],
    [#Typst], cell[#易][安装简单\ 开箱即用], cell[#中][入门语法简单\ 进阶使用略难], cell[#快][增量编译渲染\ 速度最快], cell[#较强][已满足日常\ 排版需求], cell[#强][制作和使用\ 模板都较简单], cell[#强][图灵完备\ 现代编程语言], cell[#少][统一的语法\ 统一的编译器],
    table.hline(stroke: 2pt),
  ))
]

#slide[
  #set align(center + horizon)
  #v(-1.5em)
  #image("images/meme.png")
  #v(-1.5em)
  From reddit r/LaTeX #linkto("https://www.reddit.com/r/LaTeX/comments/z2ifki/latex_vs_word_vs_pandoc_markdown/") and modfied by OrangeX4
]


= 安装

== 云端使用

- 官方提供了 Web App，可以直接在浏览器中使用 #linkto("https://typst.app/") #pause

- *优点：*
  - 即开即用，无需安装。
  - 类似于 #LaTeX 的 Overleaf，可以直接编辑、编译、分享文档。
  - 拥有*「多人协作」*支持，可以实时共同编辑。#pause

- *缺点：*
  - 中文字体较少，经常需要手动上传字体文件，但有上传大小限制。
  - 缺少版本控制，目前无法与 GitHub 等代码托管平台对接。


== 本地使用（推荐）

- *VS Code 方案（推荐）*
  - 在插件市场安装「Tinymist Typst」和「Typst Preview」插件。
  - 新建一个 `.typ` 文件，然后按下 #keydown[Ctrl] + #keydown[K] #keydown[V] 即可实时预览。
  - *不再需要其他配置*，例如我们并不需要命令行安装 Typst CLI。#pause

- *Neovim / Emacs 方案*
  - 可以配置相应的 LSP 插件和 Preview 插件。#pause

- *CLI 方案：* `typst compile --root <DIR> <INPUT_FILE>`
  - Windows: `winget install --id Typst.Typst`
  - macOS: `brew install typst`
  - Linux：查看 Typst on Repology #linkto("https://repology.org/project/typst/versions")


= 快速入门

== Hello World

#slide[
  #set text(.5em)

  ````typ
  #set page(width: 20em, height: auto)
  #show heading.where(level: 1): set align(center)

  #show "Typst": set text(fill: blue, weight: "bold")
  #show "LaTeX": set text(fill: red, weight: "bold")
  #show "Markdown": set text(fill: purple, weight: "bold")

  = Typst 讲座

  Typst 是为 *学术写作* 而生的基于 _标记_ 的排版系统。

  Typst = LaTeX 的排版能力 + Markdown 的简洁语法 + 现代的脚本语言

  #underline[本讲座]包括以下内容：

  + 快速入门 Typst
  + Typst 编写各类模板
    - 笔记、论文、简历和 Slides
  + Typst 高级特性
    - 脚本、样式和包管理
  + Typst 周边生态开发体验
    - Pinit、MiTeX、Touying 和 VS Code 插件

  ```py
  print('Hello Typst!')
  ```
  ````
][
  #set align(center + horizon)
  #v(-1em)
  #image("examples/poster.png")
]


== 标记只是语法糖

#slide[
  ````typ
  = 一级标题

  == 二级标题

  简单的段落，可以*加粗*和_强调_。

  - 无序列表
  + 有序列表
  / 术语: 术语列表 

  ```py
  print('Hello Typst!')
  ```
  ````
][
  ````typ
  #heading(level: 1, [一级标题])

  #heading(level: 2, [二级标题])

  简单的段落，可以#strong[加粗]和#emph[强调]。

  #list.item[无序列表]
  #enum.item[有序列表]
  #terms.item[术语][术语列表]

  #raw(lang: "py", block: true, "print('Hello Typst!')")
  ````
]


== 核心概念

- *Simplicity through Consistency*
  - 类似 #Markdown 的特殊标记语法，实现*「内容与格式分离」*。
  - `= 一级标题` 只是 `#heading[一级标题]` 的*语法糖*。#pause
- *标记模式和脚本模式*
  - 标记模式下，使用井号 `#` 进入脚本模式，如 `#strong[加粗]`。
    - 脚本模式下不需要额外井号，例如 `#heading(strong([加粗]))`
    - 大段脚本代码可以使用花括号 `{}`，例如 `#{1 + 1}`。#pause
  - 脚本模式下，使用方括号 `[]` 进入标记模式，称为*内容块*。
    - #Typst 是强类型语言，有常见的数据类型，如 `int` 和 `str`。
    - 内容块 `[]` 类型 `content` 是 #Typst 的核心类型，可嵌套使用。
    - `#fn(..)[XXX][YYY]` 是 `#fn(.., [XXX], [YYY])` 的*语法糖*。


== Set/Show Rules

- *Set 规则可以设置样式，即「为函数设置参数默认值」的能力。*
  - 例如 `#set heading(numbering: "1.")` 用于设置标题的编号。
  - 使得 `#heading[标题]` 变为 `#heading(numbering: "1.", [标题])`。#pause

- *Show 规则用于全局替换，即在语法树上进行「宏编程」的能力。*
  - 例如 `#show "LaTeX": "Typst"` 将单词 `LaTeX` 替换为 `Typst`。
  - 例如让一级标题居中，可以用*「箭头函数」*：
    - #block(
        width: 100%,
        fill: luma(240),
        inset: (x: .3em, y: 0em),
        outset: (x: 0em, y: .3em),
        radius: .2em,
        ```typ
        #show heading.where(level: 1): body => {
          set align(center)
          body
        }
        ```
      )
    - 化简为 `#show heading.where(level: 1): set align(center)`


== 数学公式

- `$x$` 是行内公式，`$ x^2 + y^2 = 1 $ <circle>` 是行间公式。#pause

- 与 #LaTeX 的差异：
  - `(x + 1) / x >= 1 => 1/x >= 0`
  - #raw(lang: "latex", `\frac{x + 1}{x} \ge 1 \Rightarrow \frac{1}{x} \ge 0`.text) #pause

- *报告，我想用 LaTeX 语法：*#linkto("https://github.com/mitex-rs/mitex")

```typ
#import "@preview/mitex:0.2.2": *

Write inline equations like #mi("x") or #mi[y].
#mitex(`
  \frac{x + 1}{x} \ge 1 \Rightarrow \frac{1}{x} \ge 0
`)
```

= 制作模板

== 制作论文模板

现在，我们想要为一个会议制作一个模板，以下是*需求规范*：

+ *字体*应为 11pt 的衬线字体；
+ *标题*应为 17pt 的粗体，居中对齐；
+ 论文包含*单栏摘要*和*两栏正文*；
+ *摘要*应居中；
+ *正文*应两端对齐；
+ *一级章节标题*应为 13pt，居中并以小写字母呈现；
+ *二级标题*是短标题，斜体，与正文文本具有相同的大小；
+ 最后，*页面尺寸*应为 US letter，编号在页脚的中心，每页的左上角应包含论文的标题。


#slide[
  #set text(.65em)
  #show: columns.with(2)
  #show raw.where(block: true): block.with(width: 100%, fill: luma(240), outset: .7em, radius: .2em)

  ```typ
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
  ```

  来源：Typst 官方文档 #linkto("https://typst.app/docs/tutorial/making-a-template/")
]

#slide[
  #set text(.5em)
  #v(-1em)
  #block(breakable: false)[
    ```typ
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
    ```
  ]
][
  #set align(right + horizon)
  #show: rect.with(stroke: .5pt)
  #image("examples/conference.png")
]


== 制作简历模板

#slide(composer: utils.side-by-side.with(columns: (1fr, auto), gutter: 1em))[
  - Word / HTML 简历模板？
    - *不够美观* #pause

  - #LaTeX 简历模板？
    - *环境配置复杂*
    - *自主定制困难* #pause
  
  - #Typst 简历模板？
    - *绝对优势领域*
    - *Chinese-Resume-in-Typst* #linkto("https://github.com/OrangeX4/Chinese-Resume-in-Typst")

  #meanwhile
][
  #set align(center + horizon)
  #show: rect.with(stroke: .5pt)
  #image("images/resume.png")
]

#slide(composer: utils.side-by-side.with(columns: (1fr, auto), gutter: 1em))[
  #set text(.5em)
  #show: columns.with(2)

  #raw(lang: "typ", block: true, read("examples/chicv.typ"))

  #set text(1.5em)
  来源：chicv #linkto("https://github.com/skyzh/chicv")
][
  #set align(center + horizon)
  #show: rect.with(stroke: .5pt)
  #image("examples/chicv.png")
]


== 南京大学学位论文

#slide(composer: utils.side-by-side.with(columns: (1fr, auto), gutter: 1em))[
  - *nju-thesis-typst* #linkto("https://github.com/nju-lug/nju-thesis-typst")
    - 总共开发时间：*一周*
    - 语法简洁、编译迅速
    - 通过*「闭包」*封装保存全局配置
    - *本科生模板 + 研究生模板*

  #set text(.65em)
  #show: columns.with(3)
  #show raw.where(block: true): block.with(width: 100%, fill: luma(240), outset: .5em, radius: .2em)

  ```typ
  // 文稿设置
  #show: doc
  // 封面页
  #cover()
  // 声明页
  #decl-page()
  // 前言
  #show: preface
  // 中文摘要
  #abstract(
    keywords: ("我", "就是", "测试用", "关键词")
  )[
    中文摘要
  ]
  // 目录
  #outline-page()
  // 插图目录
  #list-of-figures()
  // 表格目录
  #list-of-tables()
  // 正文
  #show: mainmatter

  = 基本功能

  == 脚注

  我们可以添加一个脚注。#footnote[脚注内容]
  ```
][
  #set align(center + horizon)
  #show: rect.with(stroke: .5pt)
  #image("images/nju-thesis.png")
]


= 制作 Slides

== Touying

- #Touying 是为 Typst 开发的 Slides 包，类似于 #LaTeX 的 Beamer。
  - 取自中文「*投影*」，而 Beamer 是德语「*投影仪*」的意思。#linkto("https://touying-typ.github.io/touying/zh/") #pause

- *基本框架：*
  - 全局单例对象 `s` 保存标题、作者和日期等信息。
  - 使用 `= 节`、`== 小节` 和 `=== 标题` 划分 Slides 结构。
  - 使用 `#slide[..]` 块来实现更优雅且精细的控制。 #pause

- *使用主题：*`#let s = themes.university.register()` #pause

- *动画：*
  - `#pause` 和 `#meanwhile` 标记。
  - `#only("2-")[]`、`#uncover("2-")[]` 和 `#alternatives[][]`。


#slide(composer: utils.side-by-side.with(columns: (1fr, auto), gutter: 1em))[
  #set text(.5em)
  #show: columns.with(2, gutter: 3em)

  ```typ
  #import "@preview/touying:0.3.2": *

  #let s = themes.aqua.register(aspect-ratio: "16-9", lang: "en")
  #let s = (s.methods.info)(
    self: s,
    title: [Title],
    subtitle: [Subtitle],
    author: [Authors],
    date: datetime.today(),
    institution: [Institution],
  )
  #let (init, slides, touying-outline, alert) = utils.methods(s)
  #show: init

  #show strong: alert

  #let (slide, title-slide, outline-slide, focus-slide) = utils.slides(s)
  #show: slides

  = The Section

  == Slide Title

  #slide[
    #lorem(40)
  ]

  #focus-slide[
    Another variant with primary color in background...
  ]

  == Summary

  #align(center + horizon)[
    #set text(size: 3em, weight: "bold", s.colors.primary)
    THANKS FOR ALL
  ]
  ```

  #set text(1.2em)

  来源：Touying 文档 #linkto("https://touying-typ.github.io/touying/zh/docs/themes/aqua")
][
  #set align(center + horizon)
  #show: pad.with(right: -1.5em)
  #image(height: 90%, "examples/touying.png")
]


== Pinit

- *Pinit* 包提供基于*「图钉」（pin）*进行相对定位的能力。

- 可以方便地实现*「箭头指示」*与*「解释说明」*的效果。

- *一个简单示例：*

#grid(columns: 2, gutter: 1em)[
  #set text(.85em)
  #show raw.where(block: true): block.with(width: 100%, fill: luma(240), outset: .7em, radius: .2em)

  ```typ
  #import "@preview/pinit:0.1.3": *
  #set text(size: 24pt)

  A simple #pin(1)highlighted text#pin(2).

  #pinit-highlight(1, 2)

  #pinit-point-from(2)[It is simple.]
  ```
][
  #show: align.with(center + horizon)
  #show: block.with(breakable: false)
  #v(-2em)
  #image("images/pinit-1.png")
  #image("images/pinit-2.png")
]

#slide[
  #set align(center + horizon)
  #image(height: 115%, "images/pinit-3.png")
  #set text(.8em)
  #place(top + left, dy: -.5em)[使用 #Typst 和 *Pinit* 复刻算法课的 Slides，样式来源于 #linkto("https://chaodong.me/")]
  #place(top + right, dx: 1.5em, dy: -.5em)[*示例代码* #linkto(icon: "mark-github", "https://touying-typ.github.io/touying/zh/docs/integration/pinit")]
]


== Touying 对比其他 Slides 方案

#slide[
  #set text(.7em)
  #let 难 = text(fill: rgb("#aa0000"), weight: "bold", "难")
  #let 易 = text(fill: rgb("#007700"), weight: "bold", "易")
  #let 慢 = text(fill: rgb("#aa0000"), weight: "bold", "慢")
  #let 快 = text(fill: rgb("#007700"), weight: "bold", "快")
  #let 弱 = text(fill: rgb("#aa0000"), weight: "bold", "弱")
  #let 强 = text(fill: rgb("#007700"), weight: "bold", "强")
  #let 中 = text(fill: blue, weight: "bold", "中等")
  #let cell(top, bottom) = stack(spacing: .2em, top, block(height: 2em, text(size: .7em, bottom)))

  #v(1em)
  #figure(table(
    columns: 8,
    stroke: none,
    align: center + horizon,
    inset: .5em,
    table.hline(stroke: 2pt),
    [方案], [语法难度], [编译速度], [排版能力], [模板能力], [编程能力], [动画效果], [代码公式],
    table.hline(stroke: 1pt),
    [*PowerPoint*], cell[#易][所见即所得], cell[#快][实时编辑], cell[#强][大公司开发\ 通用软件], cell[#强][模板数量最多\ 容易制作模板], cell[#弱][编程能力极弱\ 难以显示进度], cell[#强][动画效果多\ 但用起来复杂], cell[#难][难以插入代码和公式 #strike[贴图片]],
    [Beamer], cell[#难][语法繁琐 + 嵌套多 + 难调试], cell[#慢][宏语言编译\ 速度极慢], cell[#弱][使用模板后\ 排版难以修改], cell[#中][拥有较多模板\ 开发模板较难], cell[#中][图灵完备\ 但只是宏语言], cell[#中][简单动画方便\ 无过渡动画], cell[#易][基本默认支持],
    [#Markdown], cell[#易][入门语法十分简单], cell[#快][语法简单\ 编译速度较快], cell[#弱][语法限制\ 排版能力弱], cell[#弱][难以制作模板\ 只有内置模板], cell[#弱][图灵不完备\ 需要外部脚本], cell[#中][动画效果全看提供了什么], cell[#易][基本默认支持],
    [#Touying], cell[#易][语法简单\ 使用方便], cell[#快][增量编译渲染\ 速度最快], cell[#中][满足日常学术\ Slides 需求], cell[#强][制作和使用\ 模板都较简单], cell[#强][图灵完备\ 现代编程语言], cell[#中][简单动画方便\ 无过渡动画], cell[#易][默认支持\ MiTeX 包],
    table.hline(stroke: 2pt),
  ))
]


== 一些常见的 Slides 问题

- *能不能插入 LaTeX 公式？*
  - 可以，只需要使用 MiTeX 包。#linkto("https://github.com/mitex-rs/mitex") #pause

- *能不能够加入 GIF 动图或者视频？*
  - GIF 动图可以，但是要使用 *Typst Preview* 插件的 Slide 模式。
    - 这是因为 *Typst Preview* 插件是*基于 SVG* 的。 #pause

- *插入图片方便吗？*
  - 方便，比如本讲座的 Slides 就有一堆图片。
    - 你可以使用 *grid 布局*。
    - 也可以使用 *Pinit* 包的 *「图钉」* 功能。


= 包管理

== Typst 包管理

- #Typst 已经有了一个简单但强大的包管理方案。
  - 包可以通过 `#import "@preview/pkg:1.0.0"` 的方式导入。
    - *按需自动下载和自动导入第三方包。*
      - 因此我们不需要像 *TexLive* 一样全量安装吃满硬盘。
    - 使用 `@preview` 命名空间。
    - 需要写上版本号，以保证文档源代码可复现性。
  - 包目前存放于统一的 GitHub Repo 中。#linkto("https://github.com/typst/packages")
  - 包可以是 *Package* 和 *Template*。
  - 包也可以存放在本地，并且可以全局导入。

- #Typst 有一个 *Typst Universe*，可以浏览已有包。#linkto("https://typst.app/universe")


== WASM 插件

- *WASM* 是一种基于 *Web* 的*跨平台*汇编语言表示。

- #Typst 有 *WASM Plugin* 功能，也就是说：
  - #Typst 的包并不一定要是纯 Typst 代码。
  - #Typst 的包基本上可以用任意语言编写，例如 *Rust* 和 *JS*。#pause

- 一些 WASM 包的例子：
  - *jogs：*封装 *QuickJS*，在 #Typst 中运行 *JavaScript* 代码。
  - *pyrunner：*在 #Typst 中运行 *Python* 代码。
  - *tiaoma：*封装 *Zint*，生成条码和二维码。
  - *diagraph：*在 #Typst 中使用 *Graphviz*。



= Typst 周边生态开发体验

== 我参与开发的项目

- *Touying：*#Touying 是为 Typst 开发的 Slides 包。#linkto("https://github.com/touying-typ/touying")
- *MiTeX：*一个 Rust 写的*转译器*，用于快速地渲染 *LaTeX 公式*。#linkto("https://github.com/mitex-rs/mitex")
- *Pinit：*提供基于*「图钉」（pin）*进行相对定位的能力。#linkto("https://github.com/OrangeX4/typst-pinit")
- *nju-thesis-typst：*基于 #Typst 的南京大学学位论文。#linkto("https://github.com/nju-lug/nju-thesis-typst")
- *Chinese-Resume-in-Typst：*美观的 #Typst 中文简历。#linkto("https://github.com/OrangeX4/Chinese-Resume-in-Typst")
- *Tablem：*在 #Typst 中支持 #Markdown 形式的表格。#linkto("https://github.com/OrangeX4/typst-tablem")
- *Typst Sympy Calculator：*在 *VS Code* 中做科学符号运算。#linkto("https://github.com/OrangeX4/vscode-typst-sympy-calculator")
- *Typst Sync：*云端同步本地包的 *VS Code* 插件。#linkto("https://github.com/OrangeX4/vscode-typst-sync")


== 开发体验

- #Typst 生态现状：#strike[*勃勃生机，万物竞发*] #pause

- 语法简单，强类型语言，易于开发和调试。
  - 写起 DSL 也很方便，比如 *MiTeX*、#Touying 和 *Tablem*。#pause

- 还有很多功能可以开发，#strike[例如把 #LaTeX 的宏包全都复刻一遍]。#pause

- *一些例子：*
  - 国人开发的 *Tinymist* 插件和 *Typst Preview* 插件。
  - *Pandoc* 支持和 *Quarto* 支持。
  - 在网页上运行 #Typst：typst.ts 和 typst-book。#linkto("https://myriad-dreamin.github.io/typst-book/")
  - 在 *VS Code* 的编辑器里显示数学符号的 *Typst Math* 插件。


= 最后

== 参考与鸣谢

#slide[
  #set enum(numbering: "[1]")

  + #Typst 官方文档 #linkto("https://typst.app/docs")
 
  + *现代 #LaTeX 入门讲座* #linkto("https://github.com/stone-zeng/latex-talk")

  + *#Typst 中文教程* #linkto("https://github.com/typst-doc-cn/tutorial")

  + *Typst 非官方中文交流群* 793548390

  + *南京大学 Typst 交流群* 943622984
]


== 关于

#slide[
  *本幻灯片：*https://github.com/OrangeX4/typst-talk
  
  *最后更新：*#datetime.today().display()

  *License：* CC BY-SA 4.0

  *作者：*OrangeX4 #linkto("")
]

#focus-slide[
  #set align(center + horizon)
  \#thanks
]