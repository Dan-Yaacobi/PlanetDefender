class_name Clock extends Control

@onready var time_label: Label = $Time

var total_time: float
var current_time: float

func set_time(_total_time: float, _curr_time: float) -> void:
	total_time = _total_time
	current_time = _curr_time
	
func _process(delta: float) -> void:
	
	pass
