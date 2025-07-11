// main template that everything inherits from

#let script-size = 9pt
#let footnote-size = 8pt
#let small-size = 8pt
#let normal-size = 9pt
#let large-size = 12pt
#let title-size = 18pt

#let font = "Nimbus Sans L"
#let heading_font = "Nimbus Sans L"
// #let mono_font = "DejaVuSansMono Nerd Font"
// #let font = "New Computer Modern"
// #let heading_font = "New Computer Modern"
#let mono_font = "JetBrains Mono"

#let settings = yaml("/typst/settings.yml")

// reference based on TYPST_ROOT
// use paths like "/problems/problem.pdf"
// which will translate to "/home/user/docs/problems/problem.pdf"
#let lref(
  // whether or not to prepend 'pdfref://' to the link. as long as the handler
  // is installed, it allows specifying the page number linked to
  // see https://github.com/dogeystamp/pyinstantref for details
  pdfref: false,
  url,
  text
) = {
  let realUrl = settings.prefix + url;
  if (pdfref) {
    realUrl = "pdfref://" + realUrl
  }
  return link(realUrl, text)
}

#let gen_title(
  title: none,
  font: heading_font,
) = {
  // Set document metadata.
  text(size: title-size, weight: "black", title, font: font)
}

#let author_string(authors: none) = {
  if authors == none {
    authors = (
      (
        name: settings.me,
      ),
    )
  }

  let names = authors.map(author => author.name)
  return if authors.len() == 2 {
    names.join(" and ")
  } else {
    names.join(", ", last: ", and ")
  }
}

#let gen_authors(
  authors: none,
) = {
  text(author_string(authors: authors))
}

#let gen_preamble(
  title: none,
  authors: none,
  prefix: none,
  suffix: none,
  font: heading_font,
) = {
  pad(left: -2%, {
      gen_title(title: title, font: font)
      v(13pt, weak: true)
      pad(left: 1.5pt, prefix)
      align(right,
        rect(
          width: 50%,
          stroke: none,
          {
            [
              #{gen_authors(authors: authors)}
            ]
            linebreak()
            suffix
        })
      )
      v(10pt)
    line(length: 100%, stroke: 1pt + rgb("#555555"))
  })
  v(5%, weak: true)
}

// this template sets up the document
// but does not do things like title, authors, etc.
#let doc_template(
  paper-size: "a4",
  // paper-size: "us-letter",
  title: "",
  authors: none,
  enable-footer: true,
  prefix: none,
  text_font: font,

  // Content to wrap
  body,
) = {
  set text(size: normal-size, font: text_font, weight: "regular", lang: settings.lang)
  show link: text.with(fill: rgb("#5577bb"), weight: "bold")
  show math.equation: eq => eq
  set figure.caption(position: top)
  set figure(gap: 1em)
  show figure.caption: emph
  show figure: fig => {
    show: pad.with(x: 1em, y: 0.6em)
    show image: pad.with(y: 0.5em)
    set image(width: 50%)
    set align(center)
    fig
  }
  set table(inset: 10pt, stroke: 0.5pt + black)
  show heading: it => [
	  #set text(font: heading_font, weight: "black")
	  #text(it)
	  #v(0.1em)
  ]
  set heading(numbering: "1.")
  show raw.where(block: true): txt => pad(
      left: 0.5em,
      block(
        radius: 0em,
        stroke: luma(230),
        fill: luma(250),
        pad(
          left: 1em,
          right: 1em,
          top: 1em,
          bottom: 1em,
          txt
        )
      )
    )
  // Set code font
  show raw: set text(font: mono_font, size: script-size)

  set page(
    paper: paper-size,
    // margin: (top: 8%, rest: 10%),
    margin: (x: 3cm, y: 3cm),
    footer-descent: 50%,
    footer: if enable-footer [
      #set text(size: footnote-size, fill: luma(80))
      #columns(3)[
        #align(left)[
          //©
          // #author_string(authors: authors),
          // #prefix,
          // #datetime.today().year()
          #prefix
        ]
        #colbreak()

        #align(center)[
          _ #title _
        ]
        #colbreak()

        #align(right)[
          #context {
            counter(page).display("1")
          }
        ]
      ]
    ],
  )
  // set list(indent: 5pt, body-indent: 5pt, marker: ("▪", "‣"))
  set list(indent: 5pt, body-indent: 5pt, marker: ("•", "◦"))
  set enum(indent: 5pt, body-indent: 5pt)

  // Configure paragraph properties.
  set par(justify: true)

  // Display the article's contents.
  v(29pt, weak: true)
  body
}


////////////////////////////////
// compsci notes utils
////////////////////////////////

// did i finish this problem?
#let status(stat: "incomplete") = {
  if stat == "complete" {
    text(fill: rgb("#448d00"))[
      *Status*: Completed
    ]
  } else if stat == "cheated" {
    text(fill: rgb("#aaaa22"))[
      *Status*: Solved with editorial
    ]
  } else {
    text(fill: rgb("#aa4422"))[
      *Status*: Incomplete
    ]
  }
}

// show associated source code
#let source_code(
  lang: "cpp",
  block: true,
  src_path: "problems/src/",
  // convert tabs to spaces
  detab: true,
  problem_id
) = {
  let raw_text = read("../" + src_path + problem_id + "." + lang)
  if detab {
    raw_text = raw_text.replace("\t", "    ")
  }

  text(font: mono_font)[
    #raw(
      raw_text,
      block: true,
      lang: lang,
    )
  ]
}
