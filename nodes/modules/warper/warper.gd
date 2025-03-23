extends CooldownModule

func bind(p, slot):
	super.bind(p, slot)

func cooldown():
	return 15

func _use():
	$WindupTimer.start()
	player.velocity = Vector2.ZERO
	player.allowed &= ~Player.AllowedActions.Movement

func _on_windup_timer_timeout() -> void:
	player.global_position = get_global_mouse_position()
	player.allowed = -1
