class_name Circle extends Node2D

@export var radius: float = 240.0

signal radius_changed(r: float)

func _draw() -> void:
	draw_arc(Vector2.ZERO, radius, 0.0, TAU, 192, Color.WHITE, 10.0, true)

func set_radius(r: float):
	if !is_equal_approx(r, radius):
		radius = max(1.0, r)
		radius_changed.emit(radius)
		queue_redraw()

func tween_radius(to_r: float, dur := 1.0):
	var tw := create_tween()
	tw.tween_property(self, "radius", to_r, dur)\
	  .set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
