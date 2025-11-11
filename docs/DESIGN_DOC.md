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

#### Navigation sur cases vides (règle spéciale)

**Règle validée par tests papier** :

- Une fois un chiffre posé sur une case vide, le joueur peut **rester sur cette case même sans posséder la clé correspondante**
- Une fois sorti de la case, impossible d'y revenir sans posséder la clé du chiffre
- **Justification** : Permet de débloquer des situations où les clés initiales ne donnent accès à aucun chemin
- **Impact tactique** : Crée des décisions stratégiques (placer un chiffre ouvre un chemin mais peut piéger si on sort)
- **Exemples d'usage** :
  - Pont temporaire : Placer un "3" pour traverser une zone inaccessible, mais ne pas pouvoir revenir sans clé bleue
  - Déblocage : Être coincé avec clés 1 et 3 (jamais adjacentes) → placer un chiffre sur case vide pour progresser

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

#### Ressource : Jetons indices numérotés 🔍

Le joueur collecte des **jetons indices numérotés** (1, 2, 3, 4) qui lui permettent de poser des chiffres.

**Mécanique** :

- Chaque jeton indice porte un chiffre spécifique (1, 2, 3 ou 4)
- Des jetons indices sont posés initialement sur certaines cases de la grille
- Quand le joueur passe sur une case avec un jeton, il le **ramasse automatiquement**
- Les jetons ramassés vont dans l'**inventaire** (capacité illimitée)
- **Contrainte** : Total (grille + inventaire) ≤ 4 pour chaque chiffre
  - Exemple : Si 3×"2" sont déjà sur la grille, le joueur ne peut avoir que 1×"2" max dans son inventaire
- **État initial** : Le joueur démarre avec **2 indices aléatoires** dans son inventaire
  - Procédure de tirage : Si tirage invalide (dépasse contrainte 4 max), défausser et repiocher
  - **Justification** : Sans indices au départ, impossible de se déplacer vers les cases vides (blocage critique)

#### Obtention d'indices

**Gain par placement correct** (nouveau mécanisme validé) :

- À chaque chiffre correct posé → **+1 indice aléatoire**
- **Justification** : Compense les pertes d'erreur, crée un cycle risque/récompense
- Les indices sont générés aléatoirement (1-4 avec contrainte ≤4 par chiffre)

**Gain par série complétée** :

- **Variante A** : +1 indice aléatoire
- **Variante B** : +2 indices aléatoires (version proto papier actuelle)
- **Variante C** : +X indices (à déterminer selon tests)

**Note** : Les deux mécanismes (placement + série) sont cumulatifs. Paramètres à ajuster selon tests de durée.

#### Action de placement

1. Le joueur se trouve sur une **case vide**
2. **Options** :
   - **Placer un chiffre** de son inventaire :
     - Choisit un jeton parmi ses indices disponibles
     - Place le chiffre sur la case
     - **Si correct** → le chiffre reste, le jeton est consommé
     - **Si erreur** → événement aléatoire se déclenche
   - **Annuler** : Recule sur la case précédente (pas de placement)

---

### 3. Système d'erreurs et d'événements

#### Compteur d'erreurs

- Les erreurs sont cumulatives (pas de limite stricte pour v0.1)
- Affichées comme un "score négatif"
- Évolution possible : limiter le nombre d'erreurs ou déclencher des malus

#### Événements d'erreur (système révisé suite aux tests)

Quand le joueur place un mauvais chiffre, **un événement se déclenche**. La distribution a été révisée suite aux tests papier pour privilégier la tension sur les ressources :

**Nouveau système** (paramètres à ajuster en proto digital) :

**💥 Explosion locale** (ÉVÉNEMENT OPTIONNEL)

- Efface les chiffres des 4 cases adjacentes (haut/bas/gauche/droite) - ou 8 cases en mode sévère
- Forme une croix (style Bomberman)
- Les cases vides ne sont pas affectées
- Les chiffres **pré-remplis** (donnés au début) sont **protégés** (ne peuvent pas être effacés)
- **Feedback visuel** : Flash rouge + animation de disparition + débris
- **Son** : "BOOM" satisfaisant
- **Probabilité suggérée** : 0-10% (à décider si conservé, testé en version sévère = jouable)

