extends Node

const ENEMY_DESTROYED_EFFECT = preload("uid://cnfe726dlvbsw")

func _ready() -> void:
	var new_effect = ENEMY_DESTROYED_EFFECT.instantiate()
	get_tree().root.add_child(new_effect)
