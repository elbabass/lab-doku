# Lab-doku - Résultats des Tests du Prototype Papier

**Date des tests** : Novembre 2025
**Version testée** : Prototype papier v1
**Testeur** : Bastien
**Statut** : ✅ GO pour prototype digital avec ajustements

---

## 📊 Synthèse Exécutive

### Verdict Final

**🟢 GO VALIDÉ** - Le concept core est jouable et intéressant, mais nécessite des ajustements significatifs avant implémentation digitale.

### Points Clés

- ✅ **Concept validé** : Le jeu est jouable de bout en bout avec les ajustements
- ✅ **Règles claires** : Compréhension immédiate des mécaniques
- ✅ **Synergie résolution/navigation** : Crée une tension/résolution agréable
- ⚠️ **Durée trop courte** : 2 minutes max par partie (cible : 5-15 min)
- ⚠️ **Difficulté insuffisante** : Sensation de tutoriel permanent
- ⚠️ **Rejouabilité mitigée** : Envie de recommencer partagée

---

## 🎯 Problèmes Identifiés et Solutions Adoptées

### 1. Blocage Initial - CRITIQUE

**Problème** : Impossible d'avancer sans indices numériques au départ. La grille pré-remplie seule ne permet aucun mouvement.

**Solution adoptée** : Démarrer avec **2 indices aléatoires** dans l'inventaire

- Contrainte respectée : Max 4 occurrences du même chiffre (grille + inventaire)
- Procédure : Si tirage invalide (dépasse contrainte), défausser et repiocher
- Impact : Résout complètement le problème de démarrage

**Statut** : ✅ Validé en test

---

### 2. Blocage par Clés Non-Adjacentes - CRITIQUE

**Problème** : Avec seulement les clés 1 et 3, bloqué car ces chiffres ne sont jamais adjacents dans un sudoku. Aucun chemin possible.

**Options envisagées** :

1. S'assurer d'un chemin toujours possible à l'initialisation
2. En cours de jeu, si aucun chemin accessible : erreur → événement
3. **Pouvoir rester sur une case vide après y avoir posé un chiffre, même sans clé** ✅

**Solution adoptée (Option 3)** :

- Une fois un chiffre posé sur une case vide, le joueur peut **rester sur cette case même sans la clé correspondante**
- Une fois sorti de la case, impossible d'y revenir sans posséder la clé
- Permet de débloquer des situations tout en créant de nouvelles contraintes tactiques
- Peut créer des énigmes spatiales intéressantes

**Statut** : ✅ Validé en test - Cette règle change fondamentalement la dynamique du jeu

---

### 3. Partie Trop Courte - IMPORTANT

**Problème** : Durée de 2 minutes maximum par partie (cible : 5-15 min). Sensation de tutoriel permanent, peu d'anticipation stratégique.

**Solutions prévues pour proto digital** :

1. **Compte à rebours par série** (ligne/colonne/bloc) ⭐ PRIORITÉ
   - Force l'ordre de résolution
   - Maintient la pression temporelle
   - À zéro : la série correspondante explose (tous chiffres disparaissent)

2. **Grilles progressives** 4x4 → 5x5 → 6x6 ⭐ PRIORITÉ
   - Augmente graduellement la complexité
   - Permet une courbe d'apprentissage

3. **Autres idées** (post-MVP) :
   - Poseur de bombe adverse mobile
   - Capture du poseur = victoire bonus
   - Mode multijoueur (coopératif ou compétitif)

**Statut** : 🔄 À implémenter dans proto digital

---

### 4. Événements d'Erreur - AJUSTEMENT NÉCESSAIRE

**Problème** : Distribution équiprobable (33% chaque) ne reflète pas les besoins de tension du jeu.

**Solution adoptée** :

- **Perte d'indice** devient l'événement **principal**
- **Téléportation** devient **occasionnelle** (reste intéressante)
- **Explosion** : Testée en version sévère (8 cases) - énorme mais jouable
- **Téléportation aléatoire** (pas forcément accessible) reste jouable et peut aider

