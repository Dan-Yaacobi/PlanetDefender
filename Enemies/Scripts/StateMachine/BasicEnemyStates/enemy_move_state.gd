class_name EnemyMoveState extends EnemyState

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
	
#what happens during _physics_process update in this state
func Physics(_delta: float) -> EnemyState:
	enemy.stats.movement.set_entity(enemy)
	enemy.stats.movement.apply_movement(_delta,enemy.target)
	enemy.move_and_slide()
	enemy.rotation = enemy.velocity.angle() + PI/2
	
	return null
	
#what happens during input events in this state
func HandleInput(_event: InputEvent) -> EnemyState:
	return null
	
func calc_direction() -> Vector2:
	return (enemy.target - enemy.global_position).normalized()
