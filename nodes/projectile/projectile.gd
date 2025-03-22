extends Area2D

@export var DAMAGE : float = 0.0

var direction := Vector2()

func _physics_process(delta: float) -> void:
	self.position += direction*delta
