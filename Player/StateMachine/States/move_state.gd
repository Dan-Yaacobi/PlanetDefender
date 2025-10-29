class_name MovePlayerState extends PlayerState

@onready var shoot: ShootPlayerState = $"../Shoot"

# --- Constraint tuning (radial) ---
@export var radial_correction_gain: float = 30.0      # pulls back to radius (velocity-bias)
@export var radial_damping_gain: float = 10.0         # damps radial oscillation

@export var regular_radial_correction_gain: float = 30.0
@export var faster_radial_correction_gain: float = 60.0

var direction: Vector2

func init() -> void:
	pass
	
func _ready() -> void:
	pass

#what happens when the player enters this state
func Enter() -> void:
	player.slow_down()
	player.toggle_hit(false)
	pass
	
#what happens when the player exits this state
func Exit() -> void:
	pass
	
#what happens during process update in this state
func Process(_delta: float) -> PlayerState:
	return null
	
#what happens during _physics_process update in this state
func Physics(_delta: float) -> PlayerState:
	moving_across_circle(_delta)
	player.move_and_slide()
	direction = player.shoot_direction()
	player.rotation = direction.angle()
	return null
	
#what happens during input events in this state
func HandleInput(_event: InputEvent) -> PlayerState:
	if _event.is_action_pressed("Click"):
		player.speed_up()
	if _event.is_action_released("Click"):
		return shoot
	return null
	
func moving_across_circle(delta: float) -> void:
	var to_center: Vector2 = player.global_position - player.circle_center
	var distance: float = to_center.length()
	if distance < 0.0001:
		# Prevent division by zero if you spawn exactly at center
		return

	var normal_dir: Vector2 = to_center / distance              # radial outwards
	var tangent_dir: Vector2 = Vector2(-normal_dir.y, normal_dir.x) # CCW tangent

	# ---- Tangential control (accel to a target speed) ----
	#var current_tangential_speed: float = velocity.dot(tangent_dir)
	var target_tangential_speed: float = player.direction * player.current_speed

	# Accelerate toward target (clamped per step)
	#var step_tan_delta: float = clamp(
		#target_tangential_speed - current_tangential_speed,
		#- tangential_acceleration * delta,
		#+ tangential_acceleration * delta
	#)
	player.velocity = target_tangential_speed * tangent_dir# tangent_dir * step_tan_delta

	# ---- Circular constraint (pure physics; never set position) ----
	# 1) Remove any radial velocity component so we don't drift off the rim
	var radial_speed: float = player.velocity.dot(normal_dir)
	player.velocity -= normal_dir * radial_speed

	# 2) Add velocity bias to correct radius error smoothly (Baumgarte-like)
	var radius_error: float = distance - player.circle_radius            # + if outside, - if inside
	player.velocity -= normal_dir * (radius_error * radial_correction_gain * delta)

	# 3) Dampen radial speed to avoid oscillations
	player.velocity -= normal_dir * (radial_speed * radial_damping_gain * delta)
