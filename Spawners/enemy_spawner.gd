class_name EnemySpawner extends Node2D

@export var enemies: Array[PackedScene]
@export var time_to_spawn: float = 1.0

@onready var spawn_timer: Timer = $SpawnTimer

var current_orbit: Orbit

func _ready() -> void:
	_set_timer()

func _set_timer() -> void:
	spawn_timer.wait_time = time_to_spawn
	spawn_timer.timeout.connect(summon)
	spawn_timer.start()

func set_orbit(_orbit: Orbit) -> void:
	if _orbit:
		current_orbit = _orbit
	
func summon() -> void:
	if _can_summon():
		_spawn_enemy(_choose_enemy_to_spawn(),_get_spawn_point())

func _choose_enemy_to_spawn() -> Enemy:
	if enemies.size() > 0:
		return enemies.pick_random().instantiate()
	return null
	
func _can_summon() -> bool:
	return true

func _get_spawn_point() -> Vector2:
	var _position: Vector2
	var radius = current_orbit.get_radius()
	var spawn_radius = randf_range(radius*0.7, radius*2)
	var angle = randf_range(0,TAU)
	_position = Vector2(cos(angle),sin(angle)) * spawn_radius
	return _position
	
func _spawn_enemy(_enemy: Enemy, _position: Vector2) -> void:
	if _enemy:
		_enemy.set_target(current_orbit.get_center())
		_enemy.global_position = _position
		current_orbit.add_child(_enemy)
	
