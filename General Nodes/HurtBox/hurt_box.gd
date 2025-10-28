class_name HurtBox extends Area2D

@export var damage: int  = 1

signal dealt_damage

func _ready() -> void:
	area_entered.connect(AreaEnetered)
	pass

func AreaEnetered( a : Area2D) -> void:
	if a is HitBox:
		a.TakeDamage(self)
		dealt_damage.emit()
	pass
