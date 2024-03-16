#import "@preview/touying:0.3.2": *
#import "@preview/a2c-nums:0.0.1": int-to-cn-ancient-num
#import "utils.typ": *

#let s = themes.university.register(
  aspect-ratio: "16-9",
  footer-a: self => self.info.subtitle,
  footer-c: self => h(1fr) + utils.info-date(self) + h(1fr) + states.slide-counter.display(int-to-cn-ancient-num) + h(1fr)
)
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
#set text(font: ("IBM Plex Serif", "Source Han Serif SC"), lang: "zh", region: "cn")
#set text(weight: "medium")
#set par(justify: true)
#show raw: set text(font: ("IBM Plex Mono", "Source Han Sans SC"))
#set raw(lang: "typ")
#show raw.where(block: false): box.with(
  fill: luma(240),
  inset: (x: .3em, y: 0em),
  outset: (x: 0em, y: .3em),
  radius: .2em,
)
#show raw.where(block: true): set par(justify: false)
#show strong: alert

#let (slide, title-slide, focus-slide) = utils.slides(s)
#show: slides


= 介绍

== 什么是 Typst？

- *介绍：*
  - #Typst 是为写作而诞生的基于标记的排版系统。#Typst 的目标是成为功能强大的排版工具，并且让用户可以愉快地使用它。#pause

- *简单来说：*
  - #Typst = #LaTeX 的排版能力 + #Markdown 的简洁语法 + 强大且现代的脚本语言

- *运行环境：*Web Wasm / CLI / LSP Language Server

- *编辑器：*Web App #linkto("https://typst.app/") / VS Code / Neovim / Emacs


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
  #set align(center + horizon)
  #show: rect.with(stroke: .5pt)
  #image("examples/conference.png")
]


