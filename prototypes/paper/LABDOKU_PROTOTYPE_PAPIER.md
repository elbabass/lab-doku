# LAB-DOKU - Prototype Papier

**Guide de test pour valider les mécaniques core avant développement**

---

## 📦 Matériel

### Fichier imprimable

Le kit complet est disponible dans **`LABDOKU_PROTOTYPE_PAPIER_v1_tables.typ`** (5 pages) :

- **Page 1** : 2 scénarios de test (solution dans ce fichier MD)
- **Page 2** : 2 grilles vierges (réimprimable si besoin)
- **Page 3** : 16 jetons indices chiffrés (4×"1", 4×"2", 4×"3", 4×"4")
- **Page 4** : Matériel complet (pion, tracker de clés, marqueurs, compteur)
- **Page 5** : Checklist de validation

### Compilation et impression

```bash
# Compiler le PDF (nécessite Typst installé)
typst compile LABDOKU_PROTOTYPE_PAPIER_v1_tables.typ

# Le PDF généré : LABDOKU_PROTOTYPE_PAPIER_v1_tables.pdf
```

**Impression recommandée** :

- **Couleur obligatoire** (chiffres colorés dans les grilles + tracker de clés 🔴🟢🔵🟡)
- Papier 120g si possible (pion et marqueurs plus durables)
- Recto-verso optionnel (4 pages → 2 feuilles)

### Matériel supplémentaire

- Ciseaux (pour découper le pion, marqueurs et jetons indices)
- Stylo/crayon (pour remplir les grilles et cocher les clés)
- **1 dé à 4 faces (D4)** pour générer les indices en récompense
- 1 dé à 6 faces (D6) pour les événements d'erreur aléatoires

---

## 🎮 RÈGLES DU JEU

### Déplacement

- Tu peux **seulement** te déplacer sur une case adjacente (haut/bas/gauche/droite)
- Tu dois **posséder** la clé de couleur correspondant au chiffre de la case
- Exemple : Pour aller sur une case "3", tu dois avoir la clé 🔵 (bleue)
- Tu peux avancer sur une **case vide**, mais tu devras alors placer un chiffre ou annuler

### Collection d'indices chiffrés

- Des **jetons indices** (chiffres 1-4) sont posés sur certaines cases de la grille
- Quand tu passes sur une case avec un jeton indice, tu le **ramasses automatiquement**
- Les indices ramassés vont dans ton **inventaire** (illimité)
- **Contrainte** : Total (grille + inventaire) ≤ 4 pour chaque chiffre
  - Exemple : Si 3×"2" sont déjà sur la grille, tu ne peux avoir que 1×"2" max dans ton inventaire

### Placement de chiffres sur case vide

1. Tu te déplaces sur une **case vide**
2. **Options** :
   - **Placer un chiffre** de ton inventaire :
     - Choisis un chiffre parmi tes indices disponibles
     - Place-le sur la case
     - **Si correct** → le chiffre reste, l'indice est consommé
     - **Si erreur** → lance 1d6 pour l'événement aléatoire :
       - **1-2 : 💥 Explosion** → Efface les 4 cases adjacentes (croix)
       - **3-4 : 🌀 Téléportation** → Déplace ton pion sur une case pré-remplie aléatoire accessible
       - **5-6 : 📉 Perte** → Perds 1 indice de ton inventaire (au hasard)
   - **Annuler** : Recule sur la case précédente (pas de placement)

### Récompenses (compléter une série)

Quand tu complètes une **ligne**, **colonne** ou **bloc 2×2** :

- +1 🔑 clé (au choix parmi les 4 couleurs) - coche-la sur le tracker
- +2 🔍 indices chiffrés au hasard (lance 2× le D4, récupère ces chiffres)

### Victoire

Remplis correctement les 16 cases du sudoku 4×4 !

---

## 🎲 DÉROULEMENT D'UNE SESSION DE TEST

### Préparation (5 min)

1. **Découpe le matériel** (page 3 du PDF)
   - 1 pion joueur 🚶
   - 3 marqueurs d'événements (💥🌀📉)
   - 1 tracker de clés avec cases à cocher
   - 1 compteur d'erreurs

2. **Prépare les dés**
   - 1 dé à 4 faces (D4) pour générer les chiffres
   - 1 dé à 6 faces (D6) pour les événements d'erreur

