class_name DestroyedEffect extends Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func play_explosion_effect(_position: Vector2) -> void:
	global_position = _position
	animation_player.play("Explosion")
	await animation_player.animation_finished
	queue_free()
