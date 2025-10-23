class_name Player extends CharacterBody2D

@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine

# --- Circle definition ---
@export var circle_center: Vector2 = Vector2.ZERO
@export var circle_radius: float = 350.0

# --- Movement feel (tangential) ---
@export var current_speed: float
@export var regular_speed: float = 450.0       # px/s along the rim
@export var faster_speed: float = 900.0
@export var shoot_speed: float = 10
@export var tangential_acceleration: float = 2200.0   # px/s^2 toward target speed

# --- Constraint tuning (radial) ---
@export var radial_correction_gain: float = 30.0      # pulls back to radius (velocity-bias)
@export var regular_radial_correction_gain: float = 30.0
@export var faster_radial_correction_gain: float = 60.0
@export var radial_damping_gain: float = 10.0         # damps radial oscillation
@onready var rail: Orbit = $".."

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

#func enter_circle() -> void:
	#on_circle = true
	#var c := rail.global_position
	#var to_c := global_position - c
	#angle = atan2(to_c.y, to_c.x)
	#var dir := Vector2(cos(theta), sin(theta))
	#var tan := Vector2(-dir.y, dir.x)
	#speed_tan = velocity.dot(tan)     # project current velocity (no fake launch)
	#global_position = c + dir * rail.radius
	
func _physics_process(delta: float) -> void:
	move_and_slide()

func moving_across_circle(delta: float) -> void:
	var to_center: Vector2 = global_position - circle_center
	var distance: float = to_center.length()
	if distance < 0.0001:
		# Prevent division by zero if you spawn exactly at center
		return

	var normal_dir: Vector2 = to_center / distance              # radial outwards
	var tangent_dir: Vector2 = Vector2(-normal_dir.y, normal_dir.x) # CCW tangent

	# ---- Tangential control (accel to a target speed) ----
	#var current_tangential_speed: float = velocity.dot(tangent_dir)
	var target_tangential_speed: float = direction * current_speed

	# Accelerate toward target (clamped per step)
	#var step_tan_delta: float = clamp(
		#target_tangential_speed - current_tangential_speed,
		#- tangential_acceleration * delta,
		#+ tangential_acceleration * delta
	#)
	velocity = target_tangential_speed * tangent_dir# tangent_dir * step_tan_delta

	# ---- Circular constraint (pure physics; never set position) ----
	# 1) Remove any radial velocity component so we don't drift off the rim
	var radial_speed: float = velocity.dot(normal_dir)
	velocity -= normal_dir * radial_speed

	# 2) Add velocity bias to correct radius error smoothly (Baumgarte-like)
	var radius_error: float = distance - circle_radius            # + if outside, - if inside
	velocity -= normal_dir * (radius_error * radial_correction_gain * delta)

	# 3) Dampen radial speed to avoid oscillations
	velocity -= normal_dir * (radial_speed * radial_damping_gain * delta)

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
	
func shoot() -> void:
	velocity = (circle_center - global_position).normalized() * faster_speed
	
func speed_up() -> void:
	current_speed = faster_speed
	radial_correction_gain = faster_radial_correction_gain
	
func slow_down() -> void:
	current_speed = regular_speed
	radial_correction_gain = regular_radial_correction_gain