**Nouveau système proposé** :

- Perte d'indice : événement de base (fréquence à définir)
- Téléportation : événement secondaire (10-30% de chance)
- Explosion : à décider (conserver/supprimer/rare)

**Justification** : La perte d'indice crée une pression directe sur les ressources et un lien avec la condition de défaite.

**Statut** : 🔄 Paramètres exacts à définir avant proto digital

---

### 5. Absence de Condition de Défaite - NOUVEAU

**Problème** : Le jeu n'a pas de tension finale, pas de risque de perdre réellement.

**Solution adoptée** : **Game Over si inventaire vide**

- Si le joueur n'a plus aucun indice chiffré dans son inventaire → **Game Over**
- Combiné avec un **gain d'indice à chaque bon chiffre posé** (nouveau mécanisme)
- Crée un cycle risque/récompense équilibré

**Impact** : Change fondamentalement la dynamique du jeu. Ajoute une vraie tension et une possibilité d'échec.

**Statut** : ✅ Validé conceptuellement - À implémenter

---

## 🎮 Résultats par Critère de Test

### Gameplay de Base

#### ✅ Jouable du début à la fin ?

**OUI** (avec ajustements)

Détails :

- **Grille 1 (pré-remplie initiale)** : Impossible sans les 2 indices aléatoires au départ
- **2e essai sur grille 1** : Bloqué par clés 1 et 3 non-adjacentes → solution adoptée (règle case vide)
- **Grille 2 (pré-remplie avancée)** : ✅ Faisable jusqu'à la fin avec les ajustements

#### ⚠️ Bloqué trop souvent ?

**Résolu par les ajustements**

Les deux règles suivantes éliminent les blocages critiques :

1. Démarrage avec 2 indices aléatoires
2. Pouvoir rester sur case vide après placement

#### ✅ Règles claires ?

**OUI**

Les règles sont comprises immédiatement. Les ajustements devront être documentés clairement mais restent intuitifs.

---

### Tension et Intérêt

#### ⚠️ Décisions intéressantes ?

**PARTAGÉ - Nécessite amélioration**

Observation :
> "Je suis partagé sur ce point. Il faudra trouver une difficulté supplémentaire pour donner envie de recommencer."

Les décisions existent mais manquent de profondeur à ce stade. Solutions envisagées :

1. Timer par série (pression temporelle) ⭐
2. Poseur de bombe adverse
3. Capture du poseur = victoire
4. Grilles plus grandes ⭐
5. Multijoueur

#### ✅ Anticipation des coups ?

**Présente mais faible**

Observation :
> "Ça reste assez faible à ce stade, mais ça donne un peu à réfléchir. J'ai eu la sensation d'être dans un tuto ou dans les premiers niveaux d'un nouveau jeu, en termes de difficulté."

Conclusion : Le système fonctionne, mais nécessite plus de complexité (grilles plus grandes, timer).

#### ✅ Événements fun ou frustrants ?

**Équilibre intéressant**

Observation :
> "Les blocages sont intéressants dans la boucle frustration/fun. Il sera intéressant de doser cela dans la mise en œuvre."

Les événements créent des moments mémorables. Avec effets visuels et sonores, ils seront impactants.

---

### Rythme

#### ⚠️ Durée : court / bon / long ?

**TRÈS COURT**

Observation :
> "Très court. 2 minutes maxi par partie."

Cible : 5-15 minutes. Écart significatif nécessitant ajustements (timer, grilles plus grandes).

#### ⚠️ Envie de rejouer ?

**PARTAGÉ**

Observation :
> "Je suis partagé. Je pense qu'un meilleur compromis de difficulté pourra être trouvé dans les premiers proto réel. Si c'est le cas, alors ça peut être très amusant de recommencer."

Dépend fortement de l'amélioration de la difficulté et de la durée.

---

### Prochaine Étape

#### ✅ GO → coder ?

**OUI**

Observation :
> "Les prochaines adaptations sont à faire sur une version jeu vidéo pour être vraiment palpables."

