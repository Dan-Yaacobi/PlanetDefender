class_name ObjectiveManager extends Control

@export var objectives: Array[PackedScene]

var objectives_display: Array[ObjectiveDisplay]
var total_available_objectives: int = 0

func _ready() -> void:
	EventBus.update_objective.connect(update_display)
	EventBus.new_objective.connect(reset_objective)
	for obj in get_children():
		if obj is ObjectiveDisplay:
			objectives_display.append(obj)
			if obj.available:
				total_available_objectives += 1
	test()
	
func add_objective(new_obj: Objective) -> void:
	if new_obj:
		for obj in objectives_display:
			if not obj.is_occupied():
				obj.set_objective(new_obj)
				new_obj.set_up(obj.objective_display_ID,0)
				return

func unlock_new_objective() -> void:
	pass

func reset_objective(obj_id: int) -> void:
	remove_objective(obj_id)
	test()

func remove_objective(obj_id: int) -> void:
	if obj_id <= total_available_objectives:
		objectives_display[obj_id].disable()

func test() -> void:
	add_objective(objectives.pick_random().instantiate())
	pass

func update_display(_id: int, _text: String) -> void:
	objectives_display[_id].update_label(_text)
	pass
