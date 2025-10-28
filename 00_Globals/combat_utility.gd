extends Node

func hit_stop(duration_ms: float = 50, scale: float = 0.1) -> void:
	Engine.time_scale = scale
	await get_tree().create_timer(duration_ms / 1000.0, false, true).timeout
	Engine.time_scale = 1.0
