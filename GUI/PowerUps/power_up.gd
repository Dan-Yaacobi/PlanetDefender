class_name PowerUpChoose extends Control

@onready var button: Button = $Button
@export var power_up: PowerUp
signal chosen

func _ready() -> void:
	button.pressed.connect(power_up_chosen)
	
func power_up_chosen() -> void:
	if power_up:
		power_up.apply_power_up(EventBus.current_planet)
	chosen.emit()

func disable() -> void:
	visible = false
	button.disabled = true

func enable() -> void:
	visible = true
	button.disabled = false
