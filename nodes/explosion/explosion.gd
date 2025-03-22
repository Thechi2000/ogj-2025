extends Area2D

@export var DAMAGE = 30.0

var damaged = []

func _ready():
	$AnimatedSprite2D.play()
	$Timer.start()

func _on_timer_timeout() -> void:
	queue_free()

func damage(node: Node2D) -> float:
	if not node in damaged:
		damaged.append(node)
		return DAMAGE
	else:
		return 0

func _on_body_entered(body: Node2D) -> void:
	if not body in damaged and body.has_method("update_health"):
		damaged.append(body)
		body.update_health(-DAMAGE)
