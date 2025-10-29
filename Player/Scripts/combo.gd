class_name Combo extends Node2D

@onready var player: Player = $".."

@export var combo: int = 0

var enemy_was_hit: bool = false

func add_combo() -> void:
	if not enemy_was_hit:
		enemy_was_hit = true
	combo += 1
	EventBus.combo_added.emit(combo)
	pass
	
func check_combo() -> void:
	if not enemy_was_hit:
		combo = 0
		EventBus.combo_reset.emit()
	pass

func get_combo() -> int:
	return combo

func reset_combo_hit() -> void:
	enemy_was_hit = false
