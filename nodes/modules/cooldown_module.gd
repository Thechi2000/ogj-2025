class_name CooldownModule
extends Module

var _is_ready = true
var timer: SceneTreeTimer

func cooldown():
	return 1.0

func is_ready() -> bool:
	return _is_ready

func _mark_ready():
	timer = null
	player.hud.set_module_ready(slot)
	_is_ready = true

func _process(delta: float) -> void:
	if !_is_ready:
		player.hud.set_module_cooldown(slot, timer.time_left)

func use():
	if _is_ready:
		_is_ready = false
		timer = get_tree().create_timer(cooldown())
		timer.timeout.connect(_mark_ready)
		_use()

func _use():
	pass
