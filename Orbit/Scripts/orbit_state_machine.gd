class_name OrbitStateMachine extends Node2D

var states: Array [ OrbitState ]
var prev_state: OrbitState
var curr_state: OrbitState

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ChangeState(curr_state.Process(delta))


func _physics_process(delta: float) -> void:
	ChangeState(curr_state.Physics(delta))
	
	
func _unhandled_input(event: InputEvent) -> void:
	ChangeState(curr_state.HandleInput(event))


func Initialize(_orbit: Orbit)->void:
	states = []
	for c in get_children():
		if c is PlayerState:
			states.append(c)
			
	if states.size() == 0:
		return
		
	states[0].orbit = _orbit
	states[0].state_machine = self
	
	for state in states:
		state.init()
		
	ChangeState(states[0])
	process_mode = Node.PROCESS_MODE_INHERIT 
	# because this is an attribute of the Player(Player is the main scene) 
	# then INHERIT means it is enabled as long as Player is
	
		
func ChangeState(new_state: OrbitState) -> void:
	if new_state == null or new_state == curr_state:
		return
	if curr_state:
		curr_state.Exit()
	prev_state = curr_state
	curr_state = new_state
	curr_state.Enter()
