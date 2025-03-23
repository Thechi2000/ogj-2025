extends CooldownModule

func _update_alpha(node: Node, value):
	if node is Sprite2D or node is AnimatedSprite2D:
		node.self_modulate.a = value
	
	for child in node.get_children():
		_update_alpha(child, value)
		

func cooldown():
	return 15

func _use():
	$Timer.start()
	player.invisible = true
	
	_update_alpha(player, 0.5)

func _on_timer_timeout() -> void:
	_update_alpha(player, 1.0)
	player.invisible = false
