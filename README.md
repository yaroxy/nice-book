# A Typst Notebook Template

## Features

- Single template file structure  
- Support for formulas (1.1) (A.1), figures (1.1) (A.1), and three-line tables (1.1) (A.1)
- Includes cover page (optional image), preface (optional), table of contents, list of figures and tables (auto generated), document body, references (optional), appendix (optional), and epilogue (optional)  
- Code blocks with line numbering  
- Adjustable background color for the full PDF  

## Example

```typ
#import "template.typ": nice-doc
#import "template.typ": definition, theorem, lemma, corollary, postulate, proposition
#import "template.typ": important, summary, question, error


#let yaroxy = (
  (
    name: [Yaroxy],
    affiliation: [University of Science and Technology of China],
    email: [yaroxy\@mail.ustc.edu.cn],
    link: [#link("https://github.com/Yaroxy")[yaroxy\@github]]
  )
)

#show: nice-doc.with(
  title: [Mixture of Experts],
  subtitle: [A Survey],
  authors: (yaroxy,),
  cover-image: "A Survey on Mixture of Experts in Large Language Models.png",
  preface: include "preface/moe.typ",
  reference: "reference/moe.bib",
  appendix: include "appendix/moe.typ"
)
```


## Acknowledgment

Inspired by the following projects:
- [Typst Forum](https://forum.typst.app/)
- [Typst 中文社区导航](https://typst.dev/guide/)
- [Typst Examples Book](https://sitandr.github.io/typst-examples-book/book/)
- [Quite-Elegant-Typ](https://github.com/a31474/quite-elegant-typ)
- [LessElegantNote](https://github.com/choglost/LessElegantNote)
- [numbly](https://github.com/flaribbit/numbly)