3. **Choisis un scénario** (page 1 du PDF)
   - Scénario 1 : Démarrage standard
   - Scénario 2 : Situation tendue (milieu de partie)

### Scénario 1 : Démarrage standard

**Grille de départ** : 5 chiffres pré-remplis (voir PDF page 1)

Exemple ASCII :

```
┌───┬───┬───┬───┐
│ 1 │   │ 3 │   │
├───┼───┼───┼───┤
│   │ 3 │   │ 1 │
├───┼───┼───┼───┤
│ 3 │   │ 1 │   │
├───┼───┼───┼───┤
│   │ 1 │   │ 3 │
└───┴───┴───┴───┘
```

**État initial** :

- Position : Case (0,0) - le "1" en haut à gauche
- Clés : 🔑1 (rouge), 🔑3 (bleu) - coche-les sur le tracker
- Indices : 3 jetons chiffrés (🔍2, 🔍4, 🔍4 par exemple - à définir selon scénario)
- Matériel : D4 et D6 à portée de main

**Objectif** : Tester le jeu du début à la fin

### Scénario 2 : Situation tendue

**Grille en cours** : Partie déjà avancée (voir PDF page 1)

**État actuel** :

- Position : Case (1,2) - case vide ligne 2
- Clés : 🔑1, 🔑3, 🔑4 - coche-les sur le tracker
- Indices : 🔍4 (1 seul !)
- Matériel : D4 et D6

**Challenge** : Tu es sur une case vide et tu n'as qu'un 🔍4 dans ton inventaire, mais cette case nécessite un 2. Soit tu poses le 4 (erreur garantie → événement aléatoire), soit tu recules. Que fais-tu ?

**Objectif** : Tester les situations de tension et prise de risque

### Jouer une partie (10-20 min)

1. **Place ton pion** 🚶 sur la case de départ
2. **Coche les clés de départ** sur le tracker
3. **Dispose tes jetons indices** devant toi (inventaire visible)
4. **Prépare tes dés** (D4 et D6) à portée
5. **Lance un chrono** (optionnel)

#### Tour par tour

1. **Observe** la grille, ton inventaire d'indices, et tes possibilités
2. **Déplace-toi** sur une case adjacente (si tu as la clé correspondante)
3. **Si la case contient un jeton indice** : ramasse-le et ajoute-le à ton inventaire
4. **Si tu arrives sur une case vide** :
   - Regarde ton inventaire d'indices
   - **Décide** :
     - **Placer un chiffre** : choisis un indice de ton inventaire, place-le sur la case
     - **Annuler** : recule sur la case précédente
5. **Si tu as placé un chiffre** :
   - Écris-le au crayon sur la grille
   - Vérifie si c'est correct (compare avec la solution si besoin)
   - **Si correct** → l'indice est consommé, le chiffre reste
   - **Si erreur** → lance le D6 et applique l'événement (💥🌀📉)
6. **Collecte les récompenses** si tu complètes une ligne/colonne/bloc :
   - Coche +1 clé sur le tracker (au choix)
   - Lance 2× le D4 et récupère ces indices chiffrés
7. **Coche les erreurs** sur le compteur (page 3 du PDF)
8. **Répète** jusqu'à victoire (ou blocage)

### Après la partie (5 min)

Utilise la **page 4 du PDF** (checklist de validation) pour noter :

**Gameplay de base** :

- [ ] Jouable du début à la fin ?
- [ ] Bloqué trop souvent ?
- [ ] Règles claires ?

**Tension et intérêt** :

- [ ] Décisions intéressantes ?
- [ ] Anticipation des coups ?
- [ ] Événements fun ou frustrants ?

**Rythme** :

- [ ] Durée : court / bon / long ?
- [ ] Envie de rejouer ?

**Prochaine étape** :

- [ ] GO → coder
- [ ] Ajuster → quoi ?
- [ ] NO-GO → pivot ?

**Notes libres** : Utilise l'espace en bas de la page 4 pour tes observations.

---

## 🧪 VARIANTES À TESTER

Une fois le scénario de base joué, teste ces variations (utilise les grilles vierges page 2) :

### Variante A : Moins de clés au départ

- Démarrer avec **1 clé** au lieu de 2
- **But** : Tester si c'est trop tendu dès le début

### Variante B : Plus de clés au départ

