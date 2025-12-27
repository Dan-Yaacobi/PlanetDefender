class_name StraightMovement extends Movement

func apply_movement(delta: float, planet_pos: Vector2) -> void:
	var curr_direction = entity.calc_direction()
	entity.velocity += curr_direction * entity.get_speed() * delta
