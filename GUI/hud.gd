class_name HUD extends CanvasLayer

@onready var ability_button_1: AbilityButton = $AbilityButton1
@onready var ability_button_2: AbilityButton = $AbilityButton2

@onready var power_up: PowerUpChoose = $PowerUps/PowerUp
@onready var power_up_2: PowerUpChoose = $PowerUps/PowerUp2
@onready var power_up_3: PowerUpChoose = $PowerUps/PowerUp3

func _ready() -> void:
	power_up.power_up_ability.connect(set_up_abilities)
	power_up_2.power_up_ability.connect(set_up_abilities)
	power_up_3.power_up_ability.connect(set_up_abilities)
	
## Currently tries to add the power up to ability 1, if it fails it will set up ability 2 and replace it if already exists
func set_up_abilities(_power_up: PowerUp) -> void:
	if !ability_button_1.power_up:
		ability_button_1.set_power_up(_power_up)
	else:
		ability_button_2.set_power_up(_power_up)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ability1"):
		ability_button_1.activate_ability()
		
	if event.is_action_pressed("ability2"):
		ability_button_2.activate_ability()
		
func _on_ability_button_1_pressed() -> void:
	ability_button_1.activate_ability()

func _on_ability_button_2_pressed() -> void:
	ability_button_2.activate_ability()
