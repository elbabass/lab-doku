# Workflow Sessions - Lab-doku

Ce document décrit le workflow de développement par sessions courtes inspiré du TDD.

## Philosophie

Le développement Lab-doku suit un cycle itératif **RED → GREEN → REFACTO → REFLECT** avec des sessions courtes (< 30 min idéalement) focalisées sur des objectifs précis et mesurables.

### Objectifs

1. **Progresser par petits pas** : Résoudre 1-3 problèmes par session
2. **Maintenir la qualité** : Code propre et testé à chaque étape
3. **Apprendre continuellement** : Réflexion systématique après chaque session
4. **Éviter le burnout** : Sessions courtes, pauses régulières

### Différences avec TDD classique

- **Moins de rigueur formelle** : Tests fonctionnels acceptés (pas uniquement unitaires)
- **Focus sur les objectifs** : Résoudre un problème visible/testable
- **Flexibilité** : RED peut être "feature manquante" au lieu de "test qui échoue"

## Le cycle RED → GREEN → REFACTO → REFLECT

### 1. RED (5-8 min) - Définir le problème

**Objectif** : Identifier clairement ce qui doit fonctionner et comment le vérifier.

**Actions** :

1. **Lire/créer le fichier de tests** : `docs/workflow/tests/YYYYMMDD_session_N.md`
2. **Choisir 1-3 problèmes** de la liste (max 3 pour sessions < 30 min)
3. **Définir les critères de succès** : Comment savoir que c'est résolu ?
4. **Écrire/exécuter un test** (si applicable) : Test unitaire OU test manuel

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

### 2. GREEN (10-15 min) - Implémenter la solution minimale

**Objectif** : Faire passer les tests / résoudre les problèmes le plus rapidement possible.

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

### 3. REFACTO (5-10 min) - Nettoyer le code

**Objectif** : Améliorer la qualité du code sans changer le comportement.

**Actions** :

1. **Éliminer la duplication** : Extraire fonctions/constantes communes
2. **Appliquer les conventions** : Voir `docs/godot/CONVENTIONS.md`
3. **Simplifier** : Rendre le code plus lisible
4. **Vérifier** : Re-tester après chaque refactoring pour éviter les régressions

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

**État à la fin de REFACTO** : Code propre, tests toujours verts.

### 4. REFLECT (3-5 min) - Mini-rétrospective

**Objectif** : Apprendre de la session et planifier la suite.

**Actions** :

1. **Remplir le template de rétro** : `docs/workflow/retros/YYYYMMDD_session_N.md`
2. **Noter les apprentissages** : Qu'ai-je découvert ?
3. **Identifier les blocages** : Qu'est-ce qui a pris plus de temps que prévu ?
4. **Mettre à jour le backlog** : Ajouter nouveaux problèmes identifiés
5. **Créer fichier de tests suivant** : Préparer la prochaine session

**Template de rétro** :

```markdown
# Rétro Session 2025-11-12_01

## Objectifs

- [x] Déplacement du joueur
- [x] Vérification des clés
- [x] Animation visuelle

## Durée

- Début : 14h30
- Fin : 14h55
- Durée réelle : 25 min ✅

## Ce qui a bien fonctionné

- Le système de signaux a facilité la communication entre PlayerController et KeyManager
- Les tests manuels étaient rapides grâce au hotreload Godot

## Difficultés rencontrées

- Confusion sur l'ordre d'exécution des signaux (résolu en lisant la doc)
- Animation tween plus complexe que prévu (5 min perdues)

## Apprentissages

- `Tween.tween_property()` nécessite `create_tween()` à chaque fois
- Les signaux Godot sont synchrones (exécution immédiate)

## Problèmes identifiés pour sessions suivantes

- Gérer les collisions avec les bords de la grille
- Ajouter feedback visuel quand mouvement refusé (particules ?)
- Optimiser les vérifications de clés (actuellement O(n) sur petit array)

## Commit effectué

- `feat: add player movement with key validation`
- SHA : abc123def
```

**État à la fin de REFLECT** : Session documentée, prochaine session préparée.

## Gestion des sessions

### Durée cible

- **Idéal** : 20-30 minutes
- **Maximum** : 45 minutes (sinon, découper le problème)
- **Minimum** : 15 minutes (sinon, regrouper avec session suivante)

### Nombre de problèmes par session

| Durée session | Problèmes recommandés | Complexité |
|---------------|-----------------------|------------|
| 15-20 min     | 1 problème            | Moyen      |
| 20-30 min     | 2-3 problèmes         | Simple     |
| 30-45 min     | 3-5 problèmes         | Très simple |

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

**Durée** : 20 min

**RED** (5 min) :

- Problème : "Le joueur peut se déplacer avec les flèches"
- Critères : Appuyer sur flèche déplace le sprite
- Test manuel : Lancer le jeu et appuyer sur flèches

**GREEN** (10 min) :

- Créer `player_controller.gd`
- Implémenter `_unhandled_input()` avec 4 conditions (up/down/left/right)
- Tester → ça marche !

**REFACTO** (3 min) :

- Extraire directions dans constante `DIRECTIONS`
- Remplacer 4 if par boucle sur dictionnaire
- Re-tester → toujours OK

**REFLECT** (2 min) :

- Rétro : "Facile, mais animation manquante (à ajouter prochaine session)"
- Commit : `feat: add basic player movement`

### Exemple 2 : Session complexe (3 problèmes)

**Durée** : 35 min

**RED** (8 min) :

- Problème 1 : Vérifier clés avant déplacement
- Problème 2 : Bloquer déplacement hors grille
- Problème 3 : Animer le déplacement avec tween
- Tests manuels définis pour chaque

**GREEN** (18 min) :

- Problème 1 : Ajout `KeyManager`, vérification dans `_can_move_to()`
- Problème 2 : Ajout `_is_valid_position()`
- Problème 3 : Ajout tween dans `_move_to()` (plus long que prévu)

**REFACTO** (6 min) :

- Déplacer constantes dans `Constants.gd`
- Documenter fonctions publiques
- Simplifier logique tween

**REFLECT** (3 min) :

- Rétro : "Tween complexe, à creuser doc Godot"
- Commit : `feat: add player movement with key validation and animation`

### Exemple 3 : Session bloquée (WIP)

**Durée** : 30 min

**RED** (5 min) :

- Problème : Explosion efface 4 cellules adjacentes
- Test : Placer erreur → vérifier que cellules disparaissent

**GREEN** (20 min) :

- Implémentation `_handle_explosion_event()`
- Bug : Les cellules pré-remplies sont aussi effacées (pas voulu)
- Tentatives de fix → toujours cassé
- Timer session expire

**REFACTO** : Skipped (pas terminé)

**REFLECT** (5 min) :

- Rétro : "Logique effacement complexe, besoin aide/doc"
- Commit WIP : `wip: implement explosion event (prefilled cells not protected)`
- Note pour session suivante : "Débugger protection cellules pré-remplies"

**Session suivante** :

- Reprendre le WIP, fixer le bug
- Commit final : `fix: protect prefilled cells from explosion`

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
