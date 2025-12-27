class_name CircularMovement extends Movement

@export var spiral_in_strength: float = 220.0      # higher = faster collapse inward
@export var orbit_turn_strength: float = 230.0     # higher = stronger "circular" behavior
@export var steering: float = 10.0                # how fast velocity changes (smoothness)
@export var min_impact_distance: float = 14.0     # treat as impact when close enough


func apply_movement(delta: float, planet_pos: Vector2) -> void:
	if entity == null:
		return

	var to_planet: Vector2 = planet_pos - entity.global_position
	var distance: float = to_planet.length()

	# Impact condition
	if distance <= min_impact_distance:
		entity.velocity = Vector2.ZERO
		entity.move_and_slide()
		return

	# Radial direction (toward planet)
	var radial_dir: Vector2 = to_planet / distance

	# Tangential direction for orbiting (clockwise)
	var tangent_dir: Vector2 = Vector2(-radial_dir.y, radial_dir.x)

	# Weight inward force more as we get closer
	var inward_weight: float = spiral_in_strength / max(distance, 1.0)
	inward_weight = clamp(inward_weight, 0.05, 0.35)

	var tangent_weight: float = 1.0

	# Desired movement direction (spiral)
	var desired_dir: Vector2 = (
		tangent_dir * tangent_weight +
		radial_dir * inward_weight
	).normalized()

	var desired_velocity: Vector2 = desired_dir * entity.stats.move_speed

	# Encourage circular motion even if starting velocity is bad
	var tangent_velocity: Vector2 = tangent_dir * entity.stats.move_speed
	var orbit_lerp: float = clamp(orbit_turn_strength * delta * 0.05, 0.0, 0.35)
	desired_velocity = desired_velocity.lerp(tangent_velocity, orbit_lerp)

	# Smooth steering
	var steer_amount: float = clamp(steering * delta, 0.0, 1.0)
	entity.velocity = entity.velocity.lerp(desired_velocity, steer_amount)

	entity.move_and_slide()
