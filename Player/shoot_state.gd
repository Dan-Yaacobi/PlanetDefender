class_name ShootPlayerState extends PlayerState
@onready var move: MovePlayerState = $"../Move"
@onready var after_shoot_timer: Timer = $AfterShootTimer

var air_borne: bool = false
# store a refernece to the player this belongs to
func init() -> void:
	pass
	
func _ready() -> void:
	after_shoot_timer.timeout.connect(in_the_air)
	pass

#what happens when the player enters this state
func Enter() -> void:
	air_borne = false
	player.shoot()
	after_shoot_timer.start()
	pass
	
#what happens when the player exits this state
func Exit() -> void:
	pass
	
#what happens during process update in this state
func Process(_delta: float) -> PlayerState:
	if player.reached_circle() and air_borne:
		return move
	#return move
	return null
	
#what happens during _physics_process update in this state
func Physics(_delta: float) -> PlayerState:
	return null
	
#what happens during input events in this state
func HandleInput(_event: InputEvent) -> PlayerState:
	return null
	
func in_the_air() -> void:
	air_borne = true
