# Conventions Godot - Lab-doku

Ce document définit les conventions de code et d'organisation pour le projet Lab-doku sous Godot 4.x.

## Style GDScript

### Nommage

**Classes et fichiers**

- Noms de fichiers : `snake_case.gd` (ex: `grid_manager.gd`, `player_controller.gd`)
- Noms de classes : `PascalCase` (ex: `GridManager`, `PlayerController`)
- Noms de scènes : `snake_case.tscn` (ex: `game_scene.tscn`, `cell.tscn`)

**Variables et fonctions**

- Variables : `snake_case` (ex: `current_position`, `key_inventory`)
- Constantes : `UPPER_SNAKE_CASE` (ex: `MAX_GRID_SIZE`, `EVENT_EXPLOSION`)
- Fonctions : `snake_case` (ex: `move_player()`, `validate_placement()`)
- Fonctions privées : préfixe `_` (ex: `_update_internal_state()`)
- Signaux : `snake_case` (ex: `key_obtained`, `cell_placed`)
- Enums : `PascalCase` pour le type, `UPPER_SNAKE_CASE` pour les valeurs

```gdscript
enum CellState {
    EMPTY,
    PREFILLED,
    PLAYER_FILLED
}

enum EventType {
    EXPLOSION,
    TELEPORTATION,
    LOSS
}
```

### Indentation et formatage

- **Indentation** : 4 espaces (pas de tabs)
- **Ligne maximale** : 100 caractères (recommandé), 120 maximum
- **Espaces** :
  - Autour des opérateurs : `a = b + c` (pas `a=b+c`)
  - Après les virgules : `func foo(a, b, c)` (pas `func foo(a,b,c)`)
  - Pas d'espaces avant `:` dans les types
- **Lignes vides** :
  - 2 lignes vides entre les fonctions de haut niveau
  - 1 ligne vide entre les méthodes dans une classe
  - 1 ligne vide pour séparer les blocs logiques

### Organisation des fichiers GDScript

**Ordre des sections** (suivre cet ordre strict) :

```gdscript
# 1. Déclaration de classe (si applicable)
class_name GridManager
extends Node2D

# 2. Documentation de classe (si pertinent)
## Gère la grille de sudoku 4x4 et valide les placements.
## Émet des signaux pour les événements de jeu.

# 3. Signaux
signal cell_placed(position: Vector2i, number: int, is_correct: bool)
signal key_obtained(number: int)
signal game_won()

# 4. Enums
enum CellState {
    EMPTY,
    PREFILLED,
    PLAYER_FILLED
}

# 5. Constantes
const GRID_SIZE = 4
const MAX_SAME_NUMBER = 4

# 6. Variables exportées (@export)
@export var cell_size: int = 64
@export var starting_keys: Array[int] = [1, 2]

# 7. Variables publiques (onready si nécessaire)
@onready var grid_container = $GridContainer

var current_position: Vector2i = Vector2i(0, 0)
var key_inventory: Array[int] = []

# 8. Variables privées
var _solution_grid: Array[Array] = []
var _player_grid: Array[Array] = []

# 9. Fonctions built-in Godot (dans cet ordre)
func _init():
    pass

func _ready():
    _initialize_grid()
    _setup_signals()

func _process(delta: float):
    pass

func _physics_process(delta: float):
    pass

func _input(event: InputEvent):
    pass

func _unhandled_input(event: InputEvent):
    pass

# 10. Fonctions publiques (alphabétique recommandé)
func can_move_to(target_position: Vector2i) -> bool:
    if not _is_valid_position(target_position):
        return false

    var target_number = get_cell_number(target_position)
    return has_key(target_number)

func place_number(position: Vector2i, number: int) -> bool:
    if not _is_valid_placement(position, number):
        return false

    _player_grid[position.y][position.x] = number
    var is_correct = _validate_placement(position, number)

    cell_placed.emit(position, number, is_correct)
    return is_correct

# 11. Fonctions privées (alphabétique recommandé)
func _initialize_grid() -> void:
    # Implémentation...
    pass

func _is_valid_position(pos: Vector2i) -> bool:
    return pos.x >= 0 and pos.x < GRID_SIZE and pos.y >= 0 and pos.y < GRID_SIZE

func _validate_placement(pos: Vector2i, number: int) -> bool:
    # Implémentation...
    return true
```

