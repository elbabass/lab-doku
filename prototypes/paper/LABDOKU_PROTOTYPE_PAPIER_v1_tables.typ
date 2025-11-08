#set page(margin: 1.5cm)
#set text(font: "DejaVu Sans", size: 11pt)
#set par(justify: false)

// Fonction pour créer une grille de sudoku avec bordures épaisses pour les blocs 2x2
// Cellules de 2.2cm pour permettre 2 grilles côte à côte
// Chiffres colorés selon les clés : 1=rouge, 2=vert, 3=bleu, 4=jaune
#let sudoku-grid(values) = {
  let color-map = (
    "1": red.darken(20%),
    "2": green.darken(20%),
    "3": blue.darken(10%),
    "4": rgb(200, 160, 0)  // Jaune foncé pour la lisibilité
  )

  table(
    columns: (2.2cm, 2.2cm, 2.2cm, 2.2cm),
    rows: (2.2cm, 2.2cm, 2.2cm, 2.2cm),
    stroke: (x, y) => (
      left: if calc.rem(x, 2) == 0 { 2pt } else { 0.75pt },
      top: if calc.rem(y, 2) == 0 { 2pt } else { 0.75pt },
      right: if x == 3 { 2pt } else { 0.75pt },
      bottom: if y == 3 { 2pt } else { 0.75pt },
    ),
    align: center + horizon,
    inset: 6pt,
    fill: (x, y) => {
      let val = values.at(y * 4 + x)
      if val == [] { luma(250) } else { white }
    },
    ..(values.map(v => {
      if v == [] {
        []
      } else {
        // v est déjà du contenu [1], [2], etc.
        // On extrait le texte pour mapper la couleur
        let val-str = repr(v).trim("[").trim("]").trim()
        let color = color-map.at(val-str, default: black)
        text(size: 26pt, weight: "bold", fill: color)[#v]
      }
    }))
  )
}

// Fonction pour le pion joueur (90% de la taille d'une cellule = 1.98cm)
#let player-token(emoji, label) = {
  box(
    width: 2cm,
    height: 2cm,
    stroke: 1.5pt + black,
    radius: 4pt,
    fill: white,
    align(center + horizon)[
      #text(size: 22pt)[#emoji]\
      #v(0.1cm)
      #text(size: 9pt, weight: "bold")[#label]
    ]
  )
}

// Fonction pour petit jeton (événements)
#let small-token(emoji, label) = {
  box(
    width: 2cm,
    height: 2cm,
    stroke: 1.5pt + black,
    radius: 3pt,
    fill: white,
    align(center + horizon)[
      #text(size: 18pt)[#emoji]\
      #v(0.1cm)
      #text(size: 9pt, weight: "bold")[#label]
    ]
  )
}

// Fonction pour jeton indice numéroté (1-4)
#let index-token(number, color) = {
  box(
    width: 1.8cm,
    height: 1.8cm,
    stroke: 1.5pt + black,
    radius: 3pt,
    fill: color.lighten(70%),
    align(center + horizon)[
      #text(size: 24pt, weight: "bold", fill: color.darken(20%))[#number]\
      #v(0.05cm)
      #text(size: 7pt, weight: "bold")[IND]
    ]
  )
}

= LAB-DOKU - Kit de Prototype Papier

== SCÉNARIOS DE TEST

#grid(
  columns: (1fr, 1fr),
  gutter: 1cm,
  [
    === Scénario 1 : Démarrage standard

    #sudoku-grid((
      [1], [], [3], [],
      [], [3], [], [1],
      [3], [], [1], [],
      [], [1], [], [3]
    ))

    #v(0.5cm)
    *État :* Position (0,0) \
    Clés : 🔑1 🔑3 \
    Matériel : D4 (dé à 4 faces)
  ],
  [
    === Scénario 2 : Situation tendue

    #sudoku-grid((
      [1], [2], [3], [4],
      [4], [3], [], [],
      [3], [], [1], [],
      [], [1], [], [3]
    ))

    #v(0.5cm)
    *État :* Position (1,2) \
    Clés : 🔑1 🔑3 🔑4 \
    Matériel : D4

    #text(size: 9pt, fill: red)[← Pion sur case vide ligne 2]
  ]
)

