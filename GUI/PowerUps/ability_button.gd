class_name AbilityButton extends TextureButton

@export var power_up: PowerUp

func set_power_up(_power_up: PowerUp) -> void:
	power_up = _power_up
	texture_normal = _power_up.texture
	pass

func activate_ability() -> void:
	if power_up:
		power_up.apply_power_up()
		clear_used_ability()
		
func clear_used_ability() -> void:
	power_up = null
	texture_normal = null
	pass
