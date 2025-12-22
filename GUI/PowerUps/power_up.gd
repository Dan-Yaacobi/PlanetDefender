class_name PowerUp extends Control

@onready var button: Button = $Button

signal chosen

func _ready() -> void:
	button.pressed.connect(power_up_chosen)
	
func power_up_chosen() -> void:
	chosen.emit()

func disable() -> void:
	visible = false
	button.disabled = true

func enable() -> void:
	visible = true
	button.disabled = false
