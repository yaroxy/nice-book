// #import "template.typ": nice-doc
// #import "template.typ": definition, theorem, lemma, corollary, postulate, proposition


// Font
#let font-size = (
  ChuHao: 42pt,
  XiaoChu: 36pt,
  YiHao: 26pt,
  XiaoYi: 24pt,
  ErHao: 22pt,
  XiaoEr: 18pt,
  SanHao: 16pt,
  XiaoSan: 15pt,
  SiHao: 14pt,
  ZhongSi: 13pt,
  XiaoSi: 12pt,
  WuHao: 10.5pt,
  XiaoWu: 9pt,
  LiuHao: 7.5pt,
  XiaoLiu: 6.5pt,
  QiHao: 5.5pt, 
  XiaoQi: 5pt
)

#let font-style = (
  Song: ("Times New Roman", "SimSun"),
  Hei: ("Calibri", "SimHei"),
  Mono: ("Consolas", "SimSun"),
  Kai: ("Times New Roman", "KaiTi"),
  FangSong: ("Times New Roman", "KaiTi"),
  Math: ("New Computer Modern Math", "KaiTi"),
  Book: (
    (name: "Cambria", covers: "latin-in-cjk"),
    "Noto Serif CJK SC"
  )
)

// Color
#let book-color = (
  blue: (
    structure: rgb(60, 113, 183),
    main: rgb(0, 166, 82),
    second: rgb(255, 134, 24),
    third: rgb(0, 174, 247),
  ),
  green: (
    structure: rgb(0, 120, 2),
    main: rgb(0, 120, 2),
    second: rgb(230, 90, 7),
    third: rgb(0, 160, 152),
  ),
  cyan: (
    structure: rgb(31, 186, 190),
    main: rgb(59, 180, 5),
    second: rgb(175, 153, 8),
    third: rgb(244, 105, 102),
  ),
  gray: (
    structure: rgb(150, 150, 150),
    main: rgb(150, 150, 150),
    second: rgb(150, 150, 150),
    third: rgb(150, 150, 150),
  ),
  black: (
    structure: rgb(0, 0, 0),
    main: rgb(0, 0, 0),
    second: rgb(0, 0, 0),
    third: rgb(0, 0, 0),
  ),
)

#let color-select(color-theme) = {
  if type(color-theme) == str {
    assert(
      book-color.keys().any(it => it == color-theme),
      message: "Please enter one of \"blue\", \"green\", \"cyan\", \"gray\", or \"black\" as the color theme. "
        + "\""
        + color-theme
        + "\""
        + " is not among them.",
    )
    return book-color.at(color-theme)
  } else if type(color-theme) == dictionary {
    assert(
      color-theme.keys() == book-color.blue.keys(),
      message: "Custom color theme failed. The dictionary keys must be exactly: structure, main, second, third.",
    )
    assert(
      color-theme.values().all(it => type(it) == color),
      message: "Custom color theme failed. The dictionary values must all be of type color.",
    )
    color-theme.keys()
  } else {
    assert(false, message: "Please enter a color theme name or provide a custom color theme.")
  }
}

#let block-color = (
  important: (
    title: rgb("#01bebb"),
    body: rgb("#e5f8f8")
  ),
  summary: (
    title: rgb("#c357ee"),
    body: rgb("#ebdef0")
  ),
  question: (
    title: rgb("#ee861f"),
    body: rgb("#fdf1e5")
  ),
  error: (
    title: rgb("#e93147"),
    body: rgb("#fdeaec")
  )
)


/**
 * numbly
*/
#let numbly(..arr, default: "1.") = (..nums) => {
  let arr = arr.pos()
  nums = nums.pos()
  if nums.len() > arr.len() {
    if default == none {
      return none
    }
    if type(default) == function {
      return default(..nums)
    }
    return numbering(default, ..nums)
  }
  let format = arr.at(nums.len() - 1)
  if format == none {
    return none
  }
  if type(format) == function {
    return format(..nums)
  }
  format.replace(
    regex("\{(\d)(:(.+?))?\}"),
    m => {
      let (a, b, c) = m.captures
      if b != none {
        numbering(c, nums.at(int(a) - 1))
      } else {
        str(nums.at(int(a) - 1))
      }
    },
  )
}