Le prototype papier a validé le concept. Les mécaniques avancées (timer, effets, sons) nécessitent une implémentation digitale.

#### ✅ Ajuster → quoi ?

**Règles de navigation validées**

Observation :
> "Les règles pour éviter le blocage. L'option 3 ci-dessus 'Comme on peut temporairement naviguer sur une case vide, une fois le chiffre posé, on peut rester sur la case, même sans clé. Par contre, une fois sorti, on ne peut pas y revenir sans sa clé. Cette idée peut quand même mener à un blocage, mais peut aussi donner de nouvelles possibilités pour des énigmes à résoudre.'"

---

## 🧪 Résultats des Variantes Testées

### Variante A : Moins de clés au départ (1 clé)

**Résultat** : ⚠️ Très difficile

Observation :
> "Très difficile car quasi impossible de naviguer. En effet, le même chiffre ne se touche jamais lui-même. Donc, avec une seule clé, le seul déplacement possible est sur une case vide pour poser un chiffre."

**Conclusion** : Intéressant pour un niveau ou mode puzzle challenge, mais trop restrictif pour démarrage standard.

---

### Variante B : Plus de clés au départ (3 clés)

**Résultat** : ✅ Équilibré

Observation :
> "Rend un peu plus facile, mais sans briser le jeu. Je pense que pour les premières parties d'un nouveau joueur, cela peut être bien."

**Conclusion** : Bon candidat pour mode facile ou tutoriel.

---

### Variante C : D4 biaisé (relance une fois)

**Résultat** : 💡 Idée bonne mais non prioritaire

Observation :
> "L'idée est bonne, mais pas utile pour l'instant. J'ai aussi remplacé le D4 par un tirage au sort des indices-chiffres avec la règle de 4 occurrences max entre la grille et l'inventaire pour un même chiffre. Dans cette situation, avec une grille 4x4, il reste peu de blocage au joueur."

**Conclusion** : Mécanisme de tirage avec contrainte 4 max suffit actuellement.

---

### Variante D : Événements plus sévères

**Résultat** : ✅ Jouables mais intenses

Observations :

- **Explosion 8 cases** : "Énorme. Mais il est possible de s'en tirer"
- **Téléportation aléatoire** : "Reste jouable. Peut même aider"
- **Perte d'indice** : "Le mécanisme de perte est lié au game over : si le joueur n'a plus aucun indice-chiffre, il perd. Ça semble la meilleure piste. Ceci associé à un gain d'indice à chaque bon chiffre posé."

**Conclusion** : Événements sévères sont gérables. Perte d'indice + game over = meilleure direction.

---

### Variante E : Pas d'événements aléatoires

**Résultat** : ❌ Manque de tension

Observation :
> "Il faut une punition. La perte d'indice-chiffre est pas mal."

**Conclusion** : Les événements sont nécessaires. Perte d'indice est la meilleure punition.

---

## 🎯 Décisions de Design Finales

### Règles Validées

1. **Démarrage avec 2 indices aléatoires** (contrainte 4 max respectée)
2. **Navigation sur case vide** : Pouvoir rester après placement sans clé
3. **Événements d'erreur** : Perte d'indice principale + Téléportation occasionnelle
4. **Condition de défaite** : Game Over si inventaire vide
5. **Gain d'indice** : +1 indice à chaque bon placement (à valider/ajuster)

### Mécaniques Avancées à Implémenter (Proto Digital)

1. **Timer par série** : Compte à rebours → explosion à zéro ⭐ PRIORITÉ
2. **Grilles progressives** : 4x4 → 5x5 → 6x6 ⭐ PRIORITÉ
3. **Effets visuels et sonores** : Explosions, téléportations, gains/pertes

### Mécaniques Post-MVP

1. Poseur de bombe adverse mobile
2. Capture du poseur = victoire bonus
3. Mode multijoueur (coopératif ou compétitif)

---

## 📈 Système de Récompenses Revisé

### Ancien Système

- Compléter une série → +1 clé (choix) + 1-2 indices aléatoires (variante)

