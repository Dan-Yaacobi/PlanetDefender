class_name ShootPlayerState extends PlayerState

@onready var move: MovePlayerState = $"../Move"
@onready var after_shoot_timer: Timer = $AfterShootTimer

var air_borne: bool = false
var direction: Vector2
@export var shoot_speed: float = 1200.0
# store a refernece to the player this belongs to
func init() -> void:
	pass

func _ready() -> void:
	after_shoot_timer.timeout.connect(in_the_air)
	pass

#what happens when the player enters this state
func Enter() -> void:
	player.combo.reset_combo_hit()
	air_borne = false
	player.toggle_hit(true)
	after_shoot_timer.start()
	direction = player.shoot_direction()
	player.rotation = direction.angle() + PI*0.5
	pass

#what happens when the player exits this state
func Exit() -> void:
	player.rotation = Vector2.ZERO.angle()
	player.combo.check_combo()
	pass
	
#what happens during process update in this state
func Process(_delta: float) -> PlayerState:
	if player.reached_circle() and air_borne:
		return move
	return null
	
#what happens during _physics_process update in this state
func Physics(_delta: float) -> PlayerState:
	player.velocity = direction * shoot_speed
	player.move_and_slide()
	return null
	
#what happens during input events in this state
func HandleInput(_event: InputEvent) -> PlayerState:
	return null
	
func in_the_air() -> void:
	air_borne = true

func collide(delta) -> void:
	var collision = player.move_and_collide(player.velocity * delta)
	if collision:
		var normal = collision.get_normal()
		player.velocity = player.velocity.bounce(normal) # reflect like light
		var interactable = collision.get_collider()
