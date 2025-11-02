class_name MovePlayerState extends PlayerState

@onready var shoot: ShootPlayerState = $"../Shoot"
#@onready var fuel_bar: FuelBar = $"../../FuelBar"
@onready var accelerate_timer: Timer = $AccelerateTimer

var direction: Vector2
var mouse_button_held: bool = false
var go_to_shoot: bool = false

func init() -> void:
	accelerate_timer.timeout.connect(accelerate_over)
	pass
	
func _ready() -> void:
	pass

#what happens when the player enters this state	
func Enter() -> void:
	go_to_shoot = false
	mouse_button_held = Input.is_action_pressed("Click")
	player.slow_down()
	player.toggle_hit(false)
	pass
	
#what happens when the player exits this state
func Exit() -> void:
	player.angle += PI
	pass
	
#what happens during process update in this state
func Process(_delta: float) -> PlayerState:
	#if not fuel_bar.has_enough_fuel():
		#if Input.is_action_pressed("Click"):
			#fuel_bar.stop_engine()
			#player.slow_down()
	if mouse_button_held:
		if Input.is_action_just_released("Click"):
			mouse_button_held = false
	return null

#what happens during _physics_process update in this state
func Physics(_delta: float) -> PlayerState:
	direction = player.shoot_direction()
	player.rotation = direction.angle()
	moving_across_circle(_delta)
	if go_to_shoot:
		return shoot
	return null
	
#what happens during input events in this state
func HandleInput(_event: InputEvent) -> PlayerState:
	if _event.is_action_pressed("Click"):
		player.speed_up()
		player.toggle_hit(true)
		accelerate_timer.start()
		
	if _event.is_action_released("Click") and not mouse_button_held:
		accelerate_timer.stop()
		return shoot
	return null

func moving_across_circle(delta: float) -> void:
	var radius: float = player.circle_radius
	var center: Vector2 = player.circle_center
	
	player.angle += (player.get_move_speed()) * delta
	player.angle = fmod(player.angle, TAU)
	player.global_position = center + Vector2(cos(player.angle), sin(player.angle)) * radius

func accelerate_over() -> void:
	go_to_shoot = true
#func __moving_across_circle(delta: float) -> void:
	## Vector from planet center to player
	#var vector_to_center: Vector2 = player.global_position - player.circle_center
	#var current_radius: float = vector_to_center.length()
	#if current_radius < 1e-6:
		## At the exact center there's no well-defined tangent
		#return
#
	## Unit vectors: radial (outwards) and tangential (along orbit)
	#var radial_direction: Vector2 = vector_to_center / current_radius
	#var tangent_direction: Vector2 = Vector2(-radial_direction.y, radial_direction.x)  # CCW tangent
#
	## Desired tangential (orbital) speed based on player input and acceleration
	#var tangential_speed: float = player.current_speed * player.direction
#
	## How far from the perfect orbit radius we are this frame
	#var radius_error: float = player.circle_radius - current_radius
#
	## Radial velocity needed to correct that error in one timestep
	#var correction_strength: float = 1.0  # 1.0 = full correction this frame
	#var radial_velocity: float = (radius_error * correction_strength) / max(delta, 1e-6)
#
	## Final velocity: tangent motion + small radial correction
	#player.velocity = tangent_direction * tangential_speed + radial_direction * radial_velocity
#
##
#func _moving_across_circle(delta: float) -> void:
	#var to_center: Vector2 = player.global_position - player.circle_center
	#var distance: float = to_center.length()
	#if distance < 0.0001:
		## Prevent division by zero if you spawn exactly at center
		#return
#
	#var normal_dir: Vector2 = to_center / distance              # radial outwards
	#var tangent_dir: Vector2 = Vector2(-normal_dir.y, normal_dir.x) # CCW tangent
#
	## ---- Tangential control (accel to a target speed) ----
	##var current_tangential_speed: float = velocity.dot(tangent_dir)
	#var target_tangential_speed: float = player.direction * player.current_speed
#
	## Accelerate toward target (clamped per step)
	##var step_tan_delta: float = clamp(
		##target_tangential_speed - current_tangential_speed,
		##- tangential_acceleration * delta,
		##+ tangential_acceleration * delta
	##)
	#player.velocity = target_tangential_speed * tangent_dir# tangent_dir * step_tan_delta
#
	## ---- Circular constraint (pure physics; never set position) ----
	## 1) Remove any radial velocity component so we don't drift off the rim
	#var radial_speed: float = player.velocity.dot(normal_dir)
	#player.velocity -= normal_dir * radial_speed
#
	## 2) Add velocity bias to correct radius error smoothly (Baumgarte-like)
	#var radius_error: float = distance - player.circle_radius            # + if outside, - if inside
	#player.velocity -= normal_dir * (radius_error * radial_correction_gain * delta)
#
	## 3) Dampen radial speed to avoid oscillations
	#player.velocity -= normal_dir * (radial_speed * radial_damping_gain * delta)
