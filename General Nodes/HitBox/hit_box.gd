class_name HitBox extends Area2D

signal Damaged( hurt_box: HurtBox )

var entity: Node2D

func TakeDamage(hurt_box: HurtBox) -> void:
	if monitorable:
		Damaged.emit(hurt_box)

func set_entity(_entity: Node2D) -> void:
	if _entity:
		entity = _entity
