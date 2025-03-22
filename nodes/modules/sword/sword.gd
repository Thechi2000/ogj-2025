extends CooldownModule

@export var DAMAGE = 60

var _active = false

func cooldown():
	return 1

func _ready():
	$AnimatedSprite2D.hide()

func _use():
	$AnimatedSprite2D.show()
	$AnimatedSprite2D.play()
	$WindupTimer.start()

func _on_body_entered(body: Node2D) -> void:
	if _active and body.has_method("update_health"):
		body.update_health(-DAMAGE)

func _on_active_timer_timeout() -> void:
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.hide()
	_active = false

func _on_windup_timer_timeout() -> void:
	$ActiveTimer.start()
	_active = true

	for body in ($"." as Area2D).get_overlapping_bodies():
		_on_body_entered(body)
