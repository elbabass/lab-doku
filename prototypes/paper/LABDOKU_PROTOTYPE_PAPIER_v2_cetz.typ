#import "@preview/cetz:0.3.1": canvas, draw

#set page(margin: 1.5cm)
#set text(font: "DejaVu Sans", size: 11pt)
#set par(justify: false)

// Fonction pour dessiner une grille de sudoku avec CeTZ
#let sudoku-grid-cetz(values) = {
  let cell-size = 1.5  // Taille doublée

  canvas(length: 1cm, {
    import draw: *

    // Dessiner les cellules
    for y in range(4) {
      for x in range(4) {
        let val = values.at(y * 4 + x)
        let is-empty = val == []

        // Fond de cellule
        rect(
          (x * cell-size, -y * cell-size),
          ((x + 1) * cell-size, -(y + 1) * cell-size),
          fill: if is-empty { rgb(250, 250, 250) } else { white },
          stroke: none
        )

        // Valeur
        if not is-empty {
          content(
            ((x + 0.5) * cell-size, -(y + 0.5) * cell-size),
            text(size: 20pt, weight: "bold")[#val]
          )
        }
      }
    }

    // Lignes fines
    for i in range(5) {
      let thickness = if calc.rem(i, 2) == 0 { 2pt } else { 0.75pt }
      line((0, -i * cell-size), (4 * cell-size, -i * cell-size), stroke: thickness)
      line((i * cell-size, 0), (i * cell-size, -4 * cell-size), stroke: thickness)
    }
  })
}

// Fonction pour créer un jeton avec CeTZ (arrondi)
#let token-cetz(emoji, label, bg-color) = {
  let size = 3.5  // Taille doublée

  canvas(length: 1cm, {
    import draw: *

    // Fond arrondi
    rect(
      (0, 0),
      (size, size),
      fill: bg-color,
      stroke: 1.5pt + black,
      radius: 0.3
    )

    // Emoji
    content((size / 2, size * 0.65), text(size: 28pt)[#emoji])

    // Label
    content((size / 2, size * 0.3), text(size: 12pt, weight: "bold")[#label])
  })
}

// Petit jeton
#let small-token-cetz(emoji, label) = {
  let size = 2.5

  canvas(length: 1cm, {
    import draw: *

    rect(
      (0, 0),
      (size, size),
      fill: white,
      stroke: 1.5pt + black,
      radius: 0.2
    )

    content((size / 2, size * 0.6), text(size: 20pt)[#emoji])
    content((size / 2, size * 0.25), text(size: 9pt, weight: "bold")[#label])
  })
}

= LAB-DOKU - Kit de Prototype Papier

== SCÉNARIOS DE TEST

#grid(
  columns: (1fr, 1fr),
  gutter: 1cm,
  [
    === Scénario 1 : Démarrage standard

    #sudoku-grid-cetz((
      [1], [], [3], [],
      [], [3], [], [1],
      [3], [], [1], [],
      [], [1], [], [3]
    ))

    #v(0.5cm)
    *État :* Position (0,0) \
    Clés : 🔑1 🔑3 \
    Indices : 🔍🔍🔍
  ],
  [
    === Scénario 2 : Situation tendue

    #sudoku-grid-cetz((
      [1], [2], [3], [4],
      [4], [3], [], [],
      [3], [], [1], [],
      [], [1], [], [3]
    ))

    #v(0.5cm)
    *État :* Position (1,2) \
    Clés : 🔑1 🔑3 🔑4 \
    Indices : 🔍

    #text(size: 9pt, fill: red)[← Pion sur case vide ligne 2]
  ]
)

#v(1cm)

=== Solution de référence (Scénario 1)

#align(center)[
  #sudoku-grid-cetz((
    [1], [2], [3], [4],
    [4], [3], [2], [1],
    [3], [4], [1], [2],
    [2], [1], [4], [3]
  ))
]

#pagebreak()

== GRILLES VIERGES

#grid(
  columns: (1fr, 1fr),
  gutter: 1.5cm,
  row-gutter: 1.5cm,
  ..range(4).map(_ => [
    #sudoku-grid-cetz((
      [], [], [], [],
      [], [], [], [],
      [], [], [], [],
      [], [], [], []
    ))
  ])
)

#pagebreak()

== JETONS À DÉCOUPER

=== Pion joueur

#align(center)[
  #token-cetz("🚶", "JOUEUR", white)
]

#v(1cm)

=== Clés (4 jetons par couleur)

#grid(
  columns: 4,
  gutter: 0.8cm,
  row-gutter: 0.8cm,

  // Clés rouges
  ..range(4).map(_ => token-cetz("🔴", "🔑1", red.lighten(80%))),

  // Clés vertes
  ..range(4).map(_ => token-cetz("🟢", "🔑2", green.lighten(80%))),

  // Clés bleues
  ..range(4).map(_ => token-cetz("🔵", "🔑3", blue.lighten(80%))),

  // Clés jaunes
  ..range(4).map(_ => token-cetz("🟡", "🔑4", yellow.lighten(70%)))
)

#pagebreak()

=== Indices (15 jetons)

#grid(
  columns: 5,
  gutter: 0.6cm,
  row-gutter: 0.6cm,

  ..range(15).map(_ => small-token-cetz("🔍", "IND"))
)

#v(1.5cm)

=== Marqueurs d'événements

#grid(
  columns: 3,
  gutter: 1cm,

  small-token-cetz("💥", "EXPLO"),
  small-token-cetz("🌀", "TÉLÉP"),
  small-token-cetz("📉", "PERTE")
)

#v(1.5cm)

=== Compteur d'erreurs

#align(center)[
  #canvas(length: 1cm, {
    import draw: *

    let width = 10
    let height = 5

    // Fond
    rect(
      (0, 0),
      (width, height),
      fill: white,
      stroke: 2pt + black,
      radius: 0.3
    )

    // Titre
    content((width / 2, height * 0.85), text(size: 14pt, weight: "bold")[ERREURS CUMULÉES])

    // Cases à cocher (2 lignes de 5)
    for row in range(2) {
      for col in range(5) {
        let x = 1.5 + col * 1.5
        let y = height * 0.65 - row * 1.2
        rect(
          (x, y - 0.5),
          (x + 0.8, y + 0.3),
          stroke: 1pt
        )
      }
    }

    // Ligne "Total"
    content((width / 2 - 2, height * 0.15), text(size: 12pt, weight: "bold")[Total :])
    line((width / 2, height * 0.15), (width / 2 + 3, height * 0.15), stroke: 1pt)
  })
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
