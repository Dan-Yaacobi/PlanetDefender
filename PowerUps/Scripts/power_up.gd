class_name PowerUp extends Node2D

@export var effect: PowerUpEffect

func acquire_effect() -> void:
	pass

func activate_effect() -> void:
	if effect:
		effect.effect_functionality()
