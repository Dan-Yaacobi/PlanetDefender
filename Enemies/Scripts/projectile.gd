class_name Projectile extends Node2D

@onready var hurt_box: HurtBox = $HurtBox
@onready var hit_box: HitBox = $HitBox

@export var speed: float = 20

var direction: Vector2

func _ready() -> void:
	hit_box.Damaged.connect(_destroyed)
	hurt_box.dealt_damage.connect(_dealt_damage)

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta
	rotation = direction.angle() + PI/2

func _dealt_damage() -> void:
	queue_free()

func _destroyed(_hurt_box: HurtBox) -> void:
	queue_free()
