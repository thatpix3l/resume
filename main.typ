
#let config = yaml("data.yaml")

#set page(margin: 0pt)
#show link: underline

#let contact = {
  set box(height: 11pt)
  set text(size: 11pt)

  table(
    columns: (auto, auto),
    align: (right, right),
    stroke: none,
    link("mailto:" + config.contact.email)[#config.contact.email], box(image("assets/icons/square-envelope-solid.svg")),
    config.contact.phone, box(image("assets/icons/square-phone-solid.svg")),
    link("https://github.com/" + config.contact.github)[GitHub], box(image("assets/icons/square-github.svg")),
    link("https://linkedin.com/in/" + config.contact.linkedin)[LinkedIn], box(image("assets/icons/linkedin.svg")),
  )
}

#let education(institution) = [
  #set box(height: 11pt)
  #set text(size: 11pt)

  _ #institution.name _

  #for degree in institution.degreess [

    #degree.level in #degree.field

    Orlando, FL

    #datetime(
      year: degree.completion_date.year,
      month: degree.completion_date.month,
      day: 1,
    ).display("[month repr:long] [year]")
  ]
]

#let experience_date(date) = if type(date) == str {
  "Current"
} else {
  datetime(
    year: date.year,
    month: date.month,
    day: date.day,
  ).display("[month repr:long] [year]")
}

#show: content => {
  table(
    rows: (auto, 1fr),
    inset: 0pt,
    stroke: none,
    table.cell(fill: rgb(config.palette.shade_1), inset: 10pt)[
      #set align(center)
      #set par(spacing: 14pt)
      #set text(fill: rgb(config.palette.light))

      #text(size: 30pt)[#config.name.given #config.name.family]

      #text(size: 12pt)[_#config.career_title _]


    ],
    content,
  )
}

#show: col_right => table(
  columns: (auto, 1fr),
  rows: 1fr,
  gutter: 0pt,
  stroke: none,
  inset: 15pt,
  table.cell(fill: rgb(config.palette.left_column))[

    #set align(right)

    = Contact
    #contact

    = Education
    #for edu in config.education {
      education(edu)
    }

    = Skills

    #for skill in config.skills.sorted() [
      #skill

    ]
  ],
  col_right,
)

#set par(spacing: 13pt)
#show heading: set block(below: 10pt)

= Work Experience

#for exp in config.work_experience [

  #text(size: 14pt)[#exp.position]

  _ #exp.company _

  #let begin = experience_date(exp.date.begin)
  #let end = experience_date(exp.date.end)

  #begin - #end

  #for work in exp.notable_works [
    - #work.summary

  ]
]

= Projects

#for proj in config.projects [
  #show link: it => underline()[_#it _]

  #[
    #set par(spacing: 4pt)
    #text(size: 12pt)[#proj.name]

    #text(size: 10pt)[#link(proj.repo, proj.repo)]
  ]

  - #proj.description

]
