class_name ChangeDirectionPlayerState extends PlayerState
@onready var move: MovePlayerState = $"../Move"

# store a refernece to the player this belongs to
func init() -> void:
	pass
	
func _ready() -> void:
	pass

#what happens when the player enters this state
func Enter() -> void:
	player.direction *= -1
	pass
	
#what happens when the player exits this state
func Exit() -> void:
	pass
	
#what happens during process update in this state
func Process(_delta: float) -> PlayerState:
	return move
	
#what happens during _physics_process update in this state
func Physics(_delta: float) -> PlayerState:
	return null
	
#what happens during input events in this state
func HandleInput(_event: InputEvent) -> PlayerState:
	return null
