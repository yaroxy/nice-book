#import "template.typ": nice-doc, book-color
#import "template.typ": definition, theorem, lemma, corollary, postulate, proposition


#let yaroxy = (
  (
    name: [Sun Yafeng],
    affiliation: [University of Science and Technology of China],
    email: [yaroxy\@mail.ustc.edu.cn],
    link: [#link("https://github.com/Yaroxy")[yaroxy\@github]]
  )
)


#show: nice-doc.with(
  title: [Mixture of Experts],
  subtitle: [A Survey],
  authors: (yaroxy,),
  cover-image: "image/cover.jpg",
  preface: include "chapters/preface.typ",
  reference: "ref.bib"
)

= Hello

#lorem(100)

== HELLO

$
  f(x) = sin x
$

$
  integral_E f dif x = sum_(i=1)^k a_i m( A_i ) pi alpha beta sigma gamma nu epsilon.alt epsilon . integral.cont_a^b limits(integral.cont)_a^b product_(i=1)^n
$

$ 
integral_0^1 D(x) dif x = integral_0^1 chi_Q_0 (x) dif x = m(Q_0) =0 
$

== HELLO

$
  f(x) = sin x
$



= 模板介绍
== 模板说明
本模板旨在用 Typst 对 #link("https://github.com/ElegantLaTeX/ElegantBook")[ElegantBook] 进行复刻.

== 模板下载
模板发布在 #link("https://github.com/a31474/quite-elegant-typ")[https://github.com/a31474/quite-elegant-typ]

== 模板使用
下载后, 把模板放在本地文件夹下. 然后导入 `lib.typ` 即可使用

```
#import "lib.typ": *

#show: conf
#default-cover()
#default-outline()
```

注意把 `lib.typ` 改成其对应的本地路径

其中 `#default-cover()` 和 `#default-outline()` 分别添加了封面和目录. 若不需要, 可以不用加上.

#definition[Hello][
  Hello
]


= 模板设置说明

== 颜色主题

=== 颜色主题设置 <颜色>


调用其他颜色主题的方法为

```
#show: it => conf(it, color-theme: "green")
```

或

```
#show: conf.with(color-theme: "green")
```

也可以自定义颜色主题, 如
```
#show: it => conf(
  it,
  color-theme: (
    structure: rgb(255, 0, 0),
    main: rgb(0, 255, 0),
    second: rgb(0, 0, 255),
    third: rgb(255, 255, 0),
  ),
)
```
需传入一字典, 字典的 keys 必须分别为 structure, main, second, third. 各自的 value 为对应颜色.

=== 具体配置
下表为内置颜色主题的具体配置
#figure(
  table(
    columns: 7,
    stroke: none,
    align: horizon,
    table.hline(),
    table.header(
      [],
      text(fill: book-color.green.structure)[green],
      text(fill: book-color.cyan.structure)[cyan],
      text(fill: book-color.blue.structure)[blue],
      text(fill: book-color.gray.structure)[gray],
      [black],
      [主要使用的环境],
    ),
    table.hline(stroke: 0.5pt),
    [structure],
    square(fill: book-color.green.structure), square(fill: book-color.cyan.structure),
    square(fill: book-color.blue.structure), square(fill: book-color.gray.structure),
    square(fill: black),
    [chapter section subsection],
    [main],
    square(fill: book-color.green.main), square(fill: book-color.cyan.main),
    square(fill: book-color.blue.main), square(fill: book-color.gray.main),
    square(fill: black),
    [definition exercise problem],
    [second],
    square(fill: book-color.green.second), square(fill: book-color.cyan.second),
    square(fill: book-color.blue.second), square(fill: book-color.gray.second),
    square(fill: black),
    [theorem lemma corollary],
    [third],
    square(fill: book-color.green.third), square(fill: book-color.cyan.third),
    square(fill: book-color.blue.third), square(fill: book-color.gray.third),
    square(fill: black),
    [proposition],
    table.hline(stroke: 0.5pt),
  ),
  caption: []
)

#definition[Hello][
  Hello
]

#definition[Hello][
  Hello
]

#definition[Hello][
  Hello
]

#definition[可积性][
  设 $f(x)= limits(sum)_(i=1)^(k) a_i  chi_(A_i) (x)$ 是 $E$ 上的非负简单函数，中文其中 ${A_1,A_2,dots,A_k}$ 是 $E$ 上的一个可测分割，$a_1,a_2, dots,a_k$ 是非负实数。定义 $f$ 在 $E$ 上的积分为 $ integral_(a)^b f(x)$

  $
    integral_E f dif x = sum_(i=1)^k a_i m( A_i ) pi alpha beta sigma gamma nu epsilon.alt epsilon . integral.cont_a^b limits(integral.cont)_a^b product_(i=1)^n
  $
  一般情况下 $0 lt.eq integral_E f dif x lt.eq infinity $。若 $integral_E f dif x < infinity $，则称 $f$ 在 $E$ 上可积。
]