// math block
#let math-block-class = (
  "Definition",
  "Theorem",
  "Lemma",
  "Corollary",
  "Axiom",
  "Postulate",
  "Proposition"
)
#let math-block-numbering-format(kind) = context {
  let heading-num = counter(heading).get().first()
  let block-num = counter(kind).get().first()

  numbering("1.1", heading-num, block-num)
}

#let math-block-frame(
  main-color, 
  title, 
  it
) = {
  v(-0.5em)
  stack(
    dir: btt,
    rect(
      width: 100%,
      radius: 3pt,
      inset: 1.2em,
      stroke: main-color,
      fill: main-color.lighten(90%),
      {
        it
      },
    ),
    move(
      dx: 2em,
      dy: 0.8em,
      block(
        stroke: none,
        fill: main-color.lighten(10%),
        inset: 0.3em,
        outset: (x: 0.8em),
        text(fill: white, weight: "bold", bottom-edge: "descender")[#title],
      ),
    ),
  )
}

#let math-block-api(
  main-color: rgb(0, 0, 0), 
  kind: "Math",
  number: true, 
  title: [],
  it
) = {
  if number {counter(kind).step()}

  let name = emph(kind)+ " " + if number {math-block-numbering-format(kind)} + " " + title
  
  math-block-frame(main-color, name, it)
}

#let definition(number: true, title, it) = math-block-api(
  main-color: color-select("blue").main,
  kind: "Definition",
  number: number,
  title: title,
  it
)
#let theorem(number: true, title, it) = math-block-api(
  main-color: color-themes.second,
  kind: "Theorem",
  number: number,
  title,
  it,
)
#let lemma(number: true, title, it) = math-block-api(
  main-color: color-themes.second,
  kind: "Lemma",
  number: number,
  title,
  it,
)
#let corollary(number: true, title, it) = math-block-api(
  main-color: color-themes.second,
  kind: "Corollary",
  number: number,
  title,
  it,
)
#let axiom(number: true, title, it) = math-block-api(
  main-color: color-themes.second,
  kind: "Axiom",
  number: number,
  title,
  it,
)
#let postulate(number: true, title, it) = math-block-api(
  main-color: color-themes.second,
  kind: "Postulate",
  number: number,
  title,
  it,
)
#let proposition(number: true, title, it) = math-block-api(
  main-color: color-themes.third,
  kind: "Proposition",
  number: number,
  title,
  it,
)

// block
#let nice-block-api(
  kind: "regular",
  title: none,
  it
) = {
  block(
    fill: block-color.at(kind).body,
    inset: 1em,
    radius: 4pt,
    width: 100%,
    breakable: true
  )[
    #set par(
      first-line-indent: 0em
    )

    #if title != none{
      smallcaps[#text(
        fill: block-color.at(kind).title,
        size: font-size.SiHao
      )[#title]]
    }else{
      smallcaps[#text(
        fill: block-color.at(kind).title,
        size: font-size.SiHao
      )[#kind]]
    }

    #set par(
      first-line-indent: (
        amount: 1em,
        all: true,
      ),
    )
    
    #it
  ]
}

#let important(
  title,
  it
) = nice-block-api(
  kind: "important",
  title: if title == [] {none} else {title},
  it
)

#let summary(
  title,
  it
) = nice-block-api(
  kind: "summary",
  title: if title == [] {none} else {title},
  it
)

#let question(
  title,
  it
) = nice-block-api(
  kind: "question",
  title: if title == [] {none} else {title},
  it
)

