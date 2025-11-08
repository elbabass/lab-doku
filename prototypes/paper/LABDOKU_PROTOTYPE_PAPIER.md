# LAB-DOKU - Kit de Prototype Papier

## 📋 Instructions de test

### Matériel nécessaire

- Cette feuille imprimée
- Un crayon/stylo
- Des ciseaux (pour découper les jetons)
- Optionnel : des dés à 6 faces pour simuler l'aléatoire

### Comment jouer

1. Découpe les jetons en bas de page
2. Choisis un scénario ou utilise une grille vierge
3. Place ton pion 🚶 sur une case de départ
4. Déplace-toi et place des chiffres selon les règles
5. Note tes observations et impressions

---

## 🎮 RÈGLES DU JEU

### Déplacement

- Tu peux SEULEMENT te déplacer sur une case adjacente (haut/bas/gauche/droite)
- Tu dois POSSÉDER la clé de couleur correspondant au chiffre de la case

### Placement de chiffres

- Coûte 1 🔍 indice
- Tu peux placer n'importe quel chiffre sur une case vide où tu te trouves
- Si c'est correct → bien !
- Si c'est une erreur → événement aléatoire (lance un dé)

### Récompenses

- Compléter une LIGNE : +2 🔍 indices + 1 🔑 clé (au choix)
- Compléter une COLONNE : +2 🔍 indices + 1 🔑 clé (au choix)
- Compléter un BLOC 2x2 : +2 🔍 indices + 1 🔑 clé (au choix)

### Événements d'erreur (lance 1d6)

- **1-2 : 💥 Explosion** → Efface les 4 cases adjacentes (croix)
- **3-4 : 🌀 Téléportation** → Place ton pion sur une case aléatoire accessible
- **5-6 : 📉 Perte** → Perds 1 🔍 indice

### Victoire

- Toutes les 16 cases sont remplies correctement !

---

## 🎲 SCÉNARIO 1 : Démarrage standard

### Grille de départ (5 chiffres pré-remplis)

```
┌───┬───┬───┬───┐
│   │   │   │   │
│ 1 │   │ 3 │   │
├───┼───┼───┼───┤
│   │   │   │   │
│   │ 3 │   │ 1 │
├───┼───┼───┼───┤
│   │   │   │   │
│ 3 │   │ 1 │   │
├───┼───┼───┼───┤
│   │   │   │   │
│   │ 1 │   │ 3 │
└───┴───┴───┴───┘
```

**Solution complète** (pour référence - ne regarde pas pendant le jeu !)

```
┌───┬───┬───┬───┐
│   │   │   │   │
│ 1 │ 2 │ 3 │ 4 │
├───┼───┼───┼───┤
│   │   │   │   │
│ 4 │ 3 │ 2 │ 1 │
├───┼───┼───┼───┤
│   │   │   │   │
│ 3 │ 4 │ 1 │ 2 │
├───┼───┼───┼───┤
│   │   │   │   │
│ 2 │ 1 │ 4 │ 3 │
└───┴───┴───┴───┘
```

**État initial du joueur**

- Position de départ : Case (0,0) - le 1 en haut à gauche
- Clés possédées : 🔑1 (rouge), 🔑3 (bleu)
- Indices : 🔍🔍🔍 (3 indices)

**Questions à te poser pendant le test**

- [ ] Est-ce que je me sens bloqué rapidement ?
- [ ] Est-ce que placer un chiffre change vraiment ma navigation ?
- [ ] Est-ce que les événements d'erreur sont intéressants ou juste frustrants ?
- [ ] Combien de temps ça prend pour finir ?
- [ ] Est-ce que je réfléchis stratégiquement ou je place au hasard ?

---

## 🎲 SCÉNARIO 2 : Situation tendue (milieu de partie)

### Grille en cours

```
┌───┬───┬───┬───┐
│   │   │   │   │
│ 1 │ 2 │ 3 │ 4 │
├───┼───┼───┼───┤
│   │   │   │   │
│ 4 │ 3 │   │   │  ← Tu es ICI
├───┼───┼───┼───┤
│   │   │   │   │
│ 3 │   │ 1 │   │
├───┼───┼───┼───┤
│   │   │   │   │
│   │ 1 │   │ 3 │
└───┴───┴───┴───┘
```

**État actuel**

- Position : Case (1,2) - à droite du 3
- Clés : 🔑1, 🔑3, 🔑4
- Indices : 🔍 (1 seul !)
- Situation : Tu dois compléter la ligne 2, mais tu n'as qu'un indice
- Tu hésites entre placer un 2 ou un 1 sur ta case actuelle

**Challenge**

- Si tu te trompes, tu risques une explosion ou téléportation
- Si tu ne fais rien, tu es coincé (pas de clé 2 pour explorer)
- Que fais-tu ?

---

## 📐 GRILLES VIERGES (pour tes propres tests)

### Grille vierge #1

```
┌───┬───┬───┬───┐
│   │   │   │   │
│   │   │   │   │
├───┼───┼───┼───┤
│   │   │   │   │
│   │   │   │   │
├───┼───┼───┼───┤
│   │   │   │   │
│   │   │   │   │
├───┼───┼───┼───┤
│   │   │   │   │
│   │   │   │   │
└───┴───┴───┴───┘
```

### Grille vierge #2

```
┌───┬───┬───┬───┐
│   │   │   │   │
│   │   │   │   │
├───┼───┼───┼───┤
│   │   │   │   │
│   │   │   │   │
├───┼───┼───┼───┤
│   │   │   │   │
│   │   │   │   │
├───┼───┼───┼───┤
│   │   │   │   │
│   │   │   │   │
└───┴───┴───┴───┘
```

