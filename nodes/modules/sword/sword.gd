extends CooldownModule

@export var DAMAGE = 60

var _active = false

func cooldown():
	return 1

func _use():
	_active = true
	$AnimatedSprite2D.play()
	$ActiveTimer.start()
	
	for body in ($"." as Area2D).get_overlapping_bodies():
		_on_body_entered(body)

func _on_body_entered(body: Node2D) -> void:
	if _active and body.has_method("update_health"):
		body.update_health(-DAMAGE)

func _on_active_timer_timeout() -> void:
	$AnimatedSprite2D.stop()
	_active = false