- Démarrer avec **3 clés** (1, 2, 3) au lieu de 2
- **But** : Tester si plus de liberté réduit le blocage

### Variante C : D4 biaisé

- Autoriser le joueur à **relancer le D4 une fois** s'il n'aime pas le résultat
- **But** : Tester si plus de contrôle améliore l'expérience

### Variante D : Événements plus sévères

- Explosion : efface **8 cases** (diagonales incluses)
- Téléportation : position complètement aléatoire (pas forcément accessible)
- Perte : *(à définir selon tests)*
- **But** : Tester si les événements deviennent trop punitifs

### Variante E : Pas d'événements aléatoires

- Les erreurs ne causent rien de spécial
- Juste un compteur d'erreurs
- **But** : Vérifier si les événements apportent vraiment au gameplay

---

## 📊 OBJECTIFS DES TESTS

### Questions clés à répondre

1. **Le jeu est-il jouable ?**
   - Peux-tu terminer une partie sans être bloqué ?
   - Combien de temps ça prend ? (cible : 5-15 min)

2. **Les décisions sont-elles intéressantes ?**
   - Est-ce que tu anticipes et planifies ?
   - Ou tu places au hasard en espérant ?

3. **Les événements d'erreur sont-ils fun ?**
   - Créent-ils des moments magiques ?
   - Ou juste de la frustration ?

4. **Le système de clés/indices fonctionne-t-il ?**
   - Est-ce que résoudre et naviguer se nourrissent bien ?
   - Manques-tu souvent de ressources ?

### Critères de succès

**✅ GO pour le proto digital si** :

- Le jeu est jouable du début à la fin (au moins 1 partie complète)
- Au moins 1 "moment magique" émerge naturellement
- Tu as envie de rejouer après 1 partie
- Fun rating > 6/10

**⚠️ Ajustements nécessaires si** :

- Blocage fréquent (manque de clés/indices)
- Événements trop chaotiques/frustrants
- Durée inadéquate (< 3 min ou > 20 min)

**❌ Pivot ou abandon si** :

- Pas fun du tout (< 4/10)
- Décisions pas intéressantes (placement au hasard)
- Le core mechanic ne fonctionne pas

---

## 📝 NOTES DE CONCEPTION

### Contenu des grilles (référence technique)

**Scénario 1 - Solution complète** :

```
┌───┬───┬───┬───┐
│ 1 │ 2 │ 3 │ 4 │
├───┼───┼───┼───┤
│ 4 │ 3 │ 2 │ 1 │
├───┼───┼───┼───┤
│ 3 │ 4 │ 1 │ 2 │
├───┼───┼───┼───┤
│ 2 │ 1 │ 4 │ 3 │
└───┴───┴───┴───┘
```

**Grilles vierges** : 2 disponibles (page 2, réimprimable) pour créer tes propres scénarios

**Matériel fourni** :

- **Page 3** (tout le matériel sur une seule page) :
  - 1× Pion joueur 🚶 (2cm × 2cm à découper)
  - 1× Tracker de clés (cases à cocher : 🔴1, 🟢2, 🔵3, 🟡4)
  - 3× Marqueurs d'événements (💥🌀📉) - 2cm × 2cm
  - 1× Compteur d'erreurs (10 cases)
- **Matériel externe nécessaire** :
  - 1× Dé à 4 faces (D4) pour générer les chiffres
  - 1× Dé à 6 faces (D6) pour les événements d'erreur

---

## 🔄 PROCHAINES ÉTAPES

### Après les tests papier

1. **Remplis la checklist** (page 4 du PDF)
2. **Note tes observations** dans l'espace prévu
3. **Décision GO/NO-GO** :
   - Si GO → Passe au proto digital Godot (voir `../../docs/DESIGN_DOC.md`)
   - Si ajustements → Modifie les paramètres et re-teste
   - Si NO-GO → Documente les problèmes et explore un pivot

### Si GO vers le proto digital

Référence la documentation principale :

- `../../docs/DESIGN_DOC.md` : Spécifications complètes
- `../../EXECUTIVE_SUMMARY.md` : Pitch et vision
- `../../README.md` : Vue d'ensemble du projet

---

**Bon test ! 🎮**

N'hésite pas à gribouiller sur les grilles imprimées, modifier les règles à la volée, et casser les conventions. C'est exactement pour ça que le proto papier existe.
