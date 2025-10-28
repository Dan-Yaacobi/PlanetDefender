class_name SplitEnemy extends Enemy

@export var split_levels: int = 1
@export var total_splits: int = 2

func activate_split() -> bool:
	if split_levels > 0:
		split_levels -= 1
		return true
	return false
