class_name PowerUps extends Control

var power_ups: Array[PowerUp]
var objective_completed_id: int

func _ready() -> void:
	for power in get_children():
		if power is PowerUp:
			power_ups.append(power)
			power.chosen.connect(power_up_chosen)
			power.disable()
	EventBus.objective_completed.connect(enable_all)

func power_up_chosen() -> void:
	disable_all()
	EventBus.new_objective.emit(objective_completed_id)

func disable_all() -> void:
	for power in power_ups:
		power.disable()

func enable_all(_id: int) -> void:
	for power in power_ups:
		power.enable()
	objective_completed_id = _id