**🌀 Téléportation aléatoire** (ÉVÉNEMENT SECONDAIRE)

- Déplace le joueur sur une case **pré-remplie** aléatoire (pas forcément accessible)
- Peut accidentellement aider le joueur en le déplaçant vers une zone stratégique
- **Feedback visuel** : Fade out → fade in à la nouvelle position
- **Son** : "Whoosh" ou effet de distorsion
- **Probabilité suggérée** : 10-30% (événement occasionnel pour créer moments émergents)

**📉 Perte d'indices** (ÉVÉNEMENT PRINCIPAL)

- Le joueur perd **1 indice de son inventaire** (au hasard)
- **Si le joueur a 0 indices** : Game Over (voir condition de défaite)
- **Feedback visuel** : Compteur d'indices clignote en rouge + gros "-1" rouge qui descend en fade out
- **Son** : Effet négatif (cloche, buzzer)
- **Probabilité suggérée** : 60-100% (événement principal pour créer tension sur ressources)

#### Philosophie des événements

Les événements sont **majoritairement punitifs** mais peuvent **accidentellement** aider le joueur :

- Explosion peut effacer un mauvais placement et débloquer la situation
- Téléportation peut envoyer dans une zone autrement inaccessible
- Cette ambiguïté crée de la tension et des "moments magiques"

---

### 4. Conditions de victoire et de défaite

**Victoire** : Toutes les 16 cases sont remplies correctement (sudoku résolu).

**Défaite** (nouvelle règle validée) : **Game Over si inventaire vide**

- Si le joueur n'a plus aucun indice chiffré dans son inventaire → **Game Over**
- Impossible de se déplacer vers une case vide ou de placer un chiffre
- **Justification** : Crée une vraie tension et un risque d'échec
- **Impact** : Transforme la perte d'indice en événement critique
- **Équilibrage** : Compensé par gain d'indice à chaque placement correct

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
   - Correct : de nouveaux chemins s'ouvrent + **gain d'1 indice**
   - Erreur : gérer l'événement (principalement perte d'indice)
7. **Vérifier** → Inventaire vide ? → Game Over
8. **Progresser** → Compléter des séries donne clés + indices bonus
9. Retour à 1

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

- Facile : 3 clés (ex : 🔴1, 🟢2, 🔵3) - testé, bon pour débutants
- Normal : 2 clés (ex : 🔴1 et 🔵3) - standard validé
- Difficile : 1 clé (ex : 🔴1) - testé, très restrictif, bon pour mode challenge

**Indices** : **2 indices aléatoires** au départ (règle validée)

