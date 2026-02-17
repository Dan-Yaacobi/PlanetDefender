extends Node

var current_planet: Planet
signal get_player(player: Player)

signal combo_reset
signal combo_added

signal hit_enemy_shoot(enemy: Enemy)
signal hit_enemy_move(enemy: Enemy)
signal end_shoot_state

signal objective_completed(id: int)

signal update_objective(id: int, text: String, amount_left: String, total: String)
signal new_objective(id: int)

signal level_timer(time: float)
signal time_over

signal apply_power_up(power_up: PowerUp)
