extends StaticBody2D

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
