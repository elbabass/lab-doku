# Workflow Sessions - Lab-doku

Ce document décrit le workflow de développement par sessions courtes inspiré du TDD.

## Philosophie

Le développement Lab-doku suit un cycle itératif **RED → GREEN → REFACTO → REFLECT** avec des sessions courtes (< 30 min idéalement) focalisées sur des objectifs précis et mesurables.

**Principe clé** : **CHAQUE problème suit le cycle RED → GREEN → REFACTO → REFLECT**. Une session contient donc **plusieurs cycles** successifs, un par problème résolu.

### Objectifs

1. **Progresser par petits pas** : Résoudre 1-3 problèmes par session, un cycle complet par problème
2. **Maintenir la qualité** : Code propre et testé à chaque cycle
3. **Apprendre continuellement** : Micro-réflexion après chaque problème + rétro de session
4. **Éviter le burnout** : Sessions courtes, pauses régulières
5. **No-estimate** : Pas d'estimation a priori, seulement mesure et calculs a posteriori

### Différences avec TDD classique

- **Moins de rigueur formelle** : Tests fonctionnels acceptés (pas uniquement unitaires)
- **Focus sur les objectifs** : Résoudre un problème visible/testable
- **Flexibilité** : RED peut être "feature manquante" au lieu de "test qui échoue"
- **Cycles multiples** : Plusieurs cycles RED→GREEN→REFACTO→REFLECT par session

## Le cycle RED → GREEN → REFACTO → REFLECT (par problème)

> **Important** : Ce cycle s'applique à **CHAQUE problème résolu**. Si tu as 3 problèmes dans une session, tu passes par 3 cycles complets.

### 1. RED - Définir UN problème

**Objectif** : Identifier clairement ce qui doit fonctionner et comment le vérifier.

**Actions** :

1. **Choisir UN problème** de la liste de la session
2. **Définir les critères de succès** : Comment savoir que c'est résolu ?
3. **Écrire/exécuter un test** (si applicable) : Test unitaire OU test manuel

**Exemple** :

```markdown
## Session 2025-11-12_01

### Problèmes à résoudre

- [ ] Le joueur peut se déplacer sur la grille avec les flèches
- [ ] Le mouvement est bloqué si le joueur n'a pas la clé correspondante
- [ ] Le sprite du joueur se déplace visuellement vers la nouvelle case

### Critères de succès

- Appuyer sur flèche haut déplace le joueur d'une case vers le haut
- Essayer d'aller sur une case "3" sans clé "3" ne fait rien
- Animation visible de déplacement (tween)

### Tests

- [x] Test manuel : Lancer le jeu, appuyer sur flèches
- [ ] Test unitaire : `test_player_movement.gd` (à créer)
```

**État à la fin de RED** : Les tests échouent OU la feature n'existe pas encore.

### 2. GREEN - Implémenter la solution minimale

**Objectif** : Faire passer les tests / résoudre le problème le plus rapidement possible.

**Actions** :

1. **Coder la solution minimale** : Pas de sur-ingénierie, juste ce qui fonctionne
2. **Tester fréquemment** : Lancer le jeu / tests après chaque petit changement
3. **Itérer jusqu'à succès** : Ajuster jusqu'à ce que les critères soient remplis

**Bonnes pratiques GREEN** :

- ✅ Dupliquer du code si ça accélère (on refactorera après)
- ✅ Utiliser des valeurs hardcodées si nécessaire
- ✅ Ignorer les edge cases non critiques
- ❌ Ne pas perdre de temps sur l'élégance du code
- ❌ Ne pas ajouter de features non demandées

**Exemple de code GREEN** :

```gdscript
# Solution minimale (duplication acceptable)
func _unhandled_input(event: InputEvent):
    if event.is_action_pressed("ui_up"):
        var target = current_position + Vector2i(0, -1)
        if _can_move_to(target):
            _move_to(target)

    if event.is_action_pressed("ui_down"):
        var target = current_position + Vector2i(0, 1)
        if _can_move_to(target):
            _move_to(target)

    # ... répétition pour left/right (pas DRY, mais ça marche)
```

**État à la fin de GREEN** : Tous les tests passent / problèmes résolus.

### 3. REFACTO - Nettoyer le code et valider

