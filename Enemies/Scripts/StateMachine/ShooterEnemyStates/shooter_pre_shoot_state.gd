class_name ShooterPreShootState extends EnemyState

@onready var shoot: ShooterShootState = $"../Shoot"
@export var distance_to_attack: float = 250
@onready var animation_player: AnimationPlayer = $"../../Sprite2D/AnimationPlayer"

var done_pre_shooting: bool = false
func init() -> void:
	animation_player.animation_finished.connect(go_to_shooting)
	pass
	
func _ready() -> void:
	pass

#what happens when the player enters this state
func Enter() -> void:
	done_pre_shooting = false
	animation_player.play("PreShoot")
	pass
	
#what happens when the player exits this state
func Exit() -> void:
	pass
	
#what happens during process update in this state
func Process(_delta: float) -> EnemyState:
	if done_pre_shooting:
		return shoot
	return null
	
#what happens during _physics_process update in this state
func Physics(_delta: float) -> EnemyState:
	return null
	
#what happens during input events in this state
func HandleInput(_event: InputEvent) -> EnemyState:
	return null
	
func go_to_shooting(_anim) -> void:
	done_pre_shooting = true
