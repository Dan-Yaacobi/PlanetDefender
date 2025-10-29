class_name Orbit extends Node2D

@export var radius: float = 350.0
@onready var enemy_spawner: EnemySpawner = $EnemySpawner

signal radius_changed(r: float)

func _ready() -> void:
	enemy_spawner.set_orbit(self)

func _draw() -> void:
	draw_arc(Vector2.ZERO, radius, 0.0, TAU, 192, Color.WHITE, 2.0, true)

	var segs: int = 192
	for i in range(4): # fewer layers also helps keep it tight
		var w := 12.0 + i * 4.0   # thinner base + smaller increments
		var a := 0.22 * pow(0.6, i)
		draw_arc(Vector2.ZERO, radius, 0, TAU, segs, Color(0,1,0,a), w, true)
		
func set_radius(r: float):
	if !is_equal_approx(r, radius):
		radius = max(1.0, r)
		radius_changed.emit(radius)
		queue_redraw()

func tween_radius(to_r: float, dur := 1.0):
	var tw := create_tween()
	tw.tween_property(self, "radius", to_r, dur)\
	  .set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

func get_radius() -> float:
	return radius
	
func get_center() -> Vector2:
	return global_position
