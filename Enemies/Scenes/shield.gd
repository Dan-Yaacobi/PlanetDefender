class_name Shield extends StaticBody2D

@onready var shield_enemy: Enemy = $".."

var angle: float = 0.0
var angular_speed: float = 1.0
var radius: float = 35.0

func _ready() -> void:
	angle = randf_range(0,TAU)
	pass
	
func _physics_process(delta: float) -> void:
	rotating(delta)
	
func rotating(delta) -> void:
	angle += (angular_speed ) * delta
	angle = fmod(angle, TAU)
	global_position = shield_enemy.global_position +  Vector2(cos(angle), sin(angle)) * radius
	rotation = angle
