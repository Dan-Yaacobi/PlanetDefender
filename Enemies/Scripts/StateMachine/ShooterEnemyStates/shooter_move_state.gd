class_name ShooterMoveState extends EnemyState

@onready var pre_shoot: ShooterPreShootState = $"../PreShoot"

@export var distance_to_attack: float = 250

func init() -> void:
	pass
	
func _ready() -> void:
	pass

#what happens when the player enters this state
func Enter() -> void:
	distance_to_attack -= 10
	pass
	
#what happens when the player exits this state
func Exit() -> void:
	pass
	
#what happens during process update in this state
func Process(_delta: float) -> EnemyState:
	return null
	
#what happens during _physics_process update in this state
func Physics(_delta: float) -> EnemyState:
	var curr_direction = enemy.calc_direction()
	enemy.velocity += curr_direction * enemy.get_speed() * _delta
	enemy.move_and_slide()
	enemy.rotation = curr_direction.angle() + PI/2
	if calc_distance() <= distance_to_attack:
		return pre_shoot
	return null
	
#what happens during input events in this state
func HandleInput(_event: InputEvent) -> EnemyState:
	return null

func calc_distance() -> float:
	return (enemy.target - enemy.global_position).length()
