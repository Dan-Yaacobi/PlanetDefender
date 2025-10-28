class_name SplitEnemy extends Enemy

@export var split_levels: int = 1
@export var total_splits: int = 2

signal destroyed

func activate_split() -> bool:
	if split_levels > 0:
		split_levels -= 1
		return true
	return false

func _take_damage(_hurt_box: HurtBox) -> void:
	destroyed.emit()
	pass

func activate() -> void:
	enemy_hurt_box.monitoring = true
	enemy_hurt_box.monitorable = true
	pass
	
func deactivate() -> void:
	enemy_hurt_box.monitoring = false
	enemy_hurt_box.monitorable = false
	pass
