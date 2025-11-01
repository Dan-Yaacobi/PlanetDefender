class_name Interactable extends Area2D


func player_interact(player: Player) -> void:
	if player:
		print("interacted with player: ", player)
	pass
	
func planet_interact() -> void:
	pass