#v(0.5cm)

#text(size: 9pt, style: "italic")[*Note :* La solution de référence est disponible dans le fichier MD]

#pagebreak()

== GRILLES VIERGES

#grid(
  columns: (1fr, 1fr),
  gutter: 1.5cm,
  ..range(2).map(_ => [
    #sudoku-grid((
      [], [], [], [],
      [], [], [], [],
      [], [], [], [],
      [], [], [], []
    ))
  ])
)

#pagebreak()

== JETONS INDICES (à découper)

#text(size: 10pt, style: "italic")[Jetons indices chiffrés - 4 par numéro]

#v(0.5cm)

#grid(
  columns: 6,
  gutter: 0.5cm,
  row-gutter: 0.5cm,

  // Indices "1" (rouge)
  ..range(4).map(_ => index-token("1", red)),

  // Indices "2" (vert)
  ..range(4).map(_ => index-token("2", green)),

  // Indices "3" (bleu)
  ..range(4).map(_ => index-token("3", blue)),

  // Indices "4" (jaune)
  ..range(4).map(_ => index-token("4", rgb(200, 160, 0)))
)

#v(0.5cm)

#text(size: 9pt, style: "italic")[
*Note* : Ces jetons peuvent être placés sur la grille ou ramassés dans l'inventaire du joueur. \
Total grille + inventaire ≤ 4 pour chaque numéro.
]

#pagebreak()

== MATÉRIEL DE JEU

#grid(
  columns: (1fr, 1fr),
  gutter: 1.5cm,
  [
    === Pion joueur

    #align(center)[
      #player-token("🚶", "JOUEUR")
    ]

    #v(1cm)

    === Tracker de clés

    #align(center)[
      #box(
        width: 8cm,
        height: 3cm,
        stroke: 2pt + black,
        radius: 5pt,
        fill: white,
        inset: 10pt,
      )[
        #align(center)[
          *CLÉS POSSÉDÉES*

          #v(0.3cm)

          #grid(
            columns: 4,
            gutter: 0.8cm,
            box(width: 1.5cm, stroke: 1.5pt, inset: 3pt)[
              ☐ 🔴 *1*
            ],
            box(width: 1.5cm, stroke: 1.5pt, inset: 3pt)[
              ☐ 🟢 *2*
            ],
            box(width: 1.5cm, stroke: 1.5pt, inset: 3pt)[
              ☐ 🔵 *3*
            ],
            box(width: 1.5cm, stroke: 1.5pt, inset: 3pt)[
              ☐ 🟡 *4*
            ]
          )
        ]
      ]
    ]
  ],
  [
    === Marqueurs d'événements

    #align(center)[
      #grid(
        columns: 3,
        gutter: 0.6cm,

        small-token("💥", "EXPLO"),
        small-token("🌀", "TÉLÉP"),
        small-token("📉", "PERTE")
      )
    ]

    #v(1cm)

    === Compteur d'erreurs

    #align(center)[
      #box(
        width: 8cm,
        height: 3.5cm,
        stroke: 2pt + black,
        radius: 5pt,
        fill: white,
        inset: 10pt,
      )[
        #align(center)[
          *ERREURS CUMULÉES*

          #v(0.3cm)

          #grid(
            columns: 5,
            gutter: 0.4cm,
            row-gutter: 0.3cm,
            ..range(10).map(_ => box(width: 0.7cm, height: 0.7cm, stroke: 1pt))
          )

          #v(0.3cm)

          *Total :* #box(width: 2.5cm, stroke: (bottom: 1pt))
        ]
      ]
    ]
  ]
)

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
