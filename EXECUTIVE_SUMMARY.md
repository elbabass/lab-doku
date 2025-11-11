# Lab-doku - Executive Summary

**Un puzzle game original qui fusionne sudoku et navigation spatiale**

---

## 🎯 Pitch (30 secondes)

Lab-doku est un jeu où tu explores un sudoku en vue du dessus pour le résoudre. Chaque chiffre est une porte de couleur, résoudre une ligne donne une clé, et les erreurs créent des événements chaotiques que tu peux même utiliser stratégiquement quand tu es bloqué.

**Player fantasy** : "Je suis un enquêteur-démineur sur les traces d'un poseur de bombes en série passionné de chiffres."

---

## 🎮 Core Mechanic

Tu navigues sur une grille de sudoku, mais tu peux seulement marcher sur les chiffres dont tu as la clé. Placer de nouveaux chiffres modifie tes possibilités de déplacement. Les erreurs ont des conséquences... que tu peux parfois exploiter.

**Ce qui rend lab-doku unique** :

- Tu ES dans le puzzle (pas à côté)
- Résoudre et naviguer sont **la même action**
- Le sudoku n'est pas décoratif, c'est le terrain de jeu

---

## 🎲 Boucle de gameplay

1. **Explorer** → Te déplacer sur les chiffres dont tu as les clés
2. **Collecter** → Ramasser les jetons indices numérotés sur la grille
3. **Déduire** → Identifier où placer les bons chiffres
4. **Placer** → Choisir un jeton de ton inventaire pour poser un chiffre (ou annuler)
5. **Conséquence** →
   - Correct ? De nouveaux chemins s'ouvrent
   - Erreur ? Événement chaotique (explosion, téléportation, perte)
6. **Progresser** → Compléter des séries donne clés + indices aléatoires
7. Retour à 1

---

## 🔑 Systèmes principaux

### Clés & Navigation

- 4 couleurs de clés (1 par chiffre en 4x4)
- Tu ne peux marcher que sur les chiffres dont tu possèdes la clé
- Gagner des clés en complétant lignes/colonnes/blocs

### Indices & Placement

- **Jetons indices numérotés** (1-4) posés sur certaines cases de la grille
- Ramassage automatique en passant dessus → stockage dans l'inventaire
- Contrainte : Total (grille + inventaire) ≤ 4 par chiffre
- Sur case vide : choisir un jeton de l'inventaire à placer (ou annuler/reculer)
- Récompense par série : indices aléatoires supplémentaires (variantes à tester : 1 ou 2)

### Événements d'erreur

Quand tu te trompes (probabilité équirépartie) :

- **💥 Explosion** : Efface les 4 cases adjacentes (cases pré-remplies protégées)
- **🌀 Téléportation** : Te déplace sur une case pré-remplie accessible aléatoire
- **📉 Perte** : Perds 1 indice de ton inventaire (au hasard)

---

## 🎬 Moment magique

> Je suis coincé en haut à droite. J'hésite entre placer un 3 ou un 5. Je ne peux pas atteindre la case qui résoudrait mon problème. Je tente le 5... BOUM ! Explosion. Les chiffres adjacents disparaissent, je me retrouve téléporté en bas à gauche... pile où j'avais besoin d'être. Je peux enfin poser mon 1 !

Ce type de situation émergente - où une "erreur" devient un outil stratégique - est au cœur de l'expérience.

---

## 📊 Scope initial

**Prototype v0.1** (cible : 2-3 semaines)

- Grille 4x4 (16 cases)
- 4 couleurs/clés
- 3 événements d'erreur
- 5-6 chiffres pré-remplis
- Vue du dessus 2D
- Pas d'art final, juste gameplay

**Évolution possible**

- Grilles 5x5, puis 9x9
- Nouveaux événements
- Modes de difficulté
- Narration développée (thème enquêteur-démineur)

---

## 🎨 Références

**Jeux comparables** :

- **Baba Is You** - Méta-puzzle où résoudre change les règles de navigation
- **The Witness** - Résoudre des puzzles débloque l'exploration
- **Puzzle Quest** - Pionnier des mélanges de genres réussis

**Ce qui n'existe pas encore** :
Aucun jeu n'a fusionné sudoku et navigation spatiale de cette manière. Le territoire est vierge.

---

## 🛠️ Stack technique

- **Moteur** : Godot 4.x + GDScript
- **Phase actuelle** : Prototype papier
- **Prochaine étape** : Prototype digital minimaliste

---

## 📈 Validation

**Phase 1 : Prototype papier** ✓ (en cours)

- Tester les mécaniques core sur papier
- Identifier les problèmes de game design
- Valider le fun potentiel

**Phase 2 : Prototype digital** (à venir)

- Coder le système de base en Godot
- Tester avec 3-5 personnes
- Itérer sur les paramètres (nombre d'indices, probabilités, etc.)

**Critères de succès** :

- Le joueur comprend les règles en < 2 minutes
- Durée moyenne d'une partie : 5-10 minutes
- Taux de rejouabilité > 50%
- Au moins 1 "moment magique" par partie

---

## 🎯 Vision long-terme

Si le concept tient, lab-doku pourrait devenir :

- Un jeu mobile casual élégant (Think Monument Valley meets sudoku)
- Une série de puzzles avec progression narrative
- Un outil d'enseignement du sudoku ludique

Mais avant tout : **valider que c'est fun**.

---

## 🤔 Risques identifiés

1. **Blocage du joueur** : Peut manquer de clés/indices et ne plus pouvoir progresser
   - Mitigation : Tests papier + ajustements paramètres

2. **Complexité cognitive** : Jongler entre sudoku + navigation peut être trop
   - Mitigation : Commencer 4x4 (simple), UI claire

3. **Événements trop chaotiques** : Les erreurs peuvent frustrer plus qu'ajouter du fun
   - Mitigation : Tests utilisateurs, ajustement probabilités

4. **Durée de jeu** : Trop court (< 3 min) ou trop long (> 15 min)
   - Mitigation : Grilles de différentes tailles

---

## 📞 Contact

[À compléter]

---

**Créé en novembre 2025**  
**Statut** : Conception & Prototype papier  
**Temps investi** : ~5h de design, 0h de code  
**Prochaine étape** : Tests papier + début prototype Godot
