#let accent-color = rgb(165, 28, 48)

#let frontmatter(
  title: none,
  abstract: [],
  author: "Jane Doe",
  advisor: "Dear Advisor",
  department: "Department of Physics",
  doctor-of: "Philosophy",
  major: "Physics",
  institution: "Johannes Gutenberg University Mainz",
  location: "Mainz, Germany",
  completion-date: datetime.today().display("[month repr:long] [year]"),
  creative-commons: true,
  doc,
) = {
  set page(
    paper: "us-letter",
    margin: (x: 1.375in, y: 1.375in),
    numbering: "I",
  )
  set text(font: "New Computer Modern", size: 12pt)

  set heading(numbering: "1.1")
  show heading.where(
    level: 1,
    outlined: true,
  ): it => [
    #set align(right)
    #set text(20pt, weight: "regular")
    #pagebreak()
    #v(25%)
    #text(100pt, accent-color, counter(heading).display())\
    #text(24.88pt, it.body)
    #v(4em)
  ]
  show heading.where(level: 1): smallcaps
  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    it
  }
  set heading(supplement: it => {
    if it.depth == 1 {
      "Chapter"
    } else {
      "Section"
    }
  })

  set math.equation(numbering: (..num) => numbering(
    "(1.1.1)",
    counter(heading).get().first(),
    ..num,
  ))
  set figure(numbering: (..num) => numbering(
    "1.1.1",
    counter(heading).get().first(),
    ..num,
  ))
  set page(numbering: none)
  set align(center + horizon)
  counter(page).update(1)
  grid(
    [
      #text(accent-color, 24.88pt)[#(title)]

      #v(100pt)
      #show: smallcaps

      A dissertation presented\
      by\
      #author\
      to\
      The #department\
      #v(12pt)
      in partial fulfillment of the requirements\
      for the degree of\
      Doctor of #doctor-of\
      in the subject of\
      #major
      #v(12pt)
      #institution\
      #location\
      #completion-date
    ],
  )

  pagebreak()
  show link: it => {
    set text(fill: accent-color)
    it
  }

  [
    #if creative-commons [
      This work is licensed via #underline[
        #link("https://creativecommons.org/licenses/by/4.0/")[CC BY 4.0]
      ]
    ]

    Copyright #sym.copyright #datetime.today().display("[year]") #author
  ]
  pagebreak()

  // "Preliminary pages (abstract, table of contents, list of tables, graphs, illustrations, and
  // preface) should use small Roman numerals"
  set page(numbering: "I")
  set align(top)
  grid(
    columns: (auto, 1fr, auto),
    [Dissertation Advisor: #advisor], [], [#author],
  )

  v(5%)
  text(accent-color, 17.28pt)[#(title)]
  v(7%)

  // to mimic Double Spacing
  // https://github.com/typst/typst/issues/106#issuecomment-2041051807
  set text(top-edge: 0.7em, bottom-edge: -0.4em)
  set par(justify: true, spacing: 1.8em, leading: 1em)

  [*Abstract*]

  set align(left)
  abstract
  pagebreak()

  show outline.entry.where(level: 1): set outline.entry(fill: none)
  show outline.entry.where(level: 1): it => { smallcaps(it) }

  show ref: it => {
    set text(fill: accent-color)
    it
  }
  show figure.caption: it => [
    #set text(size: 10pt)
    #set par(justify: true)
    #set align(left)
    #strong([#it.supplement
      #context it.counter.display(it.numbering):
    ]) #it.body
  ]

  outline(
    title: grid(
      [
        #set text(23pt)
        #h(1fr)
        Contents
        #v(2em)
      ],
    ),
  )

  counter(page).update(1)
  set page(numbering: "1")
  doc
}

#let appendix(
  doc,
) = {
  set heading(numbering: (..num) => {
    let nums = num.pos()
    if nums.len() == 1 {
      numbering("A", nums.first())
    } else {
      numbering("A.1", ..nums)
    }
  })
  show heading.where(
    level: 1,
    outlined: true,
  ): it => [
    #set align(right)
    #set text(20pt, weight: "regular")
    #pagebreak()
    #v(25%)
    #text(100pt, accent-color, counter(heading).display())\
    #text(24.88pt, it.body)
    #v(4em)
  ]
  show heading.where(level: 1): smallcaps
  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    it
  }

  set math.equation(numbering: (..num) => {
    let ch = counter(heading).get().first()
    "(" + numbering("A", ch) + "." + numbering("1.1", ..num) + ")"
  })
  set figure(numbering: (..num) => {
    let ch = counter(heading).get().first()
    numbering("A", ch) + "." + numbering("1.1", ..num)
  })

  counter(heading).update(0)
  doc
}
