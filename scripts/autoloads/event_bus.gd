extends Node

## Hub centralisé pour la communication inter-systèmes via signaux.
##
## EventBus est un singleton (autoload) qui permet aux différents composants du jeu
## de communiquer sans se connaître directement (découplage).

# Signaux de gameplay
signal player_moved(from: Vector2i, to: Vector2i)
signal cell_placement_attempted(position: Vector2i, number: int)
signal cell_placement_validated(position: Vector2i, number: int, is_correct: bool)

# Signaux de ressources
signal key_obtained(number: int)
signal index_collected(number: int)
signal index_consumed(number: int)
signal index_lost(number: int)

# Signaux d'événements
signal error_event_triggered(event_type: String)
signal explosion_occurred(center: Vector2i, affected_cells: Array[Vector2i])
signal teleportation_occurred(from: Vector2i, to: Vector2i)

# Signaux de série complétée
signal series_completed(series_type: String, index: int)  # "row", "column", "block"

# Signaux de fin de partie
signal game_won()
signal game_lost()


func _ready() -> void:
    print("EventBus initialized")
    print("  Available signals: %d" % get_signal_list().size())
