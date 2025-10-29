class_name Planet extends Area2D

@onready var hit_box: HitBox = $HitBox
@onready var hp_bar: HpBar = $HpBar

@export var stats: PlanetStats

var float_amplitude: float = 5.0    # how high/low it moves
var float_speed: float = 2.0        # how fast it moves
var base_y: float                   # starting y position
var time_passed: float = 0.0

func _ready() -> void:
	stats.current_hp = stats.max_hp
	hp_bar.set_hp(stats.max_hp)
	hit_box.Damaged.connect(_take_damage)
	base_y = global_position.y
	pass

func _take_damage(_hurt_box: HurtBox) -> void:
	if _hurt_box:
		stats.current_hp -= _hurt_box.damage
		hp_bar.take_hit(_hurt_box.damage)
		if stats.current_hp <= 0:
			print("dead")

func _process(_delta: float) -> void:
	floating(_delta)
	
func floating(_delta: float) -> void:
	time_passed += _delta * float_speed
	global_position.y = base_y + sin(time_passed) * float_amplitude
