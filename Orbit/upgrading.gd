class_name UpgradingPlanetState extends OrbitState

func init() -> void:
	pass
	
func _ready() -> void:
	pass

#what happens when the player enters this state
func Enter() -> void:
	pass
	
#what happens when the player exits this state
func Exit() -> void:
	pass
	
#what happens during process update in this state
func Process(_delta: float) -> OrbitState:
	return null
	
#what happens during _physics_process update in this state
func Physics(_delta: float) -> OrbitState:
	return null
	
#what happens during input events in this state
func HandleInput(_event: InputEvent) -> OrbitState:
	return null
	
	