### Commentaires et documentation

**Documentation des fonctions publiques** (obligatoire) :

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

**Commentaires inline** (avec parcimonie) :

```gdscript
# Bon : explique le "pourquoi"
# On protège les cases pré-remplies contre les explosions
if cell_state == CellState.PREFILLED:
    continue

# Mauvais : répète le "quoi" (évident dans le code)
# Incrémente le compteur
counter += 1
```

### Types et annotations

**Typage fort recommandé** (obligatoire pour les fonctions publiques) :

```gdscript
# Bon
func get_cell_number(pos: Vector2i) -> int:
    return _player_grid[pos.y][pos.x]

func calculate_adjacent_cells(pos: Vector2i) -> Array[Vector2i]:
    var result: Array[Vector2i] = []
    # ...
    return result

# Acceptable pour variables locales évidentes
var count = 0  # Type inféré comme int

# À éviter
func get_cell_number(pos):  # Pas de type
    return _player_grid[pos.y][pos.x]
```

### Gestion des erreurs

**Assertions et validation** :

```gdscript
func place_number(position: Vector2i, number: int) -> bool:
    # Assertions pour détecter les bugs en développement
    assert(number >= 1 and number <= GRID_SIZE, "Number out of range")
    assert(_is_valid_position(position), "Invalid position")

    # Validation pour les entrées runtime
    if not has_index_token(number):
        push_warning("Attempted to place number without token: %d" % number)
        return false

    # ...
    return true
```

**Messages d'erreur clairs** :

```gdscript
# Bon
push_error("GridManager: Failed to load solution grid from file: %s" % file_path)

# Mauvais
print("error")  # Pas informatif
```

## Structure des fichiers et dossiers

### Organisation du projet

```
lab-doku/
├── project.godot
├── .gitignore
├── .gitattributes
├── export_presets.cfg
│
├── assets/                      # Ressources (sprites, sons, etc.)
│   ├── sprites/
│   ├── sounds/
│   └── fonts/
│
├── scenes/                      # Scènes Godot (.tscn)
│   ├── main.tscn               # Scène principale
│   ├── game/                    # Scènes de gameplay
│   │   ├── game_scene.tscn
│   │   ├── grid.tscn
│   │   └── cell.tscn
│   ├── ui/                      # Scènes UI
│   │   ├── hud.tscn
│   │   └── inventory_display.tscn
│   └── effects/                 # Effets visuels
│       ├── explosion.tscn
│       └── teleport.tscn
│
├── scripts/                     # Scripts GDScript (.gd)
│   ├── autoloads/               # Singletons/Autoloads
│   │   ├── game_manager.gd
│   │   └── event_bus.gd
│   ├── game/                    # Logique de jeu
│   │   ├── grid_manager.gd
│   │   ├── player_controller.gd
│   │   ├── inventory_manager.gd
│   │   ├── key_manager.gd
│   │   └── sudoku_validator.gd
│   ├── ui/                      # Scripts UI
│   │   ├── hud.gd
│   │   └── inventory_display.gd
│   ├── effects/                 # Scripts d'effets
│   │   └── event_handler.gd
│   └── utils/                   # Utilitaires
│       └── constants.gd
│
└── tests/                       # Tests (à créer en fin de session)
    ├── unit/
    │   └── test_sudoku_validator.gd
    └── integration/
        └── test_game_flow.gd
```

### Séparation scènes/scripts

**Principe** : Un script par scène principale, attaché à la racine de la scène.

```
grid.tscn           -> scripts/game/grid_manager.gd
cell.tscn           -> scripts/game/cell.gd
hud.tscn            -> scripts/ui/hud.gd
```

**Exception** : Scripts purement logiques (pas de composant visuel) peuvent exister seuls.

```
scripts/game/sudoku_validator.gd     # Pas de scène associée
scripts/game/inventory_manager.gd    # Pas de scène associée
```

## Principes de code

### KISS (Keep It Simple, Stupid)

