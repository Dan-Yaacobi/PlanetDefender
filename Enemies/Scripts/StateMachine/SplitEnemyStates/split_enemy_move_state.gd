class_name SplitEnemyMoveState extends EnemyState

func init() -> void:
	pass
	
func _ready() -> void:
	pass

#what happens when the player enters this state
func Enter() -> void:
	pass
	
#what happens when the player exits this state
func Exit() -> void:
	pass
	
#what happens during process update in this state
func Process(_delta: float) -> EnemyState:
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
