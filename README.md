# Lab-doku

**Un puzzle game qui fusionne sudoku et navigation spatiale**

> "Je suis un enquêteur-démineur sur les traces d'un poseur de bombes en série passionné de chiffres."

---

## 🎮 Concept

Lab-doku est un jeu où tu explores un sudoku en vue du dessus pour le résoudre. Le truc cool : chaque chiffre est une porte de couleur, résoudre une ligne donne une clé, et les erreurs créent des événements chaotiques que tu peux **même** utiliser stratégiquement quand tu es bloqué.

**Core mechanic** : Tu navigues sur une grille de sudoku, mais tu peux seulement marcher sur les chiffres dont tu as la clé. Placer de nouveaux chiffres modifie tes possibilités de déplacement. Les erreurs ont des conséquences... que tu peux parfois exploiter.

---

## 📁 Structure du projet

```
lab-doku/
├── README.md                          # Ce fichier
├── EXECUTIVE_SUMMARY.md               # Pitch condensé (1 page)
├── docs/
│   ├── DESIGN_DOC.md                  # Document de design complet
│   └── references/                    # Jeux et ressources de référence
├── prototypes/
│   ├── paper/
│   │   └── LABDOKU_PROTOTYPE_PAPIER.md   # Kit de test papier
│   └── digital/                       # Prototypes Godot (à venir)
└── assets/
    └── concept/                       # Croquis et concepts art
```

---

## 🎯 Statut du projet

**Phase actuelle** : Préparation prototype digital ✅ Tests papier complétés

- [x] Phase 1 : Définition de l'essence (pitch, core mechanic, player fantasy)
- [x] Phase 2 : Exploration des mécaniques (clés, indices, événements)
- [x] Phase 3 : Prototype papier & tests ✅ **GO VALIDÉ**
- [ ] Phase 4 : Prototype digital (Godot)
- [ ] Phase 5 : Itérations & polish

**Dernière mise à jour** : 2025-11-11 - Tests papier complétés, règles validées. Voir [résultats détaillés](docs/PAPER_PROTOTYPE_TEST_RESULTS.md).

---

## 🚀 Démarrage rapide

### Tester le concept sur papier

1. Ouvre [`prototypes/paper/LABDOKU_PROTOTYPE_PAPIER.md`](prototypes/paper/LABDOKU_PROTOTYPE_PAPIER.md)
2. Imprime le document
3. Découpe les jetons
4. Joue les 2 scénarios (15-20 min chacun)
5. Note tes impressions dans le journal de test

### Lire le design

- **Executive summary** : [`EXECUTIVE_SUMMARY.md`](EXECUTIVE_SUMMARY.md) - lecture 3 min
- **Design complet** : [`docs/DESIGN_DOC.md`](docs/DESIGN_DOC.md) - lecture 15 min

---

## 🎲 Mécaniques principales

### Déplacement

- Tu peux te déplacer sur les cases adjacentes (haut/bas/gauche/droite)
- Tu dois posséder la **clé de couleur** correspondant au chiffre de la case

### Ressources

- **🔑 Clés** : Obtenues en complétant des séries (ligne/colonne/bloc 2x2)
  - Départ : 2 clés (standard), 1 (difficile), 3 (facile)
- **🔍 Jetons indices numérotés** (1-4) :
  - **Départ : 2 indices aléatoires** dans l'inventaire (règle validée)
  - Posés sur certaines cases de la grille (ramassage automatique)
  - Stockés dans l'inventaire (contrainte : max 4 par chiffre au total)
  - Utilisés pour placer des chiffres (consomme le jeton)
  - **Récompense par placement correct** : +1 indice aléatoire (nouveau)
  - Récompense par série complétée : indices aléatoires supplémentaires

### Placement et Navigation

- Sur case vide : **choisis** un jeton de ton inventaire ou **annule** (recule)
- Si correct : le chiffre reste, le jeton est consommé, **+1 indice gagné**
- Si erreur : événement se déclenche (principalement perte d'indice)
- **Règle spéciale** (validée) : Une fois un chiffre posé sur case vide, tu peux y rester sans clé, mais tu ne pourras plus y revenir sans la clé correspondante

### Événements d'erreur (système révisé)

Quand tu places un mauvais chiffre, un événement se déclenche :

- **📉 Perte d'indice** (principal) : Perds 1 indice de ton inventaire (au hasard)
- **🌀 Téléportation** (occasionnel) : Te déplace sur une case pré-remplie aléatoire
- **💥 Explosion** (optionnel) : Efface les 4-8 cases adjacentes (cases pré-remplies protégées)

### Victoire et Défaite

- **Victoire** : Remplis correctement les 16 cases du sudoku 4x4 !
- **Défaite** (nouveau) : **Game Over si inventaire vide** - tu n'as plus d'indices pour continuer

---

## 🛠️ Stack technique

**Moteur** : Godot 4.x + GDScript  
**Outils** : Markdown, Git, papier & crayon

---

## 🎨 Inspirations

### Jeux similaires

- **Baba Is You** - Méta-puzzle où résoudre change les règles
- **The Witness** - Puzzles débloquent l'exploration
- **Puzzle Quest** - Mélange de genres (match-3 + RPG)

### Concepts uniques de lab-doku

- Tu ES dans le puzzle (pas à côté)
- Résoudre et naviguer sont la même action
- Le sudoku n'est pas décoratif, c'est le terrain de jeu

---

## 📊 Résultats des tests papier ✅

Tests complétés en novembre 2025. Voir le [rapport détaillé](docs/PAPER_PROTOTYPE_TEST_RESULTS.md).

**Synthèse** :

- ✅ Jouable du début à la fin (avec ajustements)
- ✅ Règles claires, comprises immédiatement
- ✅ Synergie résolution/navigation excellente
- ⚠️ Durée trop courte (2 min au lieu de 5-15 min) → Solutions identifiées
- ⚠️ Rejouabilité mitigée → Plus de difficulté nécessaire

**Ajustements validés** :

- Navigation sur case vide : pouvoir rester sans clé après placement
- Démarrage : 2 indices aléatoires + 2 clés
- Game Over si inventaire vide
- Gain d'indice à chaque placement correct
- Événements : perte d'indice principale

---

## 🤝 Contribution

Ce projet est actuellement en phase d'exploration personnelle. Les retours sur le prototype papier sont les bienvenus !

Si tu testes le proto papier :

1. Remplis le journal de test dans le document
2. Ouvre une issue avec tes observations
3. Ou contacte directement via [à définir]

---

## 📝 License

[À définir - probablement MIT ou CC BY-NC]

---

## 🔗 Liens utiles

- [Executive Summary](EXECUTIVE_SUMMARY.md) - Pitch condensé
- [Design Doc](docs/DESIGN_DOC.md) - Documentation complète
- [Prototype papier](prototypes/paper/LABDOKU_PROTOTYPE_PAPIER.md) - Kit de test

---

**Créé avec ❤️ pendant une exploration de game design**

*Dernière mise à jour : 2025-11-11 (Tests papier complétés)*
