class_name PlayerHurtBox extends HurtBox

signal enemy_hit

func AreaEnetered( a : Area2D) -> void:
	if a is HitBox:
		a.TakeDamage(self)
		if a.get_parent() is Enemy:
			enemy_hit.emit()
	pass
