extends Sprite2D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		$Gun.fire()
	if Input.is_action_pressed("ui_down"):
		$Gun.rotation_degrees += 20.0*delta
	if Input.is_action_pressed("ui_up"):
		$Gun.rotation_degrees -= 20.0*delta
