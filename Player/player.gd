class_name Player extends CharacterBody2D

@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine
@onready var camera: Camera = $"../Camera2D"
@onready var rail: Orbit = $".."
@onready var player_hurt_box: PlayerHurtBox = $PlayerHurtBox
@onready var combo: Combo = $Combo

@export var circle_center: Vector2 = Vector2.ZERO
@export var circle_radius: float = 350.0
@export var regular_speed: float = 1.0
@export var faster_speed: float = 2.0
@export var shoot_speed: float = 1000

var angle: float = 0.0
var direction: int = 1
var current_speed: float

var start_time
var elapsed

func _ready():
	circle_radius = rail.radius
	current_speed = regular_speed
	player_state_machine.Initialize(self)
	_snap_to_circle()
	player_hurt_box.monitoring = false
	player_hurt_box.enemy_hit.connect(_on_enemy_hit)
	player_hurt_box.enemy_hit.connect(combo.add_combo)
	

func _physics_process(_delta: float) -> void:
	move_and_slide()
	
func _snap_to_circle() -> void:
	angle = (global_position - rail.global_position).angle()
	
func reached_circle() -> bool:
	return (global_position - circle_center).length() > rail.radius

func shoot_direction() -> Vector2:
	return (circle_center - global_position).normalized()
	
func speed_up() -> void:
	current_speed = faster_speed
	
func slow_down() -> void:
	current_speed = regular_speed
	
func toggle_hit(can_hit: bool) -> void:
	player_hurt_box.monitoring = can_hit

func _on_enemy_hit() -> void:
	camera.apply_shake()

func get_move_speed() -> float:
	var combo_speed_addition: float = combo.combo * (regular_speed/10)
	return current_speed + combo_speed_addition

func get_shoot_speed() -> float:
	return shoot_speed

func stop_speed() -> void:
	current_speed = 0
