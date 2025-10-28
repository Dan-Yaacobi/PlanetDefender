class_name ShooterShootState extends EnemyState

@onready var move: ShooterMoveState = $"../Move"
@onready var animation_player: AnimationPlayer = $"../../Sprite2D/AnimationPlayer"

@export var recoil_strength: float

const PROJECTILE = preload("uid://4v5gbgqerhuo")

var done_shooting: bool = false

func init() -> void:
	pass
	
func _ready() -> void:
	pass

#what happens when the player enters this state
func Enter() -> void:
	done_shooting = false
	enemy.velocity = Vector2.ZERO
	shoot()
	pass
	
#what happens when the player exits this state
func Exit() -> void:
	animation_player.play("RESET")
	pass
	
#what happens during process update in this state
func Process(_delta: float) -> EnemyState:
	if done_shooting:
		return move
	return null
	
#what happens during _physics_process update in this state
func Physics(_delta: float) -> EnemyState:
	return null
	
#what happens during input events in this state
func HandleInput(_event: InputEvent) -> EnemyState:
	return null
	
func calc_direction() -> Vector2:
	return (enemy.target - enemy.global_position).normalized()

func shoot() -> void:
	var new_projectile: Projectile = PROJECTILE.instantiate()
	new_projectile.direction = calc_direction()
	new_projectile.global_position = enemy.global_position
	get_tree().root.call_deferred("add_child" , new_projectile)
	recoil()
	done_shooting = true
	await get_tree().create_timer(0.2).timeout
	pass

func recoil() -> void:
	enemy.velocity = -enemy.calc_direction()*enemy.stats.move_speed * recoil_strength