#let error(
  title,
  it
) = nice-block-api(
  kind: "error",
  title: if title == [] {none} else {title},
  it
)


// book
#let nice-cover(
  title: [],
  subtitle: [],
  authors: (),
  date: datetime.today(),
  cover-image: none
) = {

  if type(authors) == dictionary {
    authors = (authors,)
  }

  if type(date) == datetime {
    date = date.display("[year].[month].[day]")
  }

  set page(margin: 0pt)

  if cover-image != none {
    image(cover-image, width: 100%, height: 50%)
    v(3em)
  } else {
    v(10em)
  }

  set align(center)
  text(font: font-style.Book, size: font-size.YiHao)[#title]
  v(0em)
  text(font: font-style.Book, size: font-size.ErHao)[#subtitle]

  let count = authors.len()
  let ncols = calc.min(count, 2)
  grid(
    columns: (1fr,) * ncols,
    row-gutter: 3em,
    ..authors.map(author => {
      for (k, v) in author {
        text(font: font-style.Book, size: font-size.SanHao)[#v]
        linebreak()
      }
    })
  )

  text(font: font-style.Book, size: font-size.SanHao)[#date]

  pagebreak(weak: true)
}

#let nice-preface(it) = {
  set page(numbering: none)

  pagebreak(weak: true)

  align(center)[
    #heading(
      level: 1,
      numbering: none,
      outlined: true
    )[Preface]
  ]

  it

  pagebreak(weak: true)
}


// #let is-counter-zero(kind) = context {
//   let counter-num = counter(kind).final().last()

//   if counter-num >= 1 {
//     return false
//   }else{
//     return true
//   }
// }
#let nice-outline(
  con-depth: 2,
  color-theme: "blue"
) = {

  counter(page).update(1)
  set page(numbering: "I")

  show outline.entry.where(level: 1): it => {
    set block(above: 1.2em)
    strong(it)
    // it
  }
  set outline.entry(fill: repeat(" . "))

  align(center)[
    #heading(
      numbering: none,
      bookmarked: true,
      outlined: false
    )[Contents]
  ]

  outline(
    title: none,
    indent: 1.8em,
    depth: con-depth
  )
  pagebreak(weak: true)

  // if is-counter-zero([#figure.where(kind: image)]) == false {
    align(center)[
      #heading(
        numbering: none,
        bookmarked: true,
        outlined: false
      )[List of Figures]
    ]
    outline(
      title: none,
      target: figure.where(kind: image)
    )
    pagebreak(weak: true)
  // }

  // if is-counter-zero[#figure.where(kind: table)] == false {
    align(center)[
      #heading(
        numbering: none,
        bookmarked: true,
        outlined: false
      )[List of Tables]
    ]
    outline(
      title: none,
      target: figure.where(kind: table)
    )
    pagebreak(weak: true)
  // }

}


#let nice-body(
  heading-prefix: [Chapter], //Section, Subject
  it
) = {

  // figure
  set figure(
    numbering: it => numbering("1.1", counter(heading).get().first(), it)
  )
  show table: it => {
    if table.hline() in it.children {
      return it
    }
    let children = it.children
    let new_children = ()
    for i in children {
      new_children += (i,)
      if repr(i).starts-with("header") {
        new_children += (table.hline(),)
      }
    }
    let meta = it.fields()
    meta.remove("children")
    return table(..meta, table.hline(),..new_children,table.hline())
  }

  // code
  show raw.where(block: true): it => {
    set par(justify: false)
    block(
      fill: luma(245),
      inset: (top: 4pt, bottom: 4pt),
      radius: 4pt,
      width: 100%,
      breakable: true,
      stack(
        ..it.lines.map(raw_line => block(
          inset: 3pt,
          width: 100%,
          grid(
            columns: (1em + 4pt, 1fr),
            align: (right + horizon, left),
            column-gutter: 0.7em,
            row-gutter: 0.6em,
            text(gray, [#raw_line.number]), raw_line,
          ),
        )),
      ),
    )
  }

  // heading numbering
  set heading(
      numbering: numbly(
      heading-prefix.text + " {1}",
      "{1}.{2}",
      "{1}.{2}.{3}",
      "{4:(A)}"
    )
  )

  show heading.where(level: 1): it => {
    set align(center)
    pagebreak(weak: true)

    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)

    for kind in math-block-class {
      counter(kind).update(0)
    }

    it
  }

  // math
  set math.equation(
    numbering: it => numbering("(1.1)", counter(heading).get().first(), it)
  )

  // body content
  pagebreak(weak: true)

  counter(page).update(1)
  set page(numbering: "1")

  it

  pagebreak(weak: true)

}


#let nice-reference(
  path: none
) = {
  pagebreak(weak: true)

  bibliography(
    title: [References],
    // style: "american-physics-society",
    style: "american-anthropological-association",
    // style: "american-sociological-association",
    // style: "american-psychological-association",
    full: true,
    path
  )
  pagebreak(weak: true)
}


