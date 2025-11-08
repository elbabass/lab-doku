# Lab-doku - Document de Design Complet

**Version** : 0.1 (Novembre 2025)  
**Statut** : Conception & Prototype papier  
**Auteur** : Bastien

---

## Table des matières

1. [Vue d'ensemble](#vue-densemble)
2. [Vision & Concept](#vision--concept)
3. [Core Mechanic](#core-mechanic)
4. [Systèmes de jeu](#systèmes-de-jeu)
5. [Boucle de gameplay](#boucle-de-gameplay)
6. [Paramètres & Balance](#paramètres--balance)
7. [Références & Inspirations](#références--inspirations)
8. [Prototype papier](#prototype-papier)
9. [Prochaines étapes](#prochaines-étapes)
10. [Journal de développement](#journal-de-développement)

---

## Vue d'ensemble

### Pitch en une phrase

Lab-doku, c'est un jeu où tu explores un sudoku en vue du dessus pour le résoudre. Le truc cool : chaque chiffre est une porte de couleur, résoudre une ligne donne une clé, et les erreurs créent des événements chaotiques que tu peux **même** utiliser stratégiquement quand tu es bloqué.

### Player Fantasy

> "Je suis un enquêteur-démineur sur les traces d'un poseur de bombes en série passionné de chiffres."

Cette fantasy justifie :

- Les portes colorées = pièges/codes laissés par le criminel
- Les clés = indices que tu découvres
- Les explosions d'erreurs = bombes qui se déclenchent
- Le sudoku = obsession du criminel

---

## Vision & Concept

### Core Mechanic

Tu navigues sur une grille de sudoku, mais tu peux seulement marcher sur les chiffres dont tu as la clé. Placer de nouveaux chiffres modifie tes possibilités de déplacement. Les erreurs ont des conséquences... que tu peux parfois exploiter.

### Ce qui rend lab-doku unique

- **Tu ES dans le puzzle** (pas à côté) - pas de séparation entre l'espace de jeu et le puzzle
- **Résoudre et naviguer sont la même action** - feedback loop organique
- **Le sudoku n'est pas décoratif** - c'est le terrain de jeu lui-même
- **Les erreurs sont des outils** - pas seulement des punitions

### Moment magique (scénario de référence)

Je suis sur une case en haut à droite de la grille. Jusqu'ici, tout était parfait : j'avais les bonnes clés, les bons chiffres à placer en stock, et j'ai pu poser les 2/3 supérieurs droits. Mais là, voilà le hic : j'ai un compromis 3/5 que je ne peux résoudre sur les prochaines cases libres. Je pourrais résoudre en mettant un 1 en bas à gauche et gagner une clé supplémentaire, mais cette partie n'est pas accessible. Il me reste un 5 à poser... Tant pis, je tente le tout pour le tout et le pose sur une de mes 2 cases où j'hésite entre 3 et 5... BOUM ! C'était une erreur. Les chiffres des 2 cases adjacentes disparaissent et je me retrouve isolé sur la case en bas à gauche... mais... j'ai justement la possibilité de poser un 1 !

**Version condensée** : Tu es coincé en haut à droite, incapable d'atteindre la case qui résoudrait ton problème. Tu tentes un placement risqué... BOUM ! L'explosion te téléporte exactement où tu avais besoin d'être. Tu peux enfin poser ton 1 et continuer.

---

## Systèmes de jeu

### 1. Système de navigation

#### Règles de déplacement

- Le joueur peut se déplacer sur les cases adjacentes (haut/bas/gauche/droite)
- Le joueur doit posséder la **clé de couleur** correspondant au chiffre de la case
- Pas de déplacement en diagonal
- Vue du dessus (2D)

#### Clés de couleur

**Pour sudoku 4x4** :

- 4 couleurs : 🔴 Rouge (1), 🟢 Vert (2), 🔵 Bleu (3), 🟡 Jaune (4)
- 1 couleur = 1 chiffre
- Le joueur commence avec 1-2 clés (selon difficulté)

**Évolution future (5x5 ou 9x9)** :

- Regrouper plusieurs chiffres par couleur
- Ex : Rouge = 1,2,3 / Vert = 4,5,6 / Bleu = 7,8,9

#### Obtention des clés

Compléter une **série** donne 1 clé au choix du joueur :

- Ligne complète → +1 clé
- Colonne complète → +1 clé
- Bloc 2x2 complet → +1 clé

**Note importante** : Ce mécanisme risque de bloquer le joueur. Des tests papier détermineront si des ajustements sont nécessaires (ex : donner des clés aléatoires, ou permettre d'obtenir des clés autrement).

---

### 2. Système de placement de chiffres

#### Ressource : Indices 🔍

Le joueur collecte des **indices** qui lui permettent de poser des chiffres.

**Mécanique** :

- 1 indice = placer 1 chiffre (n'importe lequel de 1 à 4)
- Les indices ne sont pas liés à un chiffre spécifique
- Le joueur démarre avec 2-3 indices

#### Obtention d'indices

+2 indices pour chaque **série complétée** :

- Ligne complète → +2 indices
- Colonne complète → +2 indices
- Bloc 2x2 complet → +2 indices

**Question en suspend** : Est-ce que poser un bon chiffre (même sans compléter de série) donne aussi des indices ? À tester.

#### Action de placement

1. Le joueur se trouve sur une case vide
2. Il dépense 1 indice
3. Il choisit un chiffre (1, 2, 3 ou 4)
4. Il le place sur la case
5. Si c'est correct → rien de spécial, le jeu continue
6. Si c'est une erreur → événement aléatoire se déclenche

---

### 3. Système d'erreurs et d'événements

#### Compteur d'erreurs

- Les erreurs sont cumulatives (pas de limite stricte pour v0.1)
- Affichées comme un "score négatif"
- Évolution possible : limiter le nombre d'erreurs ou déclencher des malus

#### Événements d'erreur (aléatoires)

Quand le joueur place un mauvais chiffre, **1 événement parmi 3** se déclenche (33% chacun) :

**💥 Explosion locale**

- Efface les chiffres des 4 cases adjacentes (haut/bas/gauche/droite)
- Forme une croix (style Bomberman)
- Les cases vides ne sont pas affectées
- Les chiffres **pré-remplis** (donnés au début) sont **protégés** (ne peuvent pas être effacés)
- **Feedback visuel** : Flash rouge + animation de disparition + débris
- **Son** : "BOOM" satisfaisant

**🌀 Téléportation aléatoire**

- Déplace le joueur sur une case aléatoire **accessible** (où il possède la clé)
- Si aucune case accessible : le joueur **reste sur place** (téléportation échoue)
- **Feedback visuel** : Fade out → fade in à la nouvelle position
- **Son** : "Whoosh" ou effet de distorsion

**📉 Perte d'indices**

- Le joueur perd **1 indice**
- Si le joueur a 0 indices : rien ne se passe
- **Feedback visuel** : Compteur d'indices clignote en rouge + gros "-1" rouge qui descend en fade out
- **Son** : Effet négatif (cloche, buzzer)

#### Philosophie des événements

Les événements sont **majoritairement punitifs** mais peuvent **accidentellement** aider le joueur :

- Explosion peut effacer un mauvais placement et débloquer la situation
- Téléportation peut envoyer dans une zone autrement inaccessible
- Cette ambiguïté crée de la tension et des "moments magiques"

---

### 4. Condition de victoire

**Victoire** : Toutes les 16 cases sont remplies correctement (sudoku résolu).

**Défaite** : Aucune pour le moment (v0.1). Le joueur peut continuer indéfiniment tant qu'il a des indices.

**Score** : Nombre d'erreurs cumulées (plus bas = mieux).

---

## Boucle de gameplay

### Boucle principale (30 secondes - 1 minute)

1. **Observer** → Le joueur évalue la grille et ses possibilités de déplacement
2. **Se déplacer** → Il navigue vers une case vide stratégique (s'il a la clé)
3. **Déduire** → Il identifie quel chiffre placer (logique sudoku)
4. **Décider** → Place-t-il le chiffre maintenant ou explore-t-il d'abord ?
5. **Placer** → Il dépense 1 indice et pose un chiffre
6. **Réagir** →
   - Correct : de nouveaux chemins s'ouvrent
   - Erreur : gérer l'événement chaotique
7. **Progresser** → Compléter des séries donne clés + indices
8. Retour à 1

### Micro-décisions intéressantes

- "Est-ce que je place ce chiffre maintenant ou j'attends d'avoir plus d'infos ?"
- "Je suis bloqué, est-ce que je tente une erreur volontaire pour débloquer ?"
- "Quelle série je complète en premier pour optimiser mes gains ?"
- "Est-ce que j'explore ou je me concentre sur la résolution ?"

---

## Paramètres & Balance

### Grille et difficulté

**Prototype v0.1 : Grille 4x4**

- 16 cases au total
- Chiffres : 1, 2, 3, 4
- 4 couleurs de clés
- Règles : chaque ligne, colonne et bloc 2x2 contient 1, 2, 3, 4

**Pré-remplissage** : 5-6 cases

- Respecte les règles du sudoku
- Assure qu'une solution unique existe
- Réparti pour ne pas bloquer la navigation initiale

**Évolution possible** : 5x5 si 4x4 s'avère trop simple ou court

### État initial du joueur

**Clés** : 1-2 clés au départ (selon difficulté)

- Facile : 2 clés (ex : 🔴1 et 🔵3)
- Normal : 1 clé (ex : 🔴1)

**Indices** : 2-3 indices au départ

- À ajuster selon les tests

### Paramètres à tuner (après tests)

- Nombre d'indices au départ
- Nombre de clés au départ
- Nombre d'indices gagnés par série (actuellement 2)
- Probabilités des événements d'erreur (actuellement 33/33/33)
- Intensité des événements (ex : explosion 4 ou 8 cases ?)
- Nombre de cases pré-remplies

---

## Références & Inspirations

### Jeux similaires conceptuellement

**Baba Is You** (2019)

- Méta-puzzle où résoudre change les règles de navigation
- Principe le plus proche de lab-doku
- **Leçon** : Les systèmes émergents créent des moments magiques

**The Witness** (2016)

- Résoudre des puzzles débloque l'exploration
- Principe : solution → accès à nouveaux espaces
- **Leçon** : L'environnement peut être le puzzle lui-même

**Puzzle Quest** (2007)

- Match-3 + RPG, pionnier des mélanges de genres
- **Leçon** : Deux systèmes qui se nourrissent mutuellement = succès

**Stephen's Sausage Roll** (2016)

- Puzzle spatial avec mouvements limités
- Chaque action a des conséquences irréversibles
- **Leçon** : Contraintes fortes = décisions intéressantes

### Ce qui n'existe pas (à notre connaissance)

Aucun jeu n'a fusionné **sudoku + navigation spatiale intégrée** comme lab-doku le propose. Le territoire est vierge.

### Cracking the Cryptic

Chaîne YouTube de référence pour les variantes de sudoku :

- Miracle Sudoku
- Thermo Sudoku
- Sandwich Sudoku

**Leçon** : Le sudoku classique peut être enrichi de contraintes créatives.

---

## Prototype papier

### Objectif

Valider les mécaniques core **avant de coder** :

- Est-ce que le jeu est jouable du début à la fin ?
- Est-ce que je me sens bloqué trop souvent ?
- Est-ce que je prends des décisions intéressantes ?
- Est-ce que les événements d'erreur ajoutent du fun ou de la frustration ?

### Matériel

Voir le fichier `prototypes/paper/LABDOKU_PROTOTYPE_PAPIER.md` pour :

- 2 scénarios prêts à jouer
- 3 grilles vierges
- Jetons à découper (joueur, clés, indices, marqueurs)
- Journal de test
- Checklist de validation

### Variantes à tester

- **Variante A** : Moins d'indices au départ (1 au lieu de 3)
- **Variante B** : Plus de clés au départ (3 au lieu de 2)
- **Variante C** : Événements plus sévères (explosion 8 cases, perte 2 indices)
- **Variante D** : Pas d'événements aléatoires (juste compteur d'erreurs)

---

## Prochaines étapes

### Phase 3 : Tests papier (en cours)

- [ ] Jouer au moins 3 parties complètes
- [ ] Tester les 4 variantes
- [ ] Noter les observations dans le journal
- [ ] Identifier les problèmes majeurs de game design
- [ ] Décision GO/NO-GO pour le proto digital

### Phase 4 : Prototype digital (à venir)

**Si les tests papier sont concluants** :

**Scope minimal (proto 0.1)** :

- Grille 4x4 avec 5-6 chiffres pré-remplis (hardcodés)
- Système de déplacement et clés
- Placement de chiffres et vérification
- 3 événements d'erreur
- UI minimaliste (compteurs, grille claire)
- Assets placeholder (carrés colorés + emojis)

**Durée estimée** : 2-3 semaines de dev (quelques sessions)

**Technologie** : Godot 4.x + GDScript

**Livrables** :

- Proto jouable de A à Z
- 2-3 grilles hardcodées
- Feedbacks visuels basiques
- Tests avec 3-5 personnes

### Phase 5 : Itérations

- Ajustement des paramètres selon les retours
- Génération procédurale de grilles
- Amélioration UI/UX
- Polish visuel et audio
- Nouveaux événements si nécessaire

---

## Journal de développement

### 2025-11-08 : Conception initiale

**Session de design (5h)**

- Élaboration du concept core (sudoku + navigation)
- Définition des mécaniques (clés, indices, événements)
- Création du prototype papier
- Rédaction de la documentation

**Décisions clés** :

- Vue du dessus (pas FPS) pour simplicité
- Grille 4x4 pour commencer
- Événements d'erreur aléatoires (option A)
- Erreurs cumulatives sans limite stricte
- Thème enquêteur-démineur

**Prochaine session** : Tests papier avec impression et découpage

---

## Backlog d'idées (post-MVP)

### Mécaniques additionnelles

- **Notes dans les cases** (comme sudoku papier) quand hésitation
- **Système de hints** (révèle 1 chiffre contre coût élevé)
- **Pression temporelle** : minuteur ou ennemi qui se rapproche
- **Variantes de collecte** :
  - Spawn aléatoire d'indices sur la grille (à ramasser)
  - Jauge d'énergie pour placer des chiffres

### Évolution du thème

- Développer la narration (histoire du poseur de bombes)
- Cutscenes entre les niveaux
- Environnements variés (laboratoire, bunker, etc.)

### Contenu

- Mode histoire avec progression
- Mode puzzle (grilles pré-conçues avec défis spécifiques)
- Mode endless (grilles générées à l'infini)
- Leaderboards (temps, erreurs)

### Polish

- Art style cohérent (low-poly ? pixel art ? flat design ?)
- Musique et sound design complets
- Animations polish
- Effets de particules

---

## Risques & Mitigations

### Risques identifiés

1. **Blocage du joueur**
   - Peut manquer de clés/indices et ne plus pouvoir progresser
   - **Mitigation** : Tests papier intensifs + ajustements paramètres + possibilité de "reset" une grille

2. **Complexité cognitive trop élevée**
   - Jongler entre logique sudoku + navigation spatiale + gestion ressources
   - **Mitigation** : Commencer 4x4 (simple), UI très claire, tutoriel progressif

3. **Événements trop chaotiques/frustrants**
   - Les erreurs peuvent démolir une partie bien engagée
   - **Mitigation** : Tests utilisateurs, ajustement probabilités, option "undo" ?

4. **Durée de jeu inadéquate**
   - Trop court (< 3 min) = pas assez de tension
   - Trop long (> 15 min) = fatigue cognitive
   - **Mitigation** : Grilles de différentes tailles, tests de durée

5. **Manque de rejouabilité**
   - Une fois la grille résolue, pourquoi rejouer ?
   - **Mitigation** : Génération procédurale, modes variés, scoring/leaderboards

---

## Critères de succès

### Proto papier (Phase 3)

- [ ] Le jeu est jouable du début à la fin sans bloquer
- [ ] Durée moyenne : 5-15 minutes
- [ ] Le testeur comprend les règles en < 3 minutes
- [ ] Au moins 1 "moment magique" émerge naturellement
- [ ] Le testeur veut rejouer après 1 partie
- [ ] Fun rating > 6/10

### Proto digital (Phase 4)

- [ ] 3-5 personnes l'ont testé et compris
- [ ] Taux de complétion > 70%
- [ ] Temps moyen : 7-12 minutes
- [ ] Au moins 2 retours positifs spontanés
- [ ] Pas de bugs bloquants
- [ ] Le core loop est satisfaisant

---

**Document vivant - Sera mis à jour au fur et à mesure du développement**

*Dernière mise à jour : 2025-11-08*
