class_name KillX extends Objective

var total_amount: int
var amount_left: int

func extra_setup_methods(tier: int) -> void:
	total_amount = tier + randi_range(3,5)
	amount_left = total_amount
	EventBus.hit_enemy_shoot.connect(update_objective)
	EventBus.hit_enemy_move.connect(update_objective)
	update_label()

func update_label() -> void:
	var label_text: String = "Kill " + str(total_amount) + " Enemies"
	EventBus.update_objective.emit(display_id,label_text, str(total_amount - amount_left), str(total_amount))
	
func update_objective(_enemy: Enemy) -> void:
	if active:
		amount_left -= 1
		update_label()
		if amount_left <= 0:
			EventBus.objective_completed.emit(display_id)
			active = false
