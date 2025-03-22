extends StaticBody2D

@export var DAMAGE = 40.0

func _ready():
	$AnimatedSprite2D.play()
	$Timer.start()

func _on_timer_timeout() -> void:
	queue_free()
