class_name Projectile
extends CharacterBody2D

@export var DAMAGE : float = 0.0
@export var direction := Vector2()

func _on_hit():
	queue_free()

func _physics_process(delta: float) -> void:
	if self.move_and_collide(direction * delta):
		_on_hit()
