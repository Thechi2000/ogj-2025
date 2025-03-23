extends CooldownModule

func cooldown():
	return 15

func _use():
	$Timer.start()
	player.invisible = true
	
	player.modulate.a = 0.5

func _on_timer_timeout() -> void:
	player.modulate.a = 1.0
	player.invisible = false
