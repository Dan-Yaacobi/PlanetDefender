class_name Objective extends Node2D

var display_id: int
var active: bool = true

func set_up(_id: int, tier: int) -> void:
	set_display_id(_id)
	extra_setup_methods(tier)
	
func set_display_id(_id: int) -> void:
	display_id = _id
	active = true
	
func extra_setup_methods(_tier: int) -> void:
	pass

func update_objective(_enemy: Enemy) -> void:
	pass

func objective_complete() -> void:
	pass

func update_label() -> void:
	pass
