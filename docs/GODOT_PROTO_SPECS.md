# Lab-doku - Spécifications Techniques Prototype Digital (Godot)

**Version** : 0.1 MVP
**Moteur** : Godot 4.x + GDScript
**Date** : Novembre 2025
**Statut** : Spécifications prêtes pour implémentation

---

## 📋 Table des Matières

1. [Scope MVP](#-scope-mvp)
2. [Paramètres Validés](#-paramètres-validés-tests-papier)
3. [Architecture Technique](#️-architecture-technique)
4. [Scènes et Nodes](#-scènes-et-nodes)
5. [Scripts GDScript](#-scripts-gdscript)
6. [Assets et UI](#-assets-et-ui)
7. [Roadmap d'Implémentation](#️-roadmap-dimplémentation)
8. [Métriques de Test](#-métriques-de-test)
9. [Critères de Validation MVP](#-critères-de-validation-mvp)
10. [Références](#-références)

---

## 🎯 Scope MVP

### Fonctionnalités Incluses (v0.1)

#### Core Loop ✅ PRIORITÉ 1

- ✅ Grille 4x4 avec 5-6 chiffres pré-remplis (3 grilles hardcodées)
- ✅ Système de déplacement avec contraintes de clés
- ✅ Placement de chiffres avec validation
- ✅ Inventaire d'indices (affichage et gestion)
- ✅ Système de clés (tracker visuel)
- ✅ Événements d'erreur (perte d'indice + téléportation)
- ✅ Gain d'indice par placement correct
- ✅ Game Over si inventaire vide
- ✅ Victoire si grille complétée
- ✅ Compteur d'erreurs

#### Navigation Spéciale ✅ PRIORITÉ 1

- ✅ Règle "rester sur case vide après placement sans clé"
- ✅ Empêcher retour sans clé appropriée

#### Feedback Visuel/Sonore 🎨 PRIORITÉ 2

- Animations de déplacement du joueur
- Feedback de placement (correct/erreur)
- Effets visuels des événements (explosion, téléportation, perte)
- Sons d'événements (boom, whoosh, buzzer)
- Particules basiques (facultatif mais recommandé)

#### UI Minimale 📱 PRIORITÉ 2

- Grille claire avec chiffres colorés
- Affichage inventaire d'indices (compteurs ou icônes)
- Tracker de clés possédées (4 cases à cocher visuelles)
- Compteur d'erreurs
- Écran Game Over
- Écran Victoire (avec score)

### Fonctionnalités Exclues (Post-MVP)

- ❌ Timer par série (Phase 5)
- ❌ Grilles 5x5 ou 6x6 (Phase 5)
- ❌ Génération procédurale de grilles (Phase 5)
- ❌ Poseur de bombe adverse (Phase 6+)
- ❌ Mode multijoueur (Phase 6+)
- ❌ Narration/cutscenes (Phase 6+)
- ❌ Art final/polish (Phase 6+)
- ❌ Musique complète (Phase 6+)

---

## ✅ Paramètres Validés (Tests Papier)

### État Initial du Joueur

```gdscript
# Grille 4x4 (16 cells)
const GRID_SIZE = 4

# Clés de départ (mode normal)
var starting_keys: Array[int] = [1, 3]  # Rouge et Bleu
# Mode facile: [1, 2, 3]
# Mode difficile: [1]

# Indices de départ
const STARTING_INDICES_COUNT = 2
# Fonction: generate_random_indices(count, respect_constraint)

# Position de départ
# Sur une case pré-remplie où le joueur possède la clé
```

### Contraintes de Ressources

```gdscript
# Contrainte inventaire
const MAX_SAME_NUMBER_TOTAL = 4  # grille + inventaire

# Compteur d'erreurs (illimité pour MVP)
var error_count: int = 0
```

### Système de Récompenses

```gdscript
# Par placement correct
const REWARD_PER_CORRECT_PLACEMENT = 1  # indice aléatoire

# Par série complétée (ligne/colonne/bloc 2x2)
const REWARD_KEY_PER_SERIES = 1  # clé au choix
const REWARD_INDICES_PER_SERIES = 2  # indices aléatoires (à ajuster si besoin)
```

### Événements d'Erreur

```gdscript
# Distribution recommandée (à ajuster selon tests)
const EVENT_PROBABILITIES = {
    "loss": 0.7,          # 70% Perte d'indice
    "teleportation": 0.3, # 30% Téléportation
    "explosion": 0.0      # 0% Explosion (désactivée pour MVP)
}

# Alternatives à tester:
# Option B: {"loss": 1.0, "teleportation": 0.0, "explosion": 0.0}  # 100% perte
# Option C: {"loss": 0.6, "teleportation": 0.3, "explosion": 0.1}  # Explosion rare
```

### Grilles Hardcodées

```gdscript
# 3 grilles pré-conçues pour MVP
# Chaque grille : solution unique, 5-6 chiffres pré-remplis, pas de blocage garanti

# Exemple Grille 1 (difficulté : tutoriel)
var GRID_1_PREFILLED = {
    Vector2i(0, 0): 1,
    Vector2i(2, 0): 3,
    Vector2i(1, 1): 3,
    Vector2i(3, 1): 1,
    Vector2i(0, 2): 3
}

var GRID_1_SOLUTION = [
    [1, 2, 3, 4],
    [4, 3, 2, 1],
    [3, 4, 1, 2],
    [2, 1, 4, 3]
]
```

---

## 🏗️ Architecture Technique

### Structure de Dossiers

```
prototypes/digital/godot_v01/
├── project.godot
├── scenes/
│   ├── Main.tscn                # Scène principale
│   ├── Grid.tscn                # Grille de jeu
│   ├── Cell.tscn                # Case individuelle
│   ├── Player.tscn              # Pion joueur
│   ├── UI/
│   │   ├── HUD.tscn             # Interface pendant jeu
│   │   ├── InventoryDisplay.tscn
│   │   ├── KeyTracker.tscn
│   │   ├── GameOver.tscn
│   │   └── Victory.tscn
│   └── VFX/
│       ├── ExplosionEffect.tscn
│       ├── TeleportEffect.tscn
│       └── LossEffect.tscn
├── scripts/
│   ├── GameManager.gd           # Gestionnaire principal
│   ├── Grid.gd                  # Logique de la grille
│   ├── Cell.gd                  # Logique d'une case
│   ├── Player.gd                # Contrôles et état du joueur
│   ├── InventorySystem.gd       # Gestion des indices
│   ├── KeySystem.gd             # Gestion des clés
│   ├── EventSystem.gd           # Événements d'erreur
│   ├── ValidationSystem.gd      # Validation sudoku
│   └── GridData.gd              # Données hardcodées des grilles
├── assets/
│   ├── sprites/                 # Placeholder art
│   │   ├── numbers/             # Chiffres colorés 1-4
│   │   ├── player.png           # Pion joueur
│   │   ├── cell_empty.png
│   │   └── keys/                # Icônes clés colorées
│   ├── sounds/
│   │   ├── place_correct.wav
│   │   ├── place_error.wav
│   │   ├── explosion.wav
│   │   ├── teleport.wav
│   │   └── loss.wav
│   └── fonts/
│       └── main_font.ttf
└── README.md
```

---

## 🎬 Scènes et Nodes

### Main.tscn (Scène Racine)

```
Main (Node2D)
├── GameManager (Node) [script: GameManager.gd]
├── Grid (Node2D) [script: Grid.gd]
├── Player (Node2D) [script: Player.gd]
├── Camera2D
├── UI (CanvasLayer)
│   ├── HUD (Control)
│   │   ├── InventoryDisplay (Control)
│   │   ├── KeyTracker (Control)
│   │   └── ErrorCounter (Label)
│   ├── GameOver (Control) [hidden]
│   └── Victory (Control) [hidden]
└── AudioManager (Node)
    ├── SFXPlayer (AudioStreamPlayer)
    └── MusicPlayer (AudioStreamPlayer)
```

### Grid.tscn

```
Grid (Node2D)
├── Background (Sprite2D)
├── Cells (Node2D)
│   └── Cell (instances, générées dynamiquement × 16)
└── GridLines (Line2D ou TileMap pour esthétique)
```

### Cell.tscn

```
Cell (Node2D) [script: Cell.gd]
├── Background (ColorRect ou Sprite2D)
├── Number (Label)          # Affichage du chiffre (1-4)
├── IndexToken (Sprite2D)   # Jeton indice posé sur la case (si applicable)
├── Highlight (ColorRect)   # Surbrillance pour cases accessibles/sélectionnées
└── Area2D (pour détection clic/hover)
    └── CollisionShape2D
```

### Player.tscn

```
Player (Node2D) [script: Player.gd]
├── Sprite2D (ou AnimatedSprite2D)
├── AnimationPlayer (pour déplacements fluides)
└── Tween (pour transitions)
```

---

## 📜 Scripts GDScript

### 1. GameManager.gd (Singleton ou Autoload)

**Responsabilités** :

- Initialisation du jeu
- Gestion du flow (menu → jeu → victoire/défaite)
- Coordination entre systèmes
- Gestion des états (PLAYING, GAME_OVER, VICTORY)

```gdscript
extends Node

enum GameState { PLAYING, GAME_OVER, VICTORY }

var current_state: GameState = GameState.PLAYING
var current_grid_index: int = 0  # Quelle grille hardcodée (0-2)
var error_count: int = 0

# Références aux systèmes
@onready var grid = $"../Grid"
@onready var player = $"../Player"
@onready var inventory_system = $InventorySystem
@onready var key_system = $KeySystem
@onready var event_system = $EventSystem

func _ready():
    initialize_game()

func initialize_game():
    # Charger grille hardcodée
    var grid_data = GridData.get_grid(current_grid_index)
    grid.setup_grid(grid_data)

    # Initialiser joueur (position, clés, indices)
    player.setup_initial_state(grid_data.starting_position)
    key_system.add_keys([1, 3])  # Mode normal
    inventory_system.generate_starting_indices(2)

    current_state = GameState.PLAYING

func on_number_placed(cell_position: Vector2i, number: int):
    var is_correct = grid.validate_placement(cell_position, number)

    if is_correct:
        grid.set_cell_value(cell_position, number)
        inventory_system.consume_index(number)
        inventory_system.add_random_index(1)  # Récompense

        # Vérifier séries complétées
        var completed_series = grid.check_completed_series(cell_position)
        if completed_series.size() > 0:
            on_series_completed(completed_series)

        # Vérifier victoire
        if grid.is_completed():
            trigger_victory()
    else:
        error_count += 1
        inventory_system.consume_index(number)
        event_system.trigger_random_event()

        # Vérifier Game Over
        if inventory_system.get_total_indices() == 0:
            trigger_game_over()

func on_series_completed(series: Array):
    # Récompenses : 1 clé + 2 indices
    # TODO: Demander au joueur quelle clé choisir (UI)
    key_system.add_key(2)  # Placeholder
    inventory_system.add_random_index(2)

func trigger_game_over():
    current_state = GameState.GAME_OVER
    # Afficher écran Game Over

func trigger_victory():
    current_state = GameState.VICTORY
    # Afficher écran Victory avec score (error_count)
```

---

### 2. Grid.gd

**Responsabilités** :

- Gestion de la grille 4x4 (cells)
- Validation sudoku
- Détection des séries complétées

```gdscript
extends Node2D

const GRID_SIZE = 4
const CELL_SIZE = 100  # pixels

var cells: Array[Cell] = []  # 16 cells
var solution: Array = []     # Solution complète hardcodée
var prefilled: Dictionary = {}  # {Vector2i: int}

func setup_grid(grid_data: Dictionary):
    solution = grid_data.solution
    prefilled = grid_data.prefilled

    # Créer les 16 cells
    for y in range(GRID_SIZE):
        for x in range(GRID_SIZE):
            var cell = preload("res://scenes/Cell.tscn").instantiate()
            cell.position = Vector2(x * CELL_SIZE, y * CELL_SIZE)
            cell.grid_position = Vector2i(x, y)

            # Si pré-remplie
            if prefilled.has(Vector2i(x, y)):
                cell.set_value(prefilled[Vector2i(x, y)], true)  # true = prefilled

            cells.append(cell)
            $Cells.add_child(cell)

func get_cell(pos: Vector2i) -> Cell:
    var index = pos.y * GRID_SIZE + pos.x
    return cells[index]

func validate_placement(pos: Vector2i, number: int) -> bool:
    return solution[pos.y][pos.x] == number

func set_cell_value(pos: Vector2i, number: int):
    get_cell(pos).set_value(number, false)

func check_completed_series(last_placed: Vector2i) -> Array:
    var completed = []

    # Vérifier ligne
    if is_row_complete(last_placed.y):
        completed.append({"type": "row", "index": last_placed.y})

    # Vérifier colonne
    if is_column_complete(last_placed.x):
        completed.append({"type": "column", "index": last_placed.x})

    # Vérifier bloc 2x2
    var block = get_block_index(last_placed)
    if is_block_complete(block):
        completed.append({"type": "block", "index": block})

    return completed

func is_row_complete(row: int) -> bool:
    for x in range(GRID_SIZE):
        if get_cell(Vector2i(x, row)).value == 0:
            return false
    return true

# ... is_column_complete, is_block_complete, etc.

func is_completed() -> bool:
    for cell in cells:
        if cell.value == 0:
            return false
    return true

func get_accessible_neighbors(pos: Vector2i, keys: Array[int]) -> Array[Vector2i]:
    var neighbors = []
    var directions = [Vector2i.UP, Vector2i.DOWN, Vector2i.LEFT, Vector2i.RIGHT]

    for dir in directions:
        var neighbor_pos = pos + dir
        if is_valid_position(neighbor_pos):
            var cell = get_cell(neighbor_pos)
            if cell.value != 0 and cell.value in keys:
                neighbors.append(neighbor_pos)
            elif cell.value == 0:  # Case vide
                neighbors.append(neighbor_pos)

    return neighbors

func is_valid_position(pos: Vector2i) -> bool:
    return pos.x >= 0 and pos.x < GRID_SIZE and pos.y >= 0 and pos.y < GRID_SIZE
```

---

### 3. Cell.gd

**Responsabilités** :

- Affichage du contenu de la case (chiffre, jeton indice)
- Interaction visuelle (hover, clic)

```gdscript
extends Node2D
class_name Cell

var grid_position: Vector2i
var value: int = 0           # 0 = vide, 1-4 = chiffre
var is_prefilled: bool = false
var has_index_token: bool = false
var index_token_value: int = 0

@onready var background = $Background
@onready var number_label = $Number
@onready var index_token_sprite = $IndexToken
@onready var highlight = $Highlight

func _ready():
    highlight.visible = false
    update_visuals()

func set_value(num: int, prefilled: bool):
    value = num
    is_prefilled = prefilled
    update_visuals()

func set_index_token(token_value: int):
    has_index_token = true
    index_token_value = token_value
    update_visuals()

func remove_index_token():
    has_index_token = false
    update_visuals()

func update_visuals():
    if value != 0:
        number_label.text = str(value)
        number_label.visible = true
        # Couleur selon chiffre
        match value:
            1: number_label.modulate = Color.RED
            2: number_label.modulate = Color.GREEN
            3: number_label.modulate = Color.BLUE
            4: number_label.modulate = Color.YELLOW
    else:
        number_label.visible = false

    if has_index_token:
        index_token_sprite.visible = true
        # Afficher chiffre du jeton
    else:
        index_token_sprite.visible = false

func set_highlighted(is_highlighted: bool):
    highlight.visible = is_highlighted
```

---

### 4. Player.gd

**Responsabilités** :

- Position du joueur sur la grille
- Déplacements
- Règle spéciale "rester sur case vide"

```gdscript
extends Node2D

var current_cell: Vector2i = Vector2i.ZERO
var previous_cell: Vector2i = Vector2i.ZERO
var can_stay_without_key: bool = false  # Règle spéciale

func setup_initial_state(starting_pos: Vector2i):
    current_cell = starting_pos
    update_position()

func move_to(target_cell: Vector2i):
    previous_cell = current_cell
    current_cell = target_cell
    can_stay_without_key = false  # Reset
    update_position()

func update_position():
    # Animation de déplacement
    var target_pos = Vector2(current_cell.x * 100, current_cell.y * 100)  # CELL_SIZE
    # Tween vers target_pos

func place_number_on_empty_cell(number: int):
    # Logique dans GameManager, mais Player peut activer la règle spéciale
    can_stay_without_key = true  # Maintenant le joueur peut rester sans clé

func check_can_access(target_cell: Vector2i, keys: Array[int]) -> bool:
    var grid = get_node("../Grid")
    var cell = grid.get_cell(target_cell)

    # Case vide : toujours accessible
    if cell.value == 0:
        return true

    # Case avec chiffre : besoin de la clé
    if cell.value in keys:
        return true

    # Cas spécial : je suis sur la case et j'ai posé un chiffre
    if target_cell == current_cell and can_stay_without_key:
        return true

    return false
```

---

### 5. InventorySystem.gd

**Responsabilités** :

- Gestion des indices numérotés (1-4)
- Contrainte ≤4 par chiffre
- Génération aléatoire

```gdscript
extends Node

var indices: Dictionary = {1: 0, 2: 0, 3: 0, 4: 0}  # {number: count}

signal inventory_changed(indices: Dictionary)

const MAX_SAME_NUMBER = 4

func generate_starting_indices(count: int):
    for i in range(count):
        add_random_index(1, true)  # respect_constraint = true

func add_random_index(count: int = 1, respect_constraint: bool = true):
    for i in range(count):
        var valid_numbers = [1, 2, 3, 4]

        if respect_constraint:
            var grid = get_node("../Grid")
            # Filtrer les nombres qui dépasseraient la contrainte
            # TODO: compter occurrences dans grille
            pass

        var number = valid_numbers[randi() % valid_numbers.size()]
        add_index(number)

func add_index(number: int):
    indices[number] += 1
    inventory_changed.emit(indices)

func consume_index(number: int):
    if indices[number] > 0:
        indices[number] -= 1
        inventory_changed.emit(indices)

func has_index(number: int) -> bool:
    return indices[number] > 0

func get_total_indices() -> int:
    return indices[1] + indices[2] + indices[3] + indices[4]
```

---

### 6. KeySystem.gd

**Responsabilités** :

- Gestion des clés possédées (1-4)

```gdscript
extends Node

var keys: Array[int] = []  # Liste des clés possédées

signal keys_changed(keys: Array[int])

func add_key(key: int):
    if key not in keys:
        keys.append(key)
        keys_changed.emit(keys)

func add_keys(key_list: Array[int]):
    for key in key_list:
        add_key(key)

func has_key(key: int) -> bool:
    return key in keys

func get_keys() -> Array[int]:
    return keys
```

---

### 7. EventSystem.gd

**Responsabilités** :

- Génération d'événements aléatoires selon probabilités
- Exécution des événements (perte, téléportation, explosion)

```gdscript
extends Node

const EVENT_PROBABILITIES = {
    "loss": 0.7,
    "teleportation": 0.3,
    "explosion": 0.0
}

func trigger_random_event():
    var rand = randf()
    var cumulative = 0.0

    for event_type in EVENT_PROBABILITIES:
        cumulative += EVENT_PROBABILITIES[event_type]
        if rand <= cumulative:
            execute_event(event_type)
            return

func execute_event(event_type: String):
    match event_type:
        "loss":
            execute_loss_event()
        "teleportation":
            execute_teleportation_event()
        "explosion":
            execute_explosion_event()

func execute_loss_event():
    var inventory = get_node("../GameManager/InventorySystem")
    var available_indices = []

    # Lister tous les indices disponibles
    for number in [1, 2, 3, 4]:
        for i in range(inventory.indices[number]):
            available_indices.append(number)

    if available_indices.size() > 0:
        var random_index = available_indices[randi() % available_indices.size()]
        inventory.consume_index(random_index)

        # VFX + SFX
        show_loss_effect()
        play_sound("loss")

func execute_teleportation_event():
    var grid = get_node("../Grid")
    var player = get_node("../Player")

    # Trouver toutes les cases pré-remplies
    var prefilled_cells = []
    for pos in grid.prefilled:
        prefilled_cells.append(pos)

    if prefilled_cells.size() > 0:
        var random_cell = prefilled_cells[randi() % prefilled_cells.size()]
        player.move_to(random_cell)

        # VFX + SFX
        show_teleport_effect(random_cell)
        play_sound("teleport")

func execute_explosion_event():
    # Effacer 4 cases adjacentes (croix)
    # TODO si activé
    pass

func show_loss_effect():
    # Instancier LossEffect.tscn
    pass

func show_teleport_effect(pos: Vector2i):
    # Instancier TeleportEffect.tscn à la position
    pass

func play_sound(sound_name: String):
    # AudioManager.play_sfx(sound_name)
    pass
```

---

### 8. GridData.gd (Autoload)

**Responsabilités** :

- Stocker les 3 grilles hardcodées

```gdscript
extends Node

func get_grid(index: int) -> Dictionary:
    match index:
        0: return GRID_1
        1: return GRID_2
        2: return GRID_3
        _: return GRID_1

const GRID_1 = {
    "solution": [
        [1, 2, 3, 4],
        [4, 3, 2, 1],
        [3, 4, 1, 2],
        [2, 1, 4, 3]
    ],
    "prefilled": {
        Vector2i(0, 0): 1,
        Vector2i(2, 0): 3,
        Vector2i(1, 1): 3,
        Vector2i(3, 1): 1,
        Vector2i(0, 2): 3
    },
    "starting_position": Vector2i(0, 0),
    "index_tokens": {  # Jetons indices posés sur la grille
        Vector2i(1, 0): 2,
        Vector2i(3, 2): 4
    }
}

const GRID_2 = {
    # TODO: Définir grille 2
}

const GRID_3 = {
    # TODO: Définir grille 3
}
```

---

## 🎨 Assets et UI

### Assets Placeholder

**Sprites** :

- Chiffres 1-4 colorés (Rouge, Vert, Bleu, Jaune)
- Pion joueur : cercle simple
- Cases : carrés avec bordures
- Clés : icônes colorées simples
- Jetons indices : petits cercles numérotés

**Sons** :

- `place_correct.wav` : Ding positif
- `place_error.wav` : Buzzer négatif
- `explosion.wav` : Boom
- `teleport.wav` : Whoosh
- `loss.wav` : Cloche triste

**Polices** :

- Police claire et lisible pour chiffres (taille 48-64px)

### UI Minimale

#### HUD.tscn

```
HUD (Control)
├── InventoryDisplay (HBoxContainer)
│   ├── Index1Count (Label) "1: X"
│   ├── Index2Count (Label) "2: X"
│   ├── Index3Count (Label) "3: X"
│   └── Index4Count (Label) "4: X"
├── KeyTracker (HBoxContainer)
│   ├── Key1 (TextureRect) [Colored, visible if owned]
│   ├── Key2 (TextureRect)
│   ├── Key3 (TextureRect)
│   └── Key4 (TextureRect)
└── ErrorCounter (Label) "Erreurs: X"
```

#### GameOver.tscn

```
GameOver (Control)
├── Panel (ColorRect) [semi-transparent]
├── Title (Label) "GAME OVER"
├── Message (Label) "Inventaire vide"
├── ErrorCount (Label) "Erreurs: X"
└── RestartButton (Button) "Recommencer"
```

#### Victory.tscn

```
Victory (Control)
├── Panel (ColorRect) [semi-transparent]
├── Title (Label) "VICTOIRE !"
├── ErrorCount (Label) "Score: X erreurs"
└── Buttons (HBoxContainer)
    ├── NextGridButton (Button) "Grille Suivante"
    └── RestartButton (Button) "Recommencer"
```

---

## 🗺️ Roadmap d'Implémentation

### Sprint 1 : Fondations (3-5h)

1. **Setup projet Godot**
   - Créer projet Godot 4.x
   - Structure de dossiers
   - Import assets placeholder

2. **Grille de base**
   - Créer Grid.tscn et Cell.tscn
   - Script Grid.gd : générer 16 cells
   - Affichage grille 4x4 visuelle

3. **Grilles hardcodées**
   - GridData.gd avec 3 grilles
   - Grid.gd : charger grille depuis GridData

4. **Player basique**
   - Player.tscn avec sprite
   - Placement sur grille au démarrage

### Sprint 2 : Core Loop (5-8h)

1. **Système de déplacement**
   - Détection cases adjacentes
   - Contraintes de clés
   - Animation de déplacement

2. **Système de clés**
   - KeySystem.gd
   - UI KeyTracker
   - Intégration avec déplacement

3. **Placement de chiffres**
   - UI de sélection d'indice
   - Validation sudoku
   - Feedback visuel correct/erreur

4. **Inventaire d'indices**
   - InventorySystem.gd
   - Contrainte ≤4
   - UI InventoryDisplay
   - Génération démarrage (2 aléatoires)

### Sprint 3 : Événements et Feedback (4-6h)

1. **EventSystem.gd**
   - Probabilités configurables
   - Perte d'indice
   - Téléportation

2. **VFX et SFX**
   - Effets visuels basiques (particules)
   - Sons d'événements
   - Animations de placement

3. **Game Over et Victoire**
   - Détection inventaire vide
   - Détection grille complétée
   - Écrans UI

### Sprint 4 : Polish et Tests (3-5h)

1. **Navigation spéciale**
   - Règle "rester sans clé"
   - Empêcher retour sans clé

2. **Séries complétées**
   - Détection lignes/colonnes/blocs
   - Récompenses (clé + indices)
   - UI de choix de clé

3. **Gain par placement**
   - +1 indice à chaque correct

4. **Tests et ajustements**
   - Tester les 3 grilles
   - Ajuster probabilités événements
   - Ajuster récompenses si besoin

**Durée totale estimée** : 15-24 heures de développement

---

## 🧪 Métriques de Test

### Objectifs MVP (Phase 4)

- [ ] **3-5 personnes** l'ont testé et compris
- [ ] **Taux de complétion > 70%** (au moins 1 grille terminée)
- [ ] **Temps moyen : 7-12 minutes** par grille
- [ ] **Au moins 2 retours positifs spontanés**
- [ ] **Pas de bugs bloquants**
- [ ] **Le core loop est satisfaisant**

### Métriques à Logger Automatiquement

```gdscript
# À implémenter dans GameManager
var metrics = {
    "start_time": 0,
    "end_time": 0,
    "errors": 0,
    "correct_placements": 0,
    "events_triggered": {"loss": 0, "teleportation": 0, "explosion": 0},
    "series_completed": {"row": 0, "column": 0, "block": 0},
    "keys_obtained": [],
    "final_outcome": ""  # "victory" ou "game_over"
}

func log_metrics():
    # Sauvegarder dans fichier JSON ou afficher dans console
    print("=== MÉTRIQUES ===")
    print("Durée: ", (metrics.end_time - metrics.start_time) / 60.0, " minutes")
    print("Erreurs: ", metrics.errors)
    print("Placements corrects: ", metrics.correct_placements)
    print("Événements: ", metrics.events_triggered)
    print("Résultat: ", metrics.final_outcome)
```

### Questions Post-Test (Questionnaire Utilisateur)

1. As-tu compris les règles en moins de 2 minutes ? (Oui/Non)
2. As-tu terminé au moins une grille ? (Oui/Non)
3. As-tu été bloqué sans pouvoir progresser ? (Oui/Non)
4. Les événements d'erreur étaient-ils frustrants ou intéressants ? (1-5)
5. As-tu envie de rejouer ? (Oui/Non)
6. Note globale de fun (1-10)
7. Commentaires libres

---

## 🎯 Critères de Validation MVP

### GO pour Phase 5 (Mécaniques Avancées) si

- ✅ Taux de complétion > 70%
- ✅ Fun rating moyen > 6/10
- ✅ Règles comprises par tous les testeurs
- ✅ Pas de bugs critiques
- ✅ Feedback positif sur le core loop

### Ajustements Nécessaires si

- ⚠️ Taux de complétion < 50% → Réduire difficulté ou améliorer tutoriel
- ⚠️ Durée moyenne < 5 min ou > 15 min → Ajuster nombre de cases pré-remplies
- ⚠️ Événements trop frustrants → Ajuster probabilités (augmenter perte, réduire explosion)

### NO-GO (Pivot ou Refonte) si

- ❌ Fun rating < 4/10
- ❌ Personne ne termine une grille
- ❌ Core loop pas satisfaisant

---

## 📚 Références

- **Design Doc complet** : [`DESIGN_DOC.md`](DESIGN_DOC.md)
- **Résultats tests papier** : [`PAPER_PROTOTYPE_TEST_RESULTS.md`](PAPER_PROTOTYPE_TEST_RESULTS.md)
- **Godot Docs** : <https://docs.godotengine.org/en/stable/>
- **GDScript Style Guide** : <https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html>

---

**Document créé le** : 2025-11-11
**Prêt pour implémentation** : ✅ Oui
**Prochaine étape** : Créer le projet Godot et commencer Sprint 1
