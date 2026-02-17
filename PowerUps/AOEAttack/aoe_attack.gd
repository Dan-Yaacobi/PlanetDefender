class_name AoeAttack extends Ability

@onready var attack_effect: CPUParticles2D = $AttackEffect
@onready var player_hurt_box: PlayerHurtBox = $PlayerHurtBox

func _ready() -> void:
	attack_effect.emitting = true
	player_hurt_box.monitoring = true
	attack_effect.finished.connect(queue_free)
	
