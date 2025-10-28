class_name EnemyHurtBox extends HurtBox

signal hit_planet

func AreaEnetered( a : Area2D) -> void:
	if a is HitBox:
		a.TakeDamage(self)
		hit_planet.emit()
	pass
