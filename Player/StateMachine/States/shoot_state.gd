class_name ShootPlayerState extends PlayerState

@onready var move: MovePlayerState = $"../Move"

var direction: Vector2

# store a refernece to the player this belongs to
func init() -> void:
	pass

func _ready() -> void:
	pass

#what happens when the player enters this state
func Enter() -> void:
	player.combo.reset_combo_hit()
	player.toggle_hit(true)
	#after_shoot_timer.start()
	direction = player.shoot_direction()
	player.rotation = direction.angle() + PI*0.5
	pass

#what happens when the player exits this state
func Exit() -> void:
	player._snap_to_circle()
	player.rotation = Vector2.ZERO.angle()
	player.velocity = Vector2.ZERO
	player.combo.check_combo()
	EventBus.end_shoot_state.emit()
	pass
	
#what happens during process update in this state
func Process(_delta: float) -> PlayerState:
	return null
	
#what happens during _physics_process update in this state
func Physics(_delta: float) -> PlayerState:
	player.velocity = direction * player.get_shoot_speed()
	var collision = player.move_and_collide(player.velocity * _delta)
	if collision:
		collide(collision)

	if player.reached_circle():
		return move
	return null
	
#what happens during input events in this state
func HandleInput(_event: InputEvent) -> PlayerState:
	return null

func collide(_collision) -> void:
	var normal = _collision.get_normal()
	player.velocity = player.velocity.bounce(normal) # reflect like light
	var interactable: Interactable = _collision.get_collider()
	interactable.player_interact(player)
