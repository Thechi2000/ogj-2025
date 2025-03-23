extends CooldownModule

var player: Player

func bind(p, slot):
	super.bind(p, slot)
	player = p

func cooldown():
	return 15

func _use():
	$WindupTimer.start()
	player.velocity = Vector2.ZERO
	player.allowed &= ~Player.AllowedActions.Movement

func _on_windup_timer_timeout() -> void:
	player.global_position = get_global_mouse_position()
	player.allowed = -1
