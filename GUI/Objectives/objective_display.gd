class_name ObjectiveDisplay extends Control

@onready var label: Label = $Label

@export var objective_display_ID: int
@export var curr_objective: Objective = null
@export var available: bool = false

func is_occupied() -> bool:
	if curr_objective:
		return true
	return false

func set_objective(new_obj: Objective) -> void:
	curr_objective = new_obj
	available = true
	visible = true


func update_label(_text: String) -> void:
	label.text = _text

func disable() -> void:
	set_objective(null)
	available = false
	visible = false
