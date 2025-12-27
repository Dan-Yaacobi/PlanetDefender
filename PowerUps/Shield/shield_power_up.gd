class_name ShieldPowerUp extends PowerUp
const SHIELD = preload("res://PowerUps/Shield/Shield.tscn")

func apply_power_up(_target: Node2D) -> void:
	if _target is Planet:
		var shield: Shield =  SHIELD.instantiate()
		_target.call_deferred("add_child",shield)
