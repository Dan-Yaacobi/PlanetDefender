class_name Enemy extends CharacterBody2D

@export var stats: EnemyStats

@onready var hit_box: Area2D = $HitBox
@onready var enemy_hurt_box: EnemyHurtBox = $EnemyHurtBox
@onready var enemy_state_machine: EnemyStateMachine = $EnemyStateMachine

var target: Vector2

func _ready() -> void:
	enemy_state_machine.Initialize(self)
	hit_box.Damaged.connect(_take_damage)
	enemy_hurt_box.hit_planet.connect(_dealt_damage)

func set_target(_target: Vector2) -> void:
	target = _target

func get_speed() -> float:
	return stats.move_speed * randf_range(0.5,2)

func _take_damage(_hurt_box: HurtBox) -> void:
	queue_free()
	pass
	
func _dealt_damage() -> void:
	queue_free()
	
func calc_direction() -> Vector2:
	return (target - global_position).normalized()
