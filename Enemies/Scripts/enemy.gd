class_name Enemy extends CharacterBody2D

@export var stats: EnemyStats
@onready var enemy_state_machine: EnemyStateMachine = $EnemyStatsMachine

var target: Vector2

func _ready() -> void:
	enemy_state_machine.Initialize(self)
	
func set_target(_target: Vector2) -> void:
	target = _target

func get_speed() -> float:
	return stats.move_speed
