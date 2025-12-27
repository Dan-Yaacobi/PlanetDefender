class_name Movement extends Resource

var entity: Enemy

func set_entity(_entity: Enemy) -> void:
	if _entity:
		entity = _entity
	
func apply_movement(delta: float, planet_pos: Vector2) -> void:
	pass