#let nice-appendix(it) = {
  set heading(
    numbering: numbly(
      "{1:A}.",
      "{1:A}.{2}",
    )
  )
  counter(heading).update(0)

  set figure(
    numbering: it => numbering("A.1", counter(heading).get().first(), it)
  )
  set math.equation(
    numbering: it => numbering("(A.1)", counter(heading).get().first(), it)
  )

  show heading.where(level: 1): it => {
    pagebreak(weak: true)

    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)

    it
  }

  pagebreak(weak: true)

  it
  
  pagebreak(weak: true)
}


#let nice-epilogue(it) = {
  
  pagebreak(weak: true)

  align(center)[
    #heading(
      level: 1,
      numbering: none,
      outlined: true
    )[Epilogue]
  ]

  it

  pagebreak(weak: true)
}


#let nice-doc(
  title: [],
  subtitle: [],
  authors: (),
  date: datetime.today(),
  paper: "us-letter",
  preface: none,
  epilogue: none,
  appendix: none,
  reference: none,
  con-depth: 2,
  cover-image: none,
  numbering-style: none,
  color-theme: "blue",
  heading-prefix: [Chapter], //Section, Subject
  margin: (x: 20mm, y: 25.4mm),
  it
) = {
  let color-themes = color-select(color-theme)

  // page
  set page(paper: paper, margin: margin)

  // text
  set text(
    font: font-style.Book,
    size: font-size.XiaoSi,
    lang: "en",
    region: "cn"
  )

  // cover
  nice-cover(
    title: title,
    subtitle: subtitle,
    authors: authors,
    date: date,
    cover-image: cover-image
  )

  // global style settings
  set footnote(numbering: "[1]")
  show heading: set block( above: 1.69em, below: 1.3em)
  set list(indent: 1em)
  set enum(full: true, indent: 1em)
  set underline(offset: .15em, stroke: .05em, evade: false)
  show link: set text(fill: rgb(127, 0, 0))
  show math.equation.where(block: false): math.display
  set figure.caption(separator: " ")
  set table(align: center + horizon)
  set table(stroke: none)
  show figure: it => {
    set block(breakable: true)
    it
  }
  show figure.where(
    kind: table
  ): it => {
    set figure.caption(position: top)
    it
  }

  // paragraph
  set par(
    first-line-indent: (
      amount: 2em,
      all: true,
    ),
    justify: true,
    leading: 1em,
    spacing: 1em,
    linebreaks: "optimized"
  )

  if preface != none {
    nice-preface()[#preface]
  }

  nice-outline(
    color-theme: color-theme,
    con-depth: con-depth
  )

  nice-body(
    heading-prefix: heading-prefix
  )[#it]

  if reference != none {
    nice-reference(path: reference)
  }

  if appendix != none {
    nice-appendix()[#appendix]
  }

  if epilogue != none {
    nice-epilogue()[#epilogue]
  }

}


