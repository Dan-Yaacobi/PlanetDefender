class_name SplitEnemyMoveState extends EnemyState

@onready var destroyed_state: SplitEnemyDestroyedState = $"../Destroyed"

var destroyed: bool = false

func init() -> void:
	enemy.destroyed.connect(_destroyed)
	pass
	
func _ready() -> void:
	pass

#what happens when the player enters this state
func Enter() -> void:
	destroyed = false
	pass
	
#what happens when the player exits this state
func Exit() -> void:
	pass
	
#what happens during process update in this state
func Process(_delta: float) -> EnemyState:
	if destroyed:
		return destroyed_state
	return null
	
func Physics(_delta: float) -> EnemyState:
	var curr_direction = calc_direction()
	enemy.velocity = curr_direction * enemy.get_speed()
	enemy.move_and_slide()
	enemy.rotation = curr_direction.angle() + PI/2
	return null
	
#what happens during input events in this state
func HandleInput(_event: InputEvent) -> EnemyState:
	return null
	
func calc_direction() -> Vector2:
	return (enemy.target - enemy.global_position).normalized()

func _destroyed() -> void:
	destroyed = true