**Objectif** : Améliorer la qualité du code sans changer le comportement + valider avec tests et linters.

**Actions** :

1. **Éliminer la duplication** : Extraire fonctions/constantes communes
2. **Appliquer les conventions** : Voir `docs/godot/CONVENTIONS.md`
3. **Simplifier** : Rendre le code plus lisible
4. **Lancer les tests automatiques** : Tests unitaires + tests d'intégration
5. **Lancer les linters** : Markdown (`npx markdownlint-cli2`), Godot (warnings)
6. **Vérifier** : Re-tester après chaque refactoring pour éviter les régressions

**Refactorings typiques** :

- Extraire constantes magiques
- Regrouper code dupliqué en fonctions
- Renommer variables pour plus de clarté
- Ajouter commentaires de documentation
- Réorganiser sections (signaux, variables, fonctions)

**Exemple de code REFACTO** :

```gdscript
# Après refactoring (DRY, lisible)
const DIRECTIONS = {
    "ui_up": Vector2i(0, -1),
    "ui_down": Vector2i(0, 1),
    "ui_left": Vector2i(-1, 0),
    "ui_right": Vector2i(1, 0)
}

func _unhandled_input(event: InputEvent):
    for action in DIRECTIONS:
        if event.is_action_pressed(action):
            var target = current_position + DIRECTIONS[action]
            if _can_move_to(target):
                _move_to(target)
            break
```

**État à la fin de REFACTO** : Code propre, tests verts, linters passent.

### 4. REFLECT - Micro-réflexion sur le problème résolu

**Objectif** : Apprendre du cycle qui vient de se terminer et réajuster la suite de la session.

**Actions** (rapides, 1-2 min max) :

1. **Noter un apprentissage** : Qu'ai-je appris en résolvant ce problème ?
2. **Identifier des problèmes émergents** : Ce problème a-t-il révélé :
   - Une faiblesse de conception ?
   - Un manque de tests ?
   - Un nouveau problème à résoudre ?
3. **Décider de la suite** :
   - Ajouter de nouveaux problèmes à la liste de session (si urgent)
   - Ou les noter pour la prochaine session
   - Passer au problème suivant de la session

**Questions guides** :

- Ce problème était-il plus complexe que prévu ? Pourquoi ?
- Ai-je découvert une limitation de l'architecture actuelle ?
- Y a-t-il un refactoring plus profond à planifier ?
- Dois-je ajouter des tests supplémentaires ?

**Exemple de REFLECT après résolution d'un problème** :

```markdown
## Problème 1 : Déplacement du joueur - REFLECT

**Apprentissage** : L'utilisation d'un dictionnaire pour les directions simplifie grandement le code.

**Problèmes émergents** :
- La validation des clés est actuellement dans PlayerController, mais devrait peut-être être dans KeyManager (responsabilité unique)
- Pas de tests unitaires pour la logique de déplacement

**Décision** : Ajouter ces 2 problèmes à la liste de la session actuelle (ou prochaine si pas le temps).

**Suite** : Passer au Problème 2 (Vérification des clés).
```

**État à la fin de REFLECT** : Apprentissage noté, problèmes émergents identifiés, décision prise sur la suite.

> **Important** : Après ce REFLECT, tu retournes au RED pour le problème suivant. Le cycle continue jusqu'à la fin de la session.

## Mini-rétro de session (fin de session)

**Quand** : À la fin de la session, après avoir complété tous les cycles RED→GREEN→REFACTO→REFLECT.

**Objectif** : Documenter la session, mesurer et préparer la suivante.

### Choix du template de rétro

Deux templates disponibles dans `docs/workflow/templates/` :

1. **`RETRO_SESSION_CONCISE.md`** (recommandé par défaut)
   - **Usage** : Sessions normales/quotidiennes
   - **Format** : Léger, focus sur l'essentiel
   - **Durée remplissage** : 3-5 min

2. **`RETRO_TEMPLATE.md`** (détaillé)
   - **Usage** : Sessions importantes, complexes ou rétrospectives périodiques (ex: fin de phase)
   - **Format** : Complet avec toutes les sections détaillées
   - **Durée remplissage** : 8-12 min

**Règle** : Utiliser le template concis sauf si :

