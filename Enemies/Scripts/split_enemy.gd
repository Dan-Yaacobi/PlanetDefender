class_name SplitEnemy extends Enemy

@export var split_levels: int = 1
@export var total_splits: int = 2

var taken_damage: bool = false

signal destroyed
	
func activate_split() -> bool:
	if split_levels > 0:
		split_levels -= 1
		return true
	return false

func _take_damage(_hurt_box: HurtBox) -> void:
	var effect: DestroyedEffect = ENEMY_DESTROYED_EFFECT.instantiate()
	get_tree().root.add_child(effect)
	effect.play_explosion_effect(global_position)
	destroyed.emit()
	pass

func activate() -> void:
	hit_box.monitoring = true
	hit_box.monitorable = true
	pass
