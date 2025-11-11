#set page(margin: 1.5cm)
#set text(font: "DejaVu Sans Mono", size: 14pt)  // Taille de police augmentée
#set par(justify: false)

= LAB-DOKU - Kit de Prototype Papier

== SCÉNARIOS DE TEST

#grid(
  columns: (1fr, 1fr),
  gutter: 1cm,
  [
    === Scénario 1 : Démarrage standard

    #block(breakable: false)[
    #text(size: 16pt)[  // Grilles encore plus grandes
    ```
    ┌─────┬─────┬─────┬─────┐
    │     │     │     │     │
    │  1  │     │  3  │     │
    │     │     │     │     │
    ├─────┼─────┼─────┼─────┤
    │     │     │     │     │
    │     │  3  │     │  1  │
    │     │     │     │     │
    ├─────┼─────┼─────┼─────┤
    │     │     │     │     │
    │  3  │     │  1  │     │
    │     │     │     │     │
    ├─────┼─────┼─────┼─────┤
    │     │     │     │     │
    │     │  1  │     │  3  │
    │     │     │     │     │
    └─────┴─────┴─────┴─────┘
    ```
    ]

    *État :* Position (0,0) \
    Clés : 🔑1 🔑3 \
    Indices : 🔍🔍🔍
    ]
  ],
  [
    === Scénario 2 : Situation tendue

    #block(breakable: false)[
    #text(size: 16pt)[
    ```
    ┌─────┬─────┬─────┬─────┐
    │     │     │     │     │
    │  1  │  2  │  3  │  4  │
    │     │     │     │     │
    ├─────┼─────┼─────┼─────┤
    │     │     │     │     │
    │  4  │  3  │     │     │ ← ICI
    │     │     │     │     │
    ├─────┼─────┼─────┼─────┤
    │     │     │     │     │
    │  3  │     │  1  │     │
    │     │     │     │     │
    ├─────┼─────┼─────┼─────┤
    │     │     │     │     │
    │     │  1  │     │  3  │
    │     │     │     │     │
    └─────┴─────┴─────┴─────┘
    ```
    ]

    *État :* Position (1,2) \
    Clés : 🔑1 🔑3 🔑4 \
    Indices : 🔍

    #text(size: 9pt, fill: red)[← Pion sur case vide ligne 2]
    ]
  ]
)

#v(0.5cm)

=== Solution de référence (Scénario 1)

#align(center)[
#block(breakable: false)[
#text(size: 16pt)[
```
┌─────┬─────┬─────┬─────┐
│     │     │     │     │
│  1  │  2  │  3  │  4  │
│     │     │     │     │
├─────┼─────┼─────┼─────┤
│     │     │     │     │
│  4  │  3  │  2  │  1  │
│     │     │     │     │
├─────┼─────┼─────┼─────┤
│     │     │     │     │
│  3  │  4  │  1  │  2  │
│     │     │     │     │
├─────┼─────┼─────┼─────┤
│     │     │     │     │
│  2  │  1  │  4  │  3  │
│     │     │     │     │
└─────┴─────┴─────┴─────┘
```
]
]
]

#pagebreak()

== GRILLES VIERGES

#let empty-grid = [
  #text(size: 16pt)[
  ```
  ┌─────┬─────┬─────┬─────┐
  │     │     │     │     │
  │     │     │     │     │
  │     │     │     │     │
  ├─────┼─────┼─────┼─────┤
  │     │     │     │     │
  │     │     │     │     │
  │     │     │     │     │
  ├─────┼─────┼─────┼─────┤
  │     │     │     │     │
  │     │     │     │     │
  │     │     │     │     │
  ├─────┼─────┼─────┼─────┤
  │     │     │     │     │
  │     │     │     │     │
  │     │     │     │     │
  └─────┴─────┴─────┴─────┘
  ```
  ]
]

