// 中文通用设置
#let skew(angle, vscale: 1, body) = {
  let (a, b, c, d) = (1, vscale * calc.tan(angle), 0, vscale)
  let E = (a + d) / 2
  let F = (a - d) / 2
  let G = (b + c) / 2
  let H = (c - b) / 2
  let Q = calc.sqrt(E * E + H * H)
  let R = calc.sqrt(F * F + G * G)
  let sx = Q + R
  let sy = Q - R
  let a1 = calc.atan2(F, G)
  let a2 = calc.atan2(E, H)
  let theta = (a2 - a1) / 2
  let phi = (a2 + a1) / 2
  
  set rotate(origin: bottom + center)
  set scale(origin: bottom + center)
  
  rotate(phi, scale(x: sx * 100%, y: sy * 100%, rotate(theta, body)))
}
#let fake-italic(body) = skew(-12deg, body)
#show emph: it => box(fake-italic(it))
#set text(font: ("IBM Plex Serif", "Source Han Serif SC"), lang: "zh", region: "cn")
#set underline(offset: .2em)
#show raw.where(block: true): block.with(
    width: 100%,
    fill: luma(240),
    inset: 5pt,
    radius: 4pt,
)


// 简单海报设置
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