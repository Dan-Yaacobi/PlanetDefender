class_name HpBar extends ProgressBar

signal zero_health

func set_hp(_amount: int) -> void:
	max_value = _amount
	value = max_value
	
func take_hit(_amount: int) -> void:
	value -= _amount
	if value <= 0:
		zero_health.emit()
