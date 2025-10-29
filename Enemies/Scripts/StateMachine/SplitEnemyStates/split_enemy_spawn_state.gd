class_name SplitEnemySpawnState extends EnemyState

@onready var move: SplitEnemyMoveState = $"../Move"

var initialalize: bool = false
func init() -> void:
	pass
	
func _ready() -> void:
	pass

#what happens when the player enters this state
func Enter() -> void:
	initialalize = false
	await get_tree().create_timer(1).timeout
	initialalize = true
	pass
	
#what happens when the player exits this state
func Exit() -> void:
	pass
	
#what happens during process update in this state
func Process(_delta: float) -> EnemyState:
	if initialalize:
		return move
	return null
	
#what happens during _physics_process update in this state
func Physics(_delta: float) -> EnemyState:
	return null
	
#what happens during input events in this state
func HandleInput(_event: InputEvent) -> EnemyState:
	return null
	
	