- Session > 45 min ou très complexe
- Fin de phase majeure (Phase 0, Phase 1, etc.)
- Décisions techniques importantes prises
- Nombreux blocages ou apprentissages critiques

### Actions

1. **Remplir le template de rétro** : `docs/workflow/retros/YYYYMMDD_session_N.md`
2. **Mesurer** :
   - Heure de début et de fin
   - Nombre de problèmes résolus
   - Nombre de commits effectués
3. **Noter les apprentissages** : Qu'ai-je découvert pendant cette session ?
4. **Identifier les blocages** : Qu'est-ce qui a pris plus de temps que prévu ?
5. **Mettre à jour le backlog** : Ajouter tous les nouveaux problèmes identifiés
6. **Créer fichier de tests suivant** : Préparer la prochaine session avec les problèmes prioritaires
7. **Solliciter feedback utilisateur** : Inviter l'utilisateur à compléter la section feedback (Arrêter/Commencer/Continuer)

**Résultat** : Fichier de rétro complété dans `docs/workflow/retros/` et fichier de tests pour session suivante dans `docs/workflow/tests/`.

## Gestion des sessions

### Durée cible

- **Idéal** : 20-30 minutes
- **Maximum** : 45 minutes (si dépassé, découper mieux les problèmes la prochaine fois)
- **Minimum** : 15 minutes (si trop court, regrouper avec problèmes plus complexes)

**Note** : Pas d'estimation a priori ! Seulement mesure a posteriori pour améliorer le découpage.

### Nombre de problèmes par session

Dépend de leur complexité réelle (découverte pendant la session) :

- **1 problème** : Complexe ou avec découvertes importantes
- **2-3 problèmes** : Complexité moyenne ou simple
- **3-5 problèmes** : Très simples et bien définis

**Note** : No-estimate ! On ne peut pas prédire, on mesure et on ajuste.

### Fréquence

- **Développement actif** : 2-4 sessions par jour (avec pauses)
- **Maintenance** : 1-2 sessions par semaine
- **Exploration** : Sessions plus longues acceptées (60-90 min)

## Gestion des commits

### Règle générale

**Au moins 1 commit par session**.

### Cas de figure

#### Cas 1 : Session terminée avec succès (tests passent)

**Commit normal** :

```bash
git add .
git commit -m "feat: add player movement with key validation"
```

#### Cas 2 : Session terminée mais tests ne passent pas

**Commit WIP** (Work In Progress) :

```bash
git add .
git commit -m "wip: implement player movement (animation broken)"
```

**Important** : Les commits WIP doivent être complétés/fixés dans la session suivante.

#### Cas 3 : Session avec plusieurs étapes terminées

**Plusieurs commits** (découper logiquement) :

```bash
git add scripts/game/player_controller.gd
git commit -m "feat: add basic player movement logic"

git add scripts/game/key_manager.gd
git commit -m "feat: add key validation for movement"

git add scenes/game/player.tscn
git commit -m "feat: add movement animation with tween"
```

### Convention de messages

Format : `<type>: <description>`

**Types** :

- `feat` : Nouvelle fonctionnalité
- `fix` : Correction de bug
- `refactor` : Refactoring (pas de changement de comportement)
- `docs` : Documentation uniquement
- `test` : Ajout/modification de tests
- `chore` : Tâches diverses (config, assets, etc.)
- `wip` : Travail en cours (tests ne passent pas)

**Exemples** :

```
feat: add grid manager with sudoku validation
fix: correct key requirement check for empty cells
refactor: extract event probability logic to constants
docs: update architecture diagram with EventBus
test: add unit tests for SudokuValidator
wip: implement explosion event (visual effects missing)
```

**IMPORTANT** : Ne jamais inclure de signature AI dans les commits ("edited with claude", etc.).

## Fichiers de suivi

### Structure

```
docs/workflow/
├── SESSIONS.md              # Ce fichier (méthodologie)
├── tests/                   # Fichiers de tests à effectuer
│   ├── 20251112_session_01.md
│   ├── 20251112_session_02.md
│   └── 20251113_session_01.md
├── retros/                  # Rétrospectives de sessions
│   ├── 20251112_session_01.md
│   ├── 20251112_session_02.md
│   └── 20251113_session_01.md
└── templates/               # Templates réutilisables
    ├── SESSION_TEMPLATE.md
    ├── RETRO_TEMPLATE.md
    ├── PHASE_TEMPLATE.md
    └── TEST_TEMPLATE.md
```