### Grille vierge #3

```
┌───┬───┬───┬───┐
│   │   │   │   │
│   │   │   │   │
├───┼───┼───┼───┤
│   │   │   │   │
│   │   │   │   │
├───┼───┼───┼───┤
│   │   │   │   │
│   │   │   │   │
├───┼───┼───┼───┤
│   │   │   │   │
│   │   │   │   │
└───┴───┴───┴───┘
```

---

## ✂️ JETONS À DÉCOUPER

### Pion joueur

```
┌──┐
│🚶│
└──┘
JOUEUR
```

### Clés (découpe 4 jetons par couleur)

```
┌────┐ ┌────┐ ┌────┐ ┌────┐
│ 🔴 │ │ 🔴 │ │ 🔴 │ │ 🔴 │
│ 🔑1│ │ 🔑1│ │ 🔑1│ │ 🔑1│
└────┘ └────┘ └────┘ └────┘

┌────┐ ┌────┐ ┌────┐ ┌────┐
│ 🟢 │ │ 🟢 │ │ 🟢 │ │ 🟢 │
│ 🔑2│ │ 🔑2│ │ 🔑2│ │ 🔑2│
└────┘ └────┘ └────┘ └────┘

┌────┐ ┌────┐ ┌────┐ ┌────┐
│ 🔵 │ │ 🔵 │ │ 🔵 │ │ 🔵 │
│ 🔑3│ │ 🔑3│ │ 🔑3│ │ 🔑3│
└────┘ └────┘ └────┘ └────┘

┌────┐ ┌────┐ ┌────┐ ┌────┐
│ 🟡 │ │ 🟡 │ │ 🟡 │ │ 🟡 │
│ 🔑4│ │ 🔑4│ │ 🔑4│ │ 🔑4│
└────┘ └────┘ └────┘ └────┘
```

### Indices (découpe 10-15 jetons)

```
┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐
│🔍 │ │🔍 │ │🔍 │ │🔍 │ │🔍 │
│IND│ │IND│ │IND│ │IND│ │IND│
└───┘ └───┘ └───┘ └───┘ └───┘

┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐
│🔍 │ │🔍 │ │🔍 │ │🔍 │ │🔍 │
│IND│ │IND│ │IND│ │IND│ │IND│
└───┘ └───┘ └───┘ └───┘ └───┘

┌───┐ ┌───┐ ┌───┐ ┌───┐ ┌───┐
│🔍 │ │🔍 │ │🔍 │ │🔍 │ │🔍 │
│IND│ │IND│ │IND│ │IND│ │IND│
└───┘ └───┘ └───┘ └───┘ └───┘
```

### Marqueurs d'événements

```
┌──────┐ ┌──────┐ ┌──────┐
│  💥  │ │  🌀  │ │  📉  │
│EXPLO │ │TÉLÉP │ │PERTE │
└──────┘ └──────┘ └──────┘
```

### Compteur d'erreurs (coche à chaque erreur)

```
┌─────────────────────┐
│ ERREURS CUMULÉES    │
│                     │
│ ☐ ☐ ☐ ☐ ☐          │
│ ☐ ☐ ☐ ☐ ☐          │
│                     │
│ Total : _____       │
└─────────────────────┘
```

---

## 📝 JOURNAL DE TEST

Après avoir joué, note tes observations :

### Ce qui a bien fonctionné

```
- 
- 
- 
```

### Ce qui était frustrant

```
- 
- 
- 
```

### Surprises / moments intéressants

```
- 
- 
- 
```

### Modifications suggérées

```
- 
- 
- 
```

### Temps de jeu

```
Début : ______
Fin : ______
Durée totale : ______ minutes
```

### Score final

```
Erreurs commises : ______
Grille complétée : ☐ Oui  ☐ Non
```

---

## 🎯 VARIANTES À TESTER

Une fois que tu as testé le scénario de base, essaie ces variations :

### Variante A : Moins d'indices au départ

- Démarrer avec seulement 1 indice au lieu de 3
- Plus tendu, force à être stratégique dès le début

### Variante B : Plus de clés au départ

- Démarrer avec 3 clés (1, 2, 3) au lieu de 2
- Plus de liberté d'exploration, moins de blocage

### Variante C : Événements plus sévères

- Explosion : efface aussi les diagonales (8 cases)
- Perte : perd 2 indices au lieu de 1

### Variante D : Pas d'événements aléatoires

- Les erreurs ne causent rien de spécial
- Juste un compteur d'erreurs
- Pour tester si les événements apportent vraiment au gameplay

---

## 🔍 CHECKLIST DE VALIDATION

Après 2-3 parties de test, réponds à ces questions :

**Gameplay de base**

- [ ] Est-ce que le jeu est jouable du début à la fin ?
- [ ] Est-ce que je me sens bloqué trop souvent ?
- [ ] Est-ce que je comprends les règles sans relire plusieurs fois ?

**Tension et intérêt**

- [ ] Est-ce que je prends des décisions intéressantes ?
- [ ] Est-ce que j'anticipe mes prochains coups ?
- [ ] Est-ce que les événements d'erreur ajoutent du fun ou juste de la frustration ?

**Rythme**

- [ ] Durée de jeu : trop court / bon / trop long ?
- [ ] Est-ce que je veux rejouer après une partie ?

**Prochaine étape**

- [ ] Le concept tient → on peut commencer à coder
- [ ] Il faut ajuster certaines règles → lesquelles ?
- [ ] Ça ne marche pas → pivot ou abandon ?

---

**Bon test ! 🎮**

N'hésite pas à annoter directement sur la feuille imprimée, gribouiller, rayer, modifier les règles à la volée. C'est fait pour ça.
