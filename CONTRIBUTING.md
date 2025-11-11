# Contributing to Lab-doku

Merci de ton intérêt pour Lab-doku ! Ce guide t'aidera à contribuer au projet.

## Table des matières

- [Code de conduite](#code-de-conduite)
- [Comment contribuer](#comment-contribuer)
- [Workflow de développement](#workflow-de-développement)
- [Conventions de code](#conventions-de-code)
- [Process de commit](#process-de-commit)
- [Pull Requests](#pull-requests)
- [Tests](#tests)
- [Documentation](#documentation)

## Code de conduite

En participant à ce projet, tu t'engages à respecter les autres contributeurs et à maintenir un environnement collaboratif et bienveillant.

## Comment contribuer

### Types de contributions

- 🐛 **Bug fixes** : Corrections de bugs identifiés
- ✨ **Features** : Nouvelles fonctionnalités
- 📚 **Documentation** : Améliorations de la documentation
- ♻️ **Refactoring** : Amélioration du code sans changer le comportement
- ✅ **Tests** : Ajout ou amélioration de tests

### Workflow général

1. **Fork** le projet (si contributeur externe)
2. **Clone** ton fork localement
3. **Crée une branche** pour ta contribution
4. **Développe** en suivant le workflow par sessions
5. **Teste** ton code (unitaire + manuel)
6. **Commit** avec des messages clairs
7. **Push** ta branche
8. **Ouvre une Pull Request**

## Workflow de développement

Lab-doku utilise un workflow par **sessions courtes** inspiré du TDD.

### Cycle RED → GREEN → REFACTO → REFLECT

Voir la documentation complète : [`docs/workflow/SESSIONS.md`](docs/workflow/SESSIONS.md)

**Résumé** :

1. **RED** (5-8 min) : Définir le problème et les critères de succès
2. **GREEN** (10-15 min) : Implémenter la solution minimale
3. **REFACTO** (5-10 min) : Nettoyer le code et appliquer les conventions
4. **REFLECT** (3-5 min) : Mini-rétro et planification suite

### Sessions

- **Durée cible** : 20-30 minutes
- **Problèmes par session** : 1-3 selon complexité
- **Commit minimum** : 1 par session (WIP accepté si documenté)

### Phases

Le projet est découpé en **phases de développement** :

- **Phase 0** : Setup et architecture
- **Phase 1** : MVP Core mechanics
- **Phase 2** : Events & feedback
- **Phase 3** : UI & polish

Chaque phase a sa propre branche : `phase-X-nom`

## Conventions de code

### GDScript

Suivre le guide : [`docs/godot/CONVENTIONS.md`](docs/godot/CONVENTIONS.md)

**Points clés** :

- **Fichiers** : `snake_case.gd`
- **Classes** : `PascalCase`
- **Variables/fonctions** : `snake_case`
- **Constantes** : `UPPER_SNAKE_CASE`
- **Indentation** : 4 espaces (pas de tabs)
- **Ligne max** : 100 caractères (120 toléré)
- **Typage** : Obligatoire pour fonctions publiques

**Exemple** :

```gdscript
class_name GridManager
extends Node2D

const GRID_SIZE = 4

@export var cell_size: int = 64

var current_position: Vector2i = Vector2i(0, 0)

func can_move_to(target_position: Vector2i) -> bool:
    if not _is_valid_position(target_position):
        return false
    return true

func _is_valid_position(pos: Vector2i) -> bool:
    return pos.x >= 0 and pos.x < GRID_SIZE and pos.y >= 0 and pos.y < GRID_SIZE
```

### Organisation des fichiers

```
scripts/
├── autoloads/          # Singletons (GameManager, EventBus)
├── game/               # Logique de jeu (GridManager, PlayerController, etc.)
├── ui/                 # Scripts UI (HUD, menus)
├── effects/            # Scripts effets (EventHandler)
└── utils/              # Utilitaires (Constants)

scenes/
├── main.tscn
├── game/               # Scènes de gameplay
├── ui/                 # Scènes UI
└── effects/            # Effets visuels

tests/
├── unit/               # Tests unitaires
└── integration/        # Tests d'intégration
```

### Markdown

- **Linter** : `markdownlint-cli2` (configuration `.markdownlint.json`)
- **Validation** : Obligatoire avant chaque commit
- **Commande** : `npx markdownlint-cli2 "**/*.md"`

## Process de commit

### Convention de messages

Format : `<type>: <description>`

**Types** :

| Type      | Usage                                          | Exemple                                    |
|-----------|------------------------------------------------|--------------------------------------------|
| `feat`    | Nouvelle fonctionnalité                        | `feat: add player movement`                |
| `fix`     | Correction de bug                              | `fix: correct key validation logic`        |
| `refactor`| Refactoring (pas de changement comportement)   | `refactor: extract constants to file`      |
| `docs`    | Documentation uniquement                       | `docs: update architecture diagram`        |
| `test`    | Ajout/modification de tests                    | `test: add unit tests for validator`       |
| `chore`   | Tâches diverses (config, assets, etc.)         | `chore: update gitignore`                  |
| `wip`     | Travail en cours (tests ne passent pas)        | `wip: implement explosion (visual broken)` |

**Règles** :

- ✅ Message en anglais, description en minuscules
- ✅ Description concise (< 72 caractères idéalement)
- ✅ Utiliser l'impératif ("add" pas "added" ou "adds")
- ❌ **Pas de signature AI** ("edited with claude", etc.)

**Exemples valides** :

```bash
git commit -m "feat: add grid manager with sudoku validation"
git commit -m "fix: protect prefilled cells from explosion"
git commit -m "refactor: simplify event probability selection"
git commit -m "docs: add architecture documentation"
git commit -m "test: add tests for inventory manager"
git commit -m "wip: implement teleportation (animation missing)"
```

### Commits WIP

Un commit WIP est acceptable si :

- Les tests ne passent pas encore
- La feature n'est pas complète
- Un blocage empêche la finalisation

**Obligation** : Le WIP doit être résolu dans la session suivante (commit `fix` ou `feat`).

### Atomicité

- 1 commit = 1 changement logique cohérent
- Éviter les commits "fourre-tout" (`fix: various changes`)
- Séparer features distinctes en commits distincts

## Pull Requests

### Avant d'ouvrir une PR

- [ ] Tous les tests passent (unitaires + manuels)
- [ ] Le linter markdown passe (0 erreurs)
- [ ] Le projet Godot se lance sans erreurs ni warnings
- [ ] Le code respecte les conventions
- [ ] La documentation est à jour
- [ ] Les commits sont propres (pas de WIP non résolu)

### Template de PR

Utilise le template automatique : [`.github/pull_request_template.md`](.github/pull_request_template.md)

**Sections à remplir** :

- **Description** : Résumé des changements
- **Type de changement** : Feature / Bug fix / Refactoring / etc.
- **Tests effectués** : Liste des tests
- **Checklist** : Vérifications obligatoires

### Review

- Les PR sont reviewées avant merge
- Délai de review : ~48h (best effort)
- Feedback constructif attendu
- Ajustements demandés à intégrer avant merge

### Merge

- **Stratégie** : Squash merge (par défaut) ou merge commit (phases)
- **Branche cible** : `main` (ou branche de phase active)
- **Après merge** : Supprimer la branche source

## Tests

### Tests unitaires

**Framework** : [Gut (Godot Unit Test)](https://github.com/bitwes/Gut)

**Localisation** : `tests/unit/test_*.gd`

**Exemple** :

```gdscript
# tests/unit/test_sudoku_validator.gd
extends GutTest

func test_is_placement_valid_row():
    var grid = [
        [1, 2, 3, 4],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]
    ]

    assert_false(
        SudokuValidator.is_placement_valid(grid, Vector2i(0, 0), 1),
        "Should reject duplicate in row"
    )

    assert_true(
        SudokuValidator.is_placement_valid(grid, Vector2i(0, 1), 1),
        "Should accept unique number in row"
    )
```

**Exécution** :

```bash
# Via Godot editor (panneau Gut)
# Ou en ligne de commande :
godot --headless --script tests/run_tests.gd
```

### Tests manuels

- **Documenter** : Noter les étapes dans le fichier de tests de session
- **Répétabilité** : Même test doit donner même résultat
- **Couverture** : Tester cas nominaux + edge cases

### Couverture de tests

- **Objectif** : > 70% du code critique
- **Priorité** :
  1. `SudokuValidator` (logique pure)
  2. `InventoryManager` (contraintes)
  3. `KeyManager` (simple mais critique)
  4. `GridManager` (intégration)

## Documentation

### Fichiers de documentation

- `README.md` : Vue d'ensemble du projet
- `EXECUTIVE_SUMMARY.md` : Pitch condensé (1 page)
- `docs/DESIGN_DOC.md` : Document de design complet
- `docs/GODOT_PROTO_SPECS.md` : Spécifications techniques Godot
- `docs/godot/CONVENTIONS.md` : Conventions de code
- `docs/godot/ARCHITECTURE.md` : Architecture technique
- `docs/workflow/SESSIONS.md` : Méthodologie de développement

### Mise à jour de la documentation

- **Quand** : À chaque changement significatif (architecture, mécaniques, conventions)
- **Format** : Markdown avec validation linter
- **Clarté** : Exemples de code + diagrammes si nécessaire

### Documentation du code

**Fonctions publiques** (obligatoire) :

```gdscript
## Vérifie si le joueur peut se déplacer vers une position cible.
##
## Args:
##     target_position: Position cible sur la grille (Vector2i)
##
## Returns:
##     bool: true si le mouvement est autorisé, false sinon
##
## Note:
##     Le joueur doit posséder la clé correspondant au numéro de la case cible.
func can_move_to(target_position: Vector2i) -> bool:
    pass
```

**Commentaires inline** (avec parcimonie) : Expliquer le "pourquoi", pas le "quoi".

## Commandes utiles

### Linter markdown

```bash
# Vérifier tous les fichiers
npx markdownlint-cli2 "**/*.md"

# Fixer automatiquement (certaines erreurs)
npx markdownlint-cli2 --fix "**/*.md"
```

### Vérification Godot

```bash
# Lancer projet en mode headless (vérifier erreurs)
godot --headless --check-only --path .

# Lancer tests unitaires
godot --headless --script tests/run_tests.gd
```

### Git

```bash
# Créer branche de feature
git checkout -b feat/my-feature

# Commit avec message conventionnel
git commit -m "feat: add my feature"

# Push branche
git push origin feat/my-feature

# Rebaser sur main (si besoin)
git fetch origin
git rebase origin/main
```

## Ressources

### Documentation interne

- [Architecture](docs/godot/ARCHITECTURE.md)
- [Conventions](docs/godot/CONVENTIONS.md)
- [Workflow sessions](docs/workflow/SESSIONS.md)
- [Templates workflow](docs/workflow/templates/)

### Documentation externe

- [Godot Documentation](https://docs.godotengine.org/en/stable/)
- [GDScript Style Guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html)
- [Gut Testing Framework](https://github.com/bitwes/Gut)

## Questions ?

- Ouvre une **issue** pour poser une question
- Consulte les **discussions** existantes
- Contacte les mainteneurs (voir README.md)

---

**Merci pour tes contributions ! 🎮**
