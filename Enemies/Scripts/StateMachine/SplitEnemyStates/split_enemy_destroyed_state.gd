class_name SplitEnemyDestroyedState extends EnemyState

const SPLIT_ENEMY = preload("uid://dp4a2g31k81ja")

func init() -> void:
	pass
	
func _ready() -> void:
	pass

#what happens when the player enters this state
func Enter() -> void:
	if enemy.activate_splits():
		summon_splits()
	destroyed()
	pass
	
#what happens when the player exits this state
func Exit() -> void:
	pass
	
#what happens during process update in this state
func Process(_delta: float) -> EnemyState:
	return null
	
#what happens during _physics_process update in this state
func Physics(_delta: float) -> EnemyState:
	return null
	
#what happens during input events in this state
func HandleInput(_event: InputEvent) -> EnemyState:
	return null
	
func summon_splits() -> void:
	var total_splits = Array[SplitEnemy]
	for i in enemy.total_splits:
		pass
	pass
	
func set_split(_split: SplitEnemy) -> SplitEnemy:
	return null

	
func destroyed() -> void:
	enemy.queue_free()
	pass
