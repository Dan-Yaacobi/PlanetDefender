class_name ObjectiveDisplay extends Control

@onready var label: Label = $Label
@onready var amount_label: Label = $Amount

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


func update_label(_objective_text: String, _amount_left: String, _total: String) -> void:
	label.text = _objective_text
	amount_label.text = _amount_left + "/" + _total
	
func disable() -> void:
	set_objective(null)
	available = false
	visible = false
