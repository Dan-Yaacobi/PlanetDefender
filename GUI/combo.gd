class_name ComboLabel extends Control

@onready var label: Label = $Label

func _ready() -> void:
	EventBus.combo_added.connect(update_label)
	EventBus.combo_reset.connect(reset_label)
	pass
	
func update_label(_amount: int) -> void:
	label.text = "Combo: " + str(_amount)

func reset_label() -> void:
	label.text = "Combo: 0"
