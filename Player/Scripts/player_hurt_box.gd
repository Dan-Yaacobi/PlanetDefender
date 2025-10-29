class_name PlayerHurtBox extends HurtBox

signal enemy_hit

func AreaEnetered( a : Area2D) -> void:
	if a is HitBox:
		a.TakeDamage(self)
		enemy_hit.emit()
	pass
