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
@export var tangential_acceleration: float = 2200.0   # px/s^2 toward target speed

@onready var rail: Orbit = $".."
@onready var player_hurt_box: PlayerHurtBox = $PlayerHurtBox

@onready var combo: Combo = $Combo

var last_r
var angle: float = 0.0
var direction: int = 1

func _ready():
	current_speed = regular_speed
	player_state_machine.Initialize(self)
	last_r = rail.radius
	if rail.has_signal("radius_changed"):
		rail.radius_changed.connect(_on_radius_changed)
	_snap_to_circle()
	player_hurt_box.monitoring = false
	player_hurt_box.enemy_hit.connect(_on_enemy_hit)
	player_hurt_box.enemy_hit.connect(combo.add_combo)
	
func _on_radius_changed(new_r: float) -> void:
	last_r = new_r
	_snap_to_circle()

func _snap_to_circle() -> void:
	var dir := Vector2(cos(angle), sin(angle))
	global_position = rail.global_position + dir * rail.radius

func reached_circle() -> bool:
	return (global_position - circle_center).length() > rail.radius

func shoot_direction() -> Vector2:
	return (circle_center - global_position).normalized()
	
func speed_up() -> void:
	current_speed = faster_speed
	#radial_correction_gain = faster_radial_correction_gain
	
func slow_down() -> void:
	current_speed = regular_speed
	#radial_correction_gain = regular_radial_correction_gain

func toggle_hit(can_hit: bool) -> void:
	player_hurt_box.monitoring = can_hit

func _on_enemy_hit() -> void:
	camera.apply_shake()
