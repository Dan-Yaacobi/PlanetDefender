class_name PlayerHurtBox extends HurtBox

signal hit(entity: Node2D)

func AreaEnetered( a : Area2D) -> void:
	if a is HitBox:
		a.TakeDamage(self)
		if a.entity is Enemy:
			hit.emit(a.entity)
			
