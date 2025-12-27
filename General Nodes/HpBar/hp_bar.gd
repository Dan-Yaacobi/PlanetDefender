class_name HpBar extends TextureProgressBar

signal zero_health

func set_hp(_amount: float) -> void:
	max_value = _amount
	value = max_value
	
func take_hit(_amount: float) -> void:
	value -= _amount
	if value <= 0:
		zero_health.emit()
