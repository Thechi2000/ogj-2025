class_name CooldownModule
extends Module

var _ready = true

func cooldown():
	return 1.0

func is_ready() -> bool:
	return _ready

func _mark_ready():
	_ready = true

func use():
	if _ready:
		_ready = false
		get_tree().create_timer(cooldown()).timeout.connect(_mark_ready)
		_use()

func _use():
	pass
