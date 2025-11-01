class_name Player extends CharacterBody2D

@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine
@onready var camera: Camera = $"../Camera2D"

# --- Circle definition ---
@export var circle_center: Vector2 = Vector2.ZERO
@export var circle_radius: float = 350.0

# --- Movement feel (tangential) ---
@export var current_speed: float
@export var regular_speed: float = 450.0       # px/s along the rim
@export var faster_speed: float = 900.0

@onready var rail: Orbit = $".."
@onready var player_hurt_box: PlayerHurtBox = $PlayerHurtBox

@onready var combo: Combo = $Combo

var angle: float = 0.0
var direction: int = 1
var moving_at_regular_speed: bool = true

func _ready():
	circle_radius = rail.radius
	current_speed = regular_speed
	player_state_machine.Initialize(self)
	_snap_to_circle()
	player_hurt_box.monitoring = false
	player_hurt_box.enemy_hit.connect(_on_enemy_hit)
	player_hurt_box.enemy_hit.connect(combo.add_combo)

func _snap_to_circle() -> void:
	angle = (global_position - rail.global_position).angle()
	
func reached_circle() -> bool:
	return (global_position - circle_center).length() > rail.radius

func shoot_direction() -> Vector2:
	return (circle_center - global_position).normalized()
	
func speed_up() -> void:
	current_speed = faster_speed
	moving_at_regular_speed = false
	#radial_correction_gain = faster_radial_correction_gain
	
func slow_down() -> void:
	current_speed = regular_speed
	moving_at_regular_speed = true
	#radial_correction_gain = regular_radial_correction_gain

func is_regular_speed() -> bool:
	return moving_at_regular_speed

func toggle_hit(can_hit: bool) -> void:
	player_hurt_box.monitoring = can_hit

func _on_enemy_hit() -> void:
	camera.apply_shake()
