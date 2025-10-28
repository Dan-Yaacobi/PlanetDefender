class_name SplitEnemyDestroyedState extends EnemyState

const SPLIT_ENEMY = preload("uid://dp4a2g31k81ja")

@export var spawn_radius: float = 50.0
func init() -> void:
	pass
	
func _ready() -> void:
	pass

#what happens when the player enters this state
func Enter() -> void:
	if enemy.activate_split():
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
	var total_splits: Array[SplitEnemy] = []
	for i in enemy.total_splits:
		var new_enemy: SplitEnemy = SPLIT_ENEMY.instantiate()
		var random_offset: float = randf_range(0,TAU/2)
		new_enemy.global_position = enemy.global_position + set_split_spawn_offset(i+1,enemy.total_splits,spawn_radius, random_offset)
		new_enemy.scale *= 0.7
		new_enemy.split_levels = enemy.split_levels
		total_splits.append(new_enemy)
	for _enemy in total_splits:
		get_tree().root.call_deferred("add_child", _enemy)
	pass
	
func set_split(_split: SplitEnemy) -> SplitEnemy:
	return null

func set_split_spawn_offset(_index: int, _total: int, _spawn_radius: float, _random_offset: float) -> Vector2:
	var offset: Vector2
	var angle: float = TAU/ _total * (_index) + _random_offset
	offset = Vector2(cos(angle), sin(angle)) * spawn_radius
	return offset
	
	
func destroyed() -> void:
	enemy.queue_free()
	pass
