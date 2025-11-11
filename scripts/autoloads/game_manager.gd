extends Node

## Gère l'état global du jeu et coordination des systèmes.
##
## GameManager est un singleton (autoload) qui maintient l'état de la partie en cours
## et coordonne les différents sous-systèmes du jeu.

# Configuration de partie
var grid_size: int = 4
var difficulty: String = "normal"

# État de partie
var is_game_active: bool = false
var error_count: int = 0
var placement_count: int = 0
var start_time: float = 0.0

# Paramètres de jeu (constants depuis GODOT_PROTO_SPECS.md)
const STARTING_KEYS_COUNT = 2
const STARTING_INDICES_COUNT = 2
const MAX_SAME_NUMBER_TOTAL = 4

const EVENT_PROBABILITIES = {
    "loss": 0.7,          # 70% Perte d'indice
    "teleportation": 0.3, # 30% Téléportation
    "explosion": 0.0      # 0% Explosion (désactivé pour MVP)
}


func _ready() -> void:
    print("GameManager initialized")
    print("  Grid size: %d" % grid_size)
    print("  Difficulty: %s" % difficulty)


func start_new_game() -> void:
    """Initialise une nouvelle partie."""
    is_game_active = true
    error_count = 0
    placement_count = 0
    start_time = Time.get_ticks_msec() / 1000.0
    print("New game started")


func end_game(victory: bool) -> void:
    """Termine la partie en cours."""
    is_game_active = false
    var duration = (Time.get_ticks_msec() / 1000.0) - start_time
    print("Game ended - Victory: %s, Duration: %.1fs, Errors: %d" % [victory, duration, error_count])
