class_name PowerUp extends Resource

@export var texture: Texture
@export var target: Enums.targets
@export var ability: PackedScene
@export var title: String
@export var description: String

func apply_power_up() -> void:
	var power_up: Ability = ability.instantiate()
	var new_father
	
	if target == Enums.targets.PLANET:
		new_father = EventBus.current_planet
	elif target == Enums.targets.PLAYER:
		new_father = PlayerManager.player
		
	new_father.call_deferred("add_child", power_up)
		
