class_name Projectile
extends CharacterBody2D

@export var DAMAGE : float = 0.0
@export var direction := Vector2()

func _on_hit(node: Node2D):
	if node.has_method("update_health"):
		node.update_health(-DAMAGE)
	queue_free()

func _physics_process(delta: float) -> void:
	var col = self.move_and_collide(direction * delta)
	if col:
		_on_hit(col.get_collider())