- Privilégier la clarté à la concision
- Une fonction = une responsabilité
- Éviter l'over-engineering

```gdscript
# Bon : simple et clair
func is_cell_empty(pos: Vector2i) -> bool:
    return _player_grid[pos.y][pos.x] == 0

# Mauvais : trop "clever"
func is_cell_empty(pos: Vector2i) -> bool:
    return not bool(_player_grid[pos.y][pos.x] if _is_valid_position(pos) else 1)
```

### DRY (Don't Repeat Yourself)

- Extraire le code dupliqué en fonctions
- Utiliser des constantes pour les valeurs magiques

```gdscript
# Bon
const DIRECTIONS = [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]

func get_adjacent_positions(pos: Vector2i) -> Array[Vector2i]:
    var result: Array[Vector2i] = []
    for direction in DIRECTIONS:
        var adjacent = pos + direction
        if _is_valid_position(adjacent):
            result.append(adjacent)
    return result

# Mauvais : duplication
func get_adjacent_positions(pos: Vector2i) -> Array[Vector2i]:
    var result: Array[Vector2i] = []
    if pos.y > 0:  # UP
        result.append(Vector2i(pos.x, pos.y - 1))
    if pos.y < GRID_SIZE - 1:  # DOWN
        result.append(Vector2i(pos.x, pos.y + 1))
    # ...
    return result
```

### Single Responsibility Principle

Chaque classe/script doit avoir **une seule raison de changer**.

**Exemples** :

- `GridManager` : Gère l'état de la grille uniquement
- `SudokuValidator` : Valide les placements uniquement
- `PlayerController` : Gère les déplacements du joueur uniquement
- `InventoryManager` : Gère l'inventaire d'indices uniquement

Si une classe fait trop de choses → découper.

### Composition over Inheritance

Privilégier la composition (nodes enfants, scripts séparés) à l'héritage.

```gdscript
# Bon : composition
# game_scene.tscn contient des nodes enfants
GridManager (Node2D)
PlayerController (Node2D)
InventoryManager (Node)
EventHandler (Node)

# Acceptable : héritage simple
class_name BaseCell
extends Node2D
# Logique commune aux cellules

class_name NumberCell
extends BaseCell
# Spécialisation pour cellules numériques
```

## Conventions Git

Voir `CONTRIBUTING.md` pour les détails complets.

**Messages de commit** :

- Format : `<type>: <description courte>`
- Types : `feat`, `fix`, `refactor`, `docs`, `test`, `chore`, `wip`
- Pas de signature AI dans les commits
- Inclure "WIP" si les tests ne passent pas

**Exemples** :

```
feat: add grid manager with sudoku validation
fix: correct key requirement check for empty cells
refactor: extract event probability logic to constants
wip: implement event system (tests failing)
```

## Workflow de développement

Voir `docs/workflow/SESSIONS.md` pour le cycle complet RED→GREEN→REFACTO→REFLECT.

**Résumé** :

1. **RED** : Définir l'objectif/test (ce qui doit fonctionner)
2. **GREEN** : Implémenter la solution minimale
3. **REFACTO** : Nettoyer le code, appliquer les conventions
4. **REFLECT** : Mini-rétro (5 min), noter les apprentissages

## Validation automatique

**Avant chaque commit** :

- Linter markdown : `npx markdownlint-cli2 "**/*.md"`
- Vérification Godot : Ouvrir le projet, vérifier qu'il se lance sans erreurs
- Tests unitaires (quand disponibles) : `godot --headless --script tests/run_tests.gd`

**Commandes slash Claude disponibles** :

- `/lint-markdown` : Lance le linter sur tous les fichiers markdown
- `/godot-check` : Vérifie que le projet Godot compile
- `/start-session` : Démarre une nouvelle session de travail
- `/end-session` : Termine la session, génère rétro et fichier de tests

## Références

- [GDScript Style Guide officiel](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html)
- [Godot Best Practices](https://docs.godotengine.org/en/stable/tutorials/best_practices/index.html)
- Documentation projet : `docs/DESIGN_DOC.md`, `docs/GODOT_PROTO_SPECS.md`

**Dernière mise à jour** : 2025-11-11