### Nouveau Système Proposé

**Par placement correct** :

- +1 indice aléatoire (nouveau mécanisme)
- Justification : Compense les pertes, encourage l'exploration

**Par série complétée** :

- +1 clé (choix)
- +1-2 indices aléatoires supplémentaires (à ajuster selon tests)

**Impact** : Crée un cycle risque/récompense plus fluide et équilibré.

---

## ❓ Questions Ouvertes pour Proto Digital

### Questions Urgentes (à résoudre avant codage)

1. **Distribution événements d'erreur** :
   - Option A : 100% Perte d'indice (déterministe)
   - Option B : 70% Perte / 30% Téléportation
   - Option C : 60% Perte / 30% Téléportation / 10% Explosion
   - **Recommandation** : Tester B puis ajuster

2. **Gain d'indice par placement correct** :
   - Option A : 1 indice à chaque placement correct (suggéré par testeur)
   - Option B : Indices seulement par série complétée (règle actuelle)
   - Option C : Combinaison (probabilité de gain à chaque placement + bonus série)
   - **Recommandation** : Tester A puis ajuster selon durée de partie

3. **Nombre de clés initiales** :
   - 1 clé : Difficile (mode challenge)
   - 2 clés : Standard (testé)
   - 3 clés : Facile (débutants)
   - **Recommandation** : 2 clés standard, proposer modes difficulté plus tard

4. **Placement initial jetons indices sur grille** :
   - Combien ? Positions ? Valeurs ?
   - **Recommandation** : Design intentionnel (pas aléatoire) pour contrôle difficulté

### Questions de Scope Proto Digital

1. **Génération de grille** :
   - Option A : Hardcoder 1 grille (plus rapide) ⭐
   - Option B : Créer 3-5 grilles manuellement
   - Option C : Génération procédurale dès v0.1
   - **Recommandation** : B (3-5 grilles hardcodées pour tester variété)

2. **Feedback visuel/sonore** :
   - Option A : Placeholder minimaliste (carrés + texte)
   - Option B : Assets sympas (sprites, particules, SFX) ⭐
   - **Recommandation** : B (important pour ressentir les événements)

3. **UI d'inventaire** :
   - Option A : Compteur texte ("1:2, 2:1, 3:0, 4:3")
   - Option B : Grille visuelle avec icônes ⭐
   - **Recommandation** : B (plus lisible et intuitif)

---

## 🔄 Prochaines Étapes Recommandées

### Immédiat (Aujourd'hui)

1. ✅ Créer ce rapport de synthèse
2. 🔄 Mettre à jour `DESIGN_DOC.md` avec règles validées
3. 🔄 Mettre à jour `CLAUDE.md` (synchronisation)
4. 🔄 Mettre à jour statut Phase 3 dans `README.md` et `EXECUTIVE_SUMMARY.md`

### Cette Semaine

1. Résoudre les questions ouvertes urgentes (événements, gains indices)
2. Re-tester sur papier si nécessaire pour valider décisions
3. Créer `GODOT_PROTO_SPECS.md` avec scope technique précis
4. Préparer 3-5 grilles de test optimales

### Semaine Suivante

1. Démarrer proto digital Godot
2. Implémenter core loop minimal (sans timer ni grilles variables)
3. Premier playtest interne
4. Itérations rapides

---

## 📊 Conclusion

Le prototype papier a **validé le concept core** de Lab-doku. La fusion sudoku/navigation fonctionne et crée une expérience unique. Les problèmes identifiés (blocages, durée, difficulté) ont des solutions claires qui nécessitent une implémentation digitale pour être testées efficacement.

**Statut** : ✅ **GO VALIDÉ** pour prototype digital avec ajustements documentés.

Les règles sont maintenant clarifiées et prêtes pour implémentation. La prochaine étape est de formaliser ces décisions dans la documentation complète et de créer les spécifications techniques pour Godot.

---

**Rapport rédigé le** : 2025-11-11
**Prochaine révision** : Après premiers tests proto digital
