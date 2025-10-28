class_name Planet extends Area2D

@onready var hit_box: HitBox = $HitBox
@onready var hp_bar: HpBar = $HpBar

@export var stats: PlanetStats

func _ready() -> void:
	stats.current_hp = stats.max_hp
	hp_bar.set_hp(stats.max_hp)
	hit_box.Damaged.connect(_take_damage)
	pass

func _take_damage(_hurt_box: HurtBox) -> void:
	if _hurt_box:
		stats.current_hp -= _hurt_box.damage
		hp_bar.take_hit(_hurt_box.damage)
		if stats.current_hp <= 0:
			print("dead")
