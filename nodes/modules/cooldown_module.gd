class_name CooldownModule
extends Module

var _is_ready = true

func cooldown():
	return 1.0

func is_ready() -> bool:
	return _is_ready

func _mark_ready():
	_is_ready = true

func use():
	if _is_ready:
		_is_ready = false
		get_tree().create_timer(cooldown()).timeout.connect(_mark_ready)
		_use()

func _use():
	pass
