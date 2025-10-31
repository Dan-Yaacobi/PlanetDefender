class_name FuelBar extends ProgressBar

@onready var cooldown_timer: Timer = $CooldownTimer

@export var fuel_use_factor: float = 1.0
@export var fuel_refill_factor: float = 0.5
@export var shoot_fuel_cost: float = 0.3

var using_fuel: bool = false
var on_cooldown: bool = false
var refilling_fuel: bool = true

func _ready() -> void:
	cooldown_timer.timeout.connect(_off_cooldown)
	refilling_fuel = true
	
func _process(_delta: float) -> void:
	if not on_cooldown:
		if refilling_fuel:
			_refill(_delta)
		if using_fuel:
			_use_fuel(_delta)

func start_engine() -> void:
	using_fuel = true

func stop_engine() -> void:
	using_fuel = false
	_on_cooldown()

func has_enough_fuel() -> bool:
	if value > 0.0:
		return true
	return false

func _use_fuel(_delta: float) -> void:
	value -= _delta * fuel_use_factor

func use_fuel_to_shoot() -> void:
	value -= shoot_fuel_cost

func _refill(_delta: float) -> void:
	if not using_fuel:
		value += _delta * fuel_refill_factor
	pass

func _on_cooldown() -> void:
	on_cooldown = true
	cooldown_timer.start()
	
func _off_cooldown() -> void:
	on_cooldown = false
	
func enough_fuel_to_shoot() -> bool:
	return value >= shoot_fuel_cost
