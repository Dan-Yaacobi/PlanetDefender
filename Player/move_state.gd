class_name MovePlayerState extends PlayerState

@onready var speed_up: SpeedUpPlayerState = $"../SpeedUp"
@onready var shoot: ShootPlayerState = $"../Shoot"
@onready var single_click_timer: Timer = $SingleClickTimer

@export var double_click_time: float = 0.2
var go_to_speed_up: bool = false
var go_to_shooting: bool = false
var last_click_time: float = -1

# store a refernece to the player this belongs to
func init() -> void:
	single_click_timer.timeout.connect(resolve_single_click)
	single_click_timer.wait_time = double_click_time
	pass
	
func _ready() -> void:
	pass

#what happens when the player enters this state
func Enter() -> void:
	player.slow_down()
	single_click_timer.wait_time = double_click_time
	go_to_speed_up = false
	go_to_shooting = false
	pass
	
#what happens when the player exits this state
func Exit() -> void:
	pass
	
#what happens during process update in this state
func Process(_delta: float) -> PlayerState:
	return null
	
#what happens during _physics_process update in this state
func Physics(_delta: float) -> PlayerState:
	if go_to_speed_up:
		return speed_up
	if go_to_shooting:
		return shoot
	return null
	
#what happens during input events in this state
func HandleInput(_event: InputEvent) -> PlayerState:
	if _event.is_action_released("Click"):
		return shoot
	if _event.is_action_pressed("Click"):
		var now := Time.get_ticks_msec() / 1000.0
		if last_click_time >= 0 and (now - last_click_time) <= double_click_time:
			single_click_timer.stop()
			_on_double_click()
			last_click_time = -1
		else:
			single_click_timer.start()
			last_click_time = now

	return null

func shooting() -> void:
	go_to_shooting = true

func resolve_single_click() -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		go_to_speed_up = true
	else:
		go_to_shooting = true
func speeding_up() -> void:
	go_to_speed_up = true

func _on_double_click() -> void:
	player.direction *= -1