### Création automatique

**Commandes slash Claude** :

- `/start-session` : Crée le fichier de tests pour la session en cours
- `/end-session` : Génère la rétro, crée le fichier de tests suivant

## Workflow par phases (branches)

### Phases du projet

Le projet Lab-doku est découpé en **phases de développement** correspondant aux grandes étapes :

- **Phase 0** : Setup et architecture (branche `phase-0-setup`)
- **Phase 1** : MVP Core mechanics (branche `phase-1-mvp`)
- **Phase 2** : Events & feedback (branche `phase-2-events`)
- **Phase 3** : UI & polish (branche `phase-3-ui`)

### Workflow git par phase

#### 1. Démarrer une nouvelle phase

```bash
git checkout main
git pull
git checkout -b phase-1-mvp
```

#### 2. Sessions sur la branche de phase

Toutes les sessions de la phase se font sur cette branche :

```bash
# Session 1
git add .
git commit -m "feat: add grid manager"

# Session 2
git add .
git commit -m "feat: add sudoku validator"

# etc.
```

#### 3. Terminer la phase

**Rétrospective de phase complète** :

```markdown
# Rétro Phase 1 - MVP Core Mechanics

## Objectifs de la phase

- [x] Grille 4x4 fonctionnelle
- [x] Validation sudoku
- [x] Déplacement joueur
- [x] Système de clés

## Durée

- Début : 2025-11-12
- Fin : 2025-11-15
- Durée : 3 jours (8 sessions)

## Sessions effectuées

1. Session 01 : Grid manager (25 min)
2. Session 02 : Sudoku validator (30 min)
3. Session 03 : Player movement (28 min)
...

## Bilan global

### Ce qui a bien fonctionné

- Architecture claire a facilité l'ajout de features
- Tests unitaires ont détecté bugs rapidement
- Cycle RED/GREEN/REFACTO respecté

### Difficultés majeures

- Performance lors de la validation (résolu avec optimisation)
- Gestion des animations complexe (simplifié)

### Leçons apprises

- Toujours tester les edge cases (bords de grille)
- Documenter les décisions techniques au fur et à mesure

## Métriques

- Commits : 18 (dont 2 WIP résolus)
- Tests : 12 unitaires, 5 intégration
- Bugs trouvés : 4 (tous résolus)

## Prochaines étapes (Phase 2)

- Implémenter système d'événements
- Ajouter effets visuels
- Intégrer sons
```

#### 4. Merger la phase

```bash
# Vérifier que tout est propre
git status

# Merger dans main (squash ou merge selon préférence)
git checkout main
git merge phase-1-mvp  # ou git merge --squash phase-1-mvp

# Pousser
git push origin main
```

## Outils et automatisation

### Commandes slash Claude

#### `/start-session`

Crée un fichier de tests pour la session en cours.

**Exemple de sortie** : `docs/workflow/tests/20251112_session_01.md`

#### `/end-session`

1. Génère la rétro de la session
2. Crée le fichier de tests pour la session suivante
3. Propose le message de commit

**Exemple de sortie** :

```markdown
# Rétro générée : docs/workflow/retros/20251112_session_01.md
# Tests suivants : docs/workflow/tests/20251112_session_02.md

Commit suggéré :
feat: add player movement with key validation

Durée session : 25 min ✅
```

#### `/lint-markdown`

Lance le linter sur tous les fichiers markdown du projet.

```bash
npx markdownlint-cli2 "**/*.md"
```

#### `/godot-check`

Vérifie que le projet Godot compile sans erreurs.

```bash
godot --headless --check-only --path .
```

### Hooks (automatisation)

#### Hook pre-commit

`.claude/hooks/pre-commit.sh` :

```bash
#!/bin/bash
# Lance le linter markdown avant chaque commit
npx markdownlint-cli2 "**/*.md"

if [ $? -ne 0 ]; then
    echo "❌ Markdown linting failed. Fix errors before committing."
    exit 1
fi

echo "✅ Markdown linting passed."
```

