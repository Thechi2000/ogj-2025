extends CooldownModule

func cooldown():
	return 10


func _use():
	player.allowed = 0

	player.velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		player.velocity.x += 1
	if Input.is_action_pressed("move_left"):
		player.velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		player.velocity.y += 1
	if Input.is_action_pressed("move_up"):
		player.velocity.y -= 1
	if player.velocity == Vector2.ZERO:
		player.velocity = Vector2.RIGHT
		
	player.velocity = player.velocity.normalized() * player.speed * 3
	
	$Timer.start()

func _on_timer_timeout() -> void:
	player.allowed = -1
	player.velocity = Vector2.ZERO
