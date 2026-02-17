extends Node

const PLAYER = preload("uid://cxrg875qjpt1q")
var player: Player

func _ready() -> void:
	player = PLAYER.instantiate()