- Tirage aléatoire avec contrainte ≤4 par chiffre (grille + inventaire)
- Si tirage invalide : défausser et repiocher
- **Justification** : Résout le blocage initial (impossible d'avancer sans indices)

### Paramètres validés (tests papier)

- **Indices au départ** : 2 indices aléatoires (fixé)
- **Clés au départ** : 2 clés standard (1 ou 3 pour modes difficulté)
- **Contrainte inventaire** : ≤4 par chiffre (validé)
- **Gain par placement correct** : +1 indice (nouveau mécanisme)
- **Game Over** : Inventaire vide (nouveau)

### Paramètres à tuner (proto digital)

- Probabilités des événements d'erreur :
  - **Recommandation initiale** : 70% Perte / 30% Téléportation / 0% Explosion
  - À ajuster selon tests utilisateurs
- Nombre d'indices gagnés par série complétée (actuellement 1-2, à tester)
- Nombre de jetons indices posés sur la grille initialement (position et valeurs)
- Intensité explosion si conservée (4 ou 8 cases)
- Nombre de cases pré-remplies (actuellement 5-6)
- Durée timer par série (si implémenté)

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

## Systèmes de difficulté avancée (Post-MVP)

### Timer par série ⭐ PRIORITÉ

**Problème identifié** : Parties trop courtes (2 min), manque de pression temporelle.

**Mécanique** :

- Chaque série (ligne/colonne/bloc 2x2) dispose d'un **compte à rebours indépendant**
- À zéro : la série correspondante **explose** (tous les chiffres non pré-remplis disparaissent)
- Force l'ordre de résolution et maintient la pression constante
- Crée des dilemmes : résoudre vite vs. résoudre sans erreur

**Paramètres à définir** :

- Durée initiale du timer (30s ? 60s ? variable ?)
- UI : barre de progression, compte à rebours numérique
- Son d'alerte avant expiration
- Pause du timer pendant événements ?

**Justification** : Solution principale pour augmenter durée et difficulté sans agrandir la grille.

---

### Grilles progressives ⭐ PRIORITÉ

**Problème identifié** : Grille 4x4 trop simple, épuisée en 2 minutes.

**Progression proposée** :

1. **4x4** (tutoriel/débutant) : 16 cases, 4 chiffres, 4 clés
2. **5x5** (intermédiaire) : 25 cases, 5 chiffres, 5 clés
3. **6x6** (avancé) : 36 cases, 6 chiffres, 6 clés
4. **9x9** (expert - lointain) : 81 cases, 9 chiffres, regroupement de clés nécessaire

**Implications techniques** :

- Système de clés : 1 clé = 1 chiffre jusqu'à 6x6
- 9x9 nécessite regroupement (Rouge = 1,2,3 / Vert = 4,5,6 / Bleu = 7,8,9)
- Génération de grilles valides (algorithme sudoku)
- Scaling de l'UI et de la caméra

**Justification** : Augmente naturellement complexité et durée sans changer les mécaniques core.

---

### Autres idées (tests papier)

#### Poseur de bombe adverse

- IA qui se déplace sur la grille
- Crée des zones dangereuses ou objectifs de capture
- Si capturé : victoire bonus ou ressources supplémentaires

#### Mode multijoueur

- **Coopératif** : 2 joueurs partagent une grille, se coordonnent
- **Compétitif** : 2 grilles séparées, course au temps/score
- **Impact** : Les décisions d'un joueur influent sur l'autre

**Statut** : Concepts validés intéressants, mais très post-MVP.

---

## Prototype papier

### Objectif

Valider les mécaniques core **avant de coder** :

- Est-ce que le jeu est jouable du début à la fin ?
- Est-ce que je me sens bloqué trop souvent ?
- Est-ce que je prends des décisions intéressantes ?
- Est-ce que les événements d'erreur ajoutent du fun ou de la frustration ?

### Matériel (spécifique au proto papier)

Voir le fichier `prototypes/paper/LABDOKU_PROTOTYPE_PAPIER.md` pour :

- 2 scénarios prêts à jouer avec solutions
- Grilles vierges réutilisables
- Jetons à découper (pion joueur, jetons indices numérotés 1-4, tracker de clés, marqueurs d'événements)
- Dés physiques : D4 (génération aléatoire d'indices) et D6 (événements d'erreur)
- Checklist de validation

**Note** : En version digitale, les dés sont remplacés par de la génération aléatoire programmatique.

### Résultats des tests

**Date** : Novembre 2025
**Testeur** : Bastien
**Verdict** : ✅ **GO VALIDÉ** avec ajustements

Voir le rapport complet : [`docs/PAPER_PROTOTYPE_TEST_RESULTS.md`](PAPER_PROTOTYPE_TEST_RESULTS.md)

**Synthèse** :

- ✅ Concept jouable de bout en bout avec ajustements
- ✅ Règles claires et comprises immédiatement
- ✅ Synergie résolution/navigation fonctionne bien
- ⚠️ Durée trop courte (2 min au lieu de 5-15 min)
- ⚠️ Difficulté insuffisante (sensation de tutoriel)
- ⚠️ Rejouabilité mitigée

**Règles validées et modifiées** :

1. **Navigation sur case vide** : Pouvoir rester après placement sans clé
2. **Démarrage avec 2 indices aléatoires** (contrainte 4 max)
3. **Game Over si inventaire vide** (nouvelle condition de défaite)
4. **Événements d'erreur** : Perte d'indice principale + Téléportation occasionnelle
5. **Gain d'indice par placement correct** : +1 indice (nouveau mécanisme)

**Solutions pour proto digital** :

- Timer par série pour augmenter difficulté et durée
- Grilles progressives (4x4 → 5x5 → 6x6)
- Effets visuels et sonores pour renforcer événements

### Variantes à tester

- **Variante A** : Moins d'indices au départ (1 au lieu de 3)
- **Variante B** : Plus de clés au départ (3 au lieu de 2)
- **Variante C** : Événements plus sévères (explosion 8 cases, perte 2 indices)
- **Variante D** : Pas d'événements aléatoires (juste compteur d'erreurs)

---

## Prochaines étapes

### Phase 3 : Tests papier ✅ COMPLÉTÉ

- [x] Jouer au moins 3 parties complètes
- [x] Tester les variantes
- [x] Noter les observations dans le journal
- [x] Identifier les problèmes majeurs de game design
- [x] Décision GO/NO-GO pour le proto digital → **GO VALIDÉ**

**Résultats** : Voir [`docs/PAPER_PROTOTYPE_TEST_RESULTS.md`](PAPER_PROTOTYPE_TEST_RESULTS.md)

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

### 2025-11-11 : Tests papier complétés ✅ GO VALIDÉ

**Session de test (3h)**

- Tests du prototype papier avec plusieurs parties
- Identification de 2 blocages critiques (résolus)
- Validation du concept core
- Décision GO pour prototype digital

**Problèmes critiques résolus** :

1. **Blocage initial** : Impossible d'avancer sans indices
   - Solution : Démarrage avec 2 indices aléatoires (contrainte 4 max)

2. **Blocage par clés non-adjacentes** : Clés 1 et 3 ne se touchent jamais
   - Solution : Pouvoir rester sur case vide après placement sans clé

**Ajustements majeurs** :

- **Game Over** : Inventaire vide = défaite (nouvelle règle)
- **Gain d'indice** : +1 à chaque placement correct (nouveau mécanisme)
- **Événements d'erreur** : Perte d'indice principale (60-100%) + Téléportation occasionnelle (10-30%)
- **Modes difficulté** : 1, 2 ou 3 clés au départ (tous testés et validés)

**Observations** :

- Durée trop courte : 2 min max (cible 5-15 min)
- Difficulté insuffisante : sensation de tutoriel
- Synergie résolution/navigation excellente
- Événements créent équilibre frustration/fun intéressant

**Solutions pour proto digital** :

1. **Timer par série** (priorité) : Compte à rebours → explosion
2. **Grilles progressives** (priorité) : 4x4 → 5x5 → 6x6
3. Effets visuels/sonores pour renforcer immersion

**Décisions de design finales** :

- Navigation sur case vide : règle formalisée ✅
- État initial : 2 clés + 2 indices aléatoires ✅
- Game Over : inventaire vide ✅
- Événements : Perte principale + Téléportation secondaire ✅
- Récompense : +1 indice par placement + bonus séries ✅

**Rapport complet** : [`docs/PAPER_PROTOTYPE_TEST_RESULTS.md`](PAPER_PROTOTYPE_TEST_RESULTS.md)

**Prochaine session** : Création des spécifications techniques Godot

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

### Proto papier (Phase 3) ✅ VALIDÉ

- [x] Le jeu est jouable du début à la fin sans bloquer (avec ajustements)
- [⚠️] Durée moyenne : 2 minutes (trop court, cible 5-15 min)
- [x] Le testeur comprend les règles en < 3 minutes
- [x] Au moins 1 "moment magique" émerge naturellement
- [⚠️] Le testeur veut rejouer après 1 partie (mitigé, nécessite plus de difficulté)
- [x] Fun rating > 6/10 (concept validé)

### Proto digital (Phase 4)

- [ ] 3-5 personnes l'ont testé et compris
- [ ] Taux de complétion > 70%
- [ ] Temps moyen : 7-12 minutes
- [ ] Au moins 2 retours positifs spontanés
- [ ] Pas de bugs bloquants
- [ ] Le core loop est satisfaisant

---

**Document vivant - Sera mis à jour au fur et à mesure du développement**

*Dernière mise à jour : 2025-11-11 (Tests papier complétés, règles validées)*
