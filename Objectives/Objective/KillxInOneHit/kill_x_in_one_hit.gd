class_name KillXInOneHit extends Objective

var total_amount: int
var amount_left: int

func extra_setup_methods(tier: int) -> void:
	total_amount = tier + 2
	amount_left = total_amount
	EventBus.hit_enemy_shoot.connect(update_objective)
	EventBus.end_shoot_state.connect(reset_objective)
	update_label()

func update_label() -> void:
	var label_text: String = "Kill " + str(total_amount) + " Enemies in one hit"
	EventBus.update_objective.emit(display_id,label_text, str(amount_left), str(total_amount))

func reset_objective() -> void:
	amount_left = total_amount
	update_label()
	pass

func update_objective(_enemy: Enemy) -> void:
	if active:
		amount_left -= 1
		update_label()
		if amount_left <= 0:
			EventBus.end_shoot_state.disconnect(reset_objective)
			EventBus.objective_completed.emit(display_id)
			active = false
