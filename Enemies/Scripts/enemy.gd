class_name Enemy extends CharacterBody2D

@export var stats: EnemyStats

const ENEMY_DESTROYED_EFFECT = preload("uid://cnfe726dlvbsw")

@onready var hit_box: Area2D = $HitBox
@onready var enemy_hurt_box: EnemyHurtBox = $EnemyHurtBox
@onready var enemy_state_machine: EnemyStateMachine = $EnemyStateMachine

var target: Vector2

func _ready() -> void:
	enemy_state_machine.Initialize(self)
	enemy_hurt_box.hit_planet.connect(_dealt_damage)
	_extra_ready_functionality()
	await get_tree().create_timer(1).timeout
	
	hit_box.Damaged.connect(_take_damage)

	
func set_target(_target: Vector2) -> void:
	target = _target

func get_speed() -> float:
	return stats.move_speed * randf_range(0.5,2)

func _take_damage(_hurt_box: HurtBox) -> void:
	var effect: DestroyedEffect = ENEMY_DESTROYED_EFFECT.instantiate()
	get_tree().root.add_child(effect)
	effect.play_explosion_effect(global_position)
	queue_free()
	pass
	
func _dealt_damage() -> void:
	queue_free()
	
func calc_direction() -> Vector2:
	return (target - global_position).normalized()
	
func activate() -> void:
	pass

func deactivate() -> void:
	pass

func _extra_ready_functionality() -> void:
	pass
