// general document

#import "main.typ": gen_preamble, doc_template, lref, source_code, status, heading_font, font

#let template(
  title: none,
  authors: none,
  suffix: none,
  prefix: none,
  enable-footer: true,
  heading_font: heading_font,
  text_font: font,
  body
) = {
  doc_template(
  title: title,
  authors: authors,
  prefix: prefix,
  enable-footer: enable-footer,
  text_font: text_font,
  {
    gen_preamble(title: title, authors: authors, suffix: suffix, prefix: prefix, font: heading_font)
    body
  })
}
