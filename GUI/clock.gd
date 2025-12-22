class_name Clock extends Control

@onready var time_label: Label = $Time

var total_time_sec: float = 0.0
var current_time_sec: float = 0.0
var _last_whole_second: int = -1
var _time_over_emitted := false

func _ready() -> void:
	visible = false
	EventBus.level_timer.connect(set_time)
	
func set_time(total_minutes: float) -> void:
	visible = true
	total_time_sec = maxf(0.0, total_minutes * 60.0)
	current_time_sec = total_time_sec
	_last_whole_second = -1
	_time_over_emitted = false
	_update_label()

func _process(delta: float) -> void:
	if current_time_sec <= 0.0:
		if not _time_over_emitted:
			_time_over_emitted = true
			EventBus.time_over.emit()
		return

	current_time_sec = maxf(0.0, current_time_sec - delta)

	var whole := int(floor(current_time_sec))
	if whole != _last_whole_second:
		_last_whole_second = whole
		_update_label()

func _update_label() -> void:
	var remaining := int(ceil(current_time_sec))
	remaining = maxi(0, remaining)

	var minutes := remaining / 60
	var seconds := remaining % 60

	time_label.text = "%d:%02d" % [minutes, seconds]