## Exemples de sessions

### Exemple 1 : Session simple (1 problème)

**Cycle RED → GREEN → REFACTO → REFLECT** :

**RED** :

- Problème : "Le joueur peut se déplacer avec les flèches"
- Critères : Appuyer sur flèche déplace le sprite
- Test manuel : Lancer le jeu et appuyer sur flèches

**GREEN** :

- Créer `player_controller.gd`
- Implémenter `_unhandled_input()` avec 4 conditions (up/down/left/right)
- Tester → ça marche !

**REFACTO** :

- Extraire directions dans constante `DIRECTIONS`
- Remplacer 4 if par boucle sur dictionnaire
- Lancer linters
- Re-tester → toujours OK

**REFLECT** :

- Apprentissage : "Dictionnaire plus lisible que 4 if"
- Problème émergent : "Animation manquante"
- Décision : Ajouter à prochaine session
- Commit : `feat: add basic player movement`

**Mesure** : Session de 18 min (1 cycle, simple).

### Exemple 2 : Session avec 3 cycles (3 problèmes)

**Cycle 1 : Vérifier clés avant déplacement**

- RED → GREEN → REFACTO → REFLECT
- Ajout `KeyManager`, vérification dans `_can_move_to()`
- Commit : `feat: add key validation for movement`

**Cycle 2 : Bloquer déplacement hors grille**

- RED → GREEN → REFACTO → REFLECT
- Ajout `_is_valid_position()`
- Commit : `feat: add grid boundary validation`

**Cycle 3 : Animer le déplacement avec tween**

- RED → GREEN (complexe, documentation Godot nécessaire) → REFACTO → REFLECT
- Ajout tween dans `_move_to()`
- Commit : `feat: add movement animation`

**Mini-rétro session** : 3 cycles complétés, animation plus complexe que prévu (a nécessité lecture doc). **Mesure** : 42 min (3 cycles, complexité variée).

### Exemple 3 : Session avec WIP

**Cycle : Explosion efface 4 cellules adjacentes**

**RED** :

- Problème : Explosion efface 4 cellules adjacentes
- Test : Placer erreur → vérifier que cellules disparaissent

**GREEN** :

- Implémentation `_handle_explosion_event()`
- Bug : Les cellules pré-remplies sont aussi effacées (pas voulu)
- Tentatives de fix → toujours cassé
- Session terminée sans résolution

**REFACTO** : Skipped (problème non résolu)

**REFLECT** :

- Apprentissage : "Logique effacement plus complexe que prévu"
- Problème émergent : "Besoin de mieux comprendre la protection des cellules"
- Décision : Commit WIP, continuer session suivante
- Commit WIP : `wip: implement explosion event (prefilled cells not protected)`

**Mini-rétro session** : 1 cycle incomplet (WIP). **Mesure** : 28 min (blocage technique).

**Session suivante** :

- Cycle repris : Débugger protection cellules pré-remplies
- Commit final : `fix: protect prefilled cells from explosion`
- **Mesure** : 15 min (résolution rapide après pause)

## Checklist de session

### Avant de commencer

- [ ] Lire le fichier de tests de la session
- [ ] Vérifier que le projet se lance (pas de régression)
- [ ] Préparer environnement (Godot ouvert, terminal prêt)

### Pendant la session

- [ ] **RED** : Définir problèmes et critères de succès
- [ ] **GREEN** : Implémenter solution minimale
- [ ] **REFACTO** : Nettoyer le code
- [ ] **REFLECT** : Remplir la rétro

### Après la session

- [ ] Lancer linter markdown : `/lint-markdown`
- [ ] Vérifier projet Godot : `/godot-check`
- [ ] Committer avec message approprié (feat/fix/wip/etc.)
- [ ] Créer fichier de tests pour session suivante
- [ ] Pause de 10-15 min (obligatoire si session > 30 min)

## Ressources

- Templates : `docs/workflow/templates/`
- Exemples de rétros : `docs/workflow/retros/`
- Conventions code : `docs/godot/CONVENTIONS.md`
- Architecture : `docs/godot/ARCHITECTURE.md`

**Dernière mise à jour** : 2025-11-11