#grid(
  columns: (1fr, 1fr),
  gutter: 1cm,
  row-gutter: 1cm,
  [=== Grille \#1 #empty-grid],
  [=== Grille \#2 #empty-grid],
  [=== Grille \#3 #empty-grid],
  [=== Grille \#4 #empty-grid]
)

#pagebreak()

== JETONS À DÉCOUPER

=== Pion joueur

#align(center)[
#box(
  width: 3.5cm,  // 2x plus large
  height: 3.5cm,
  stroke: 2pt + black,
  radius: 4pt,
  fill: white,
  align(center + horizon)[
    #text(size: 32pt)[🚶]\
    #v(0.2cm)
    #text(size: 12pt, weight: "bold")[JOUEUR]
  ]
)
]

#v(1cm)

=== Clés (4 jetons par couleur)

#let key-token(emoji, label, color) = {
  box(
    width: 3.5cm,  // 2x plus large
    height: 3.5cm,
    stroke: 2pt + black,
    radius: 4pt,
    fill: color,
    align(center + horizon)[
      #text(size: 32pt)[#emoji]\
      #v(0.2cm)
      #text(size: 12pt, weight: "bold")[#label]
    ]
  )
}

#grid(
  columns: 4,
  gutter: 0.8cm,
  row-gutter: 0.8cm,

  // Clés rouges
  ..range(4).map(_ => key-token("🔴", "🔑1", red.lighten(80%))),

  // Clés vertes
  ..range(4).map(_ => key-token("🟢", "🔑2", green.lighten(80%))),

  // Clés bleues
  ..range(4).map(_ => key-token("🔵", "🔑3", blue.lighten(80%))),

  // Clés jaunes
  ..range(4).map(_ => key-token("🟡", "🔑4", yellow.lighten(70%)))
)

#pagebreak()

=== Indices (15 jetons)

#let small-token(emoji, label) = {
  box(
    width: 2.5cm,  // 2x plus large
    height: 2.5cm,
    stroke: 2pt + black,
    radius: 3pt,
    fill: white,
    align(center + horizon)[
      #text(size: 24pt)[#emoji]\
      #v(0.1cm)
      #text(size: 10pt, weight: "bold")[#label]
    ]
  )
}

#grid(
  columns: 5,
  gutter: 0.6cm,
  row-gutter: 0.6cm,

  ..range(15).map(_ => small-token("🔍", "IND"))
)

#v(1.5cm)

=== Marqueurs d'événements

#grid(
  columns: 3,
  gutter: 1cm,

  small-token("💥", "EXPLO"),
  small-token("🌀", "TÉLÉP"),
  small-token("📉", "PERTE")
)

#v(1.5cm)

=== Compteur d'erreurs

#align(center)[
  #box(
    width: 10cm,  // Plus large
    height: 5cm,  // Plus haut
    stroke: 2pt + black,
    radius: 5pt,
    fill: white,
    inset: 20pt,
  )[
    #align(center)[
      *ERREURS CUMULÉES*

      #v(0.5cm)

      #grid(
        columns: 5,
        gutter: 0.5cm,
        row-gutter: 0.3cm,
        ..range(10).map(_ => box(width: 1cm, height: 1cm, stroke: 1.5pt))
      )

      #v(0.5cm)

      #text(size: 14pt)[*Total :*] #box(width: 4cm, stroke: (bottom: 1.5pt))
    ]
  ]
]

#pagebreak()

== CHECKLIST DE VALIDATION

Après 2-3 parties de test :

#grid(
  columns: (1fr, 1fr),
  gutter: 1cm,
  [
    *Gameplay de base*
    - ☐ Jouable du début à la fin ?
    - ☐ Bloqué trop souvent ?
    - ☐ Règles claires ?

    #v(0.5cm)

    *Tension et intérêt*
    - ☐ Décisions intéressantes ?
    - ☐ Anticipation des coups ?
    - ☐ Événements fun ou frustrants ?
  ],
  [
    *Rythme*
    - ☐ Durée : court / bon / long ?
    - ☐ Envie de rejouer ?

    #v(0.5cm)

    *Prochaine étape*
    - ☐ GO → coder
    - ☐ Ajuster → quoi ?
    - ☐ NO-GO → pivot ?
  ]
)

#v(1cm)

*Notes libres :*

#v(2cm)
#line(length: 100%)
#v(2cm)
#line(length: 100%)
#v(2cm)
#line(length: 100%)
