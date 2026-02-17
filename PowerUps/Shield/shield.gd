class_name Shield extends Ability

@onready var hit_box: HitBox = $HitBox
@onready var collision_shape: CollisionShape2D = $HitBox/CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D

@export var total_hits: int = 2

var hits_left: int

func _ready() -> void:
	hits_left = total_hits
	hit_box.Damaged.connect(take_hit)
	collision_shape.shape = EventBus.current_planet.get_collision_shape()
	collision_shape.apply_scale(Vector2(1.3,1.3))
	sprite.scale *= collision_shape.shape.get_rect().size / sprite.texture.get_size()

	
func take_hit(_hurt_box: HurtBox) -> void:
	hits_left -= 1
	if hits_left <= 0:
		queue_free()
