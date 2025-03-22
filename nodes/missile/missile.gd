extends Projectile

func _on_hit():
	var new_projectile = preload("res://nodes/explosion/explosion.tscn").instantiate()
	get_parent().add_child(new_projectile)
	new_projectile.rotation = self.global_rotation
	new_projectile.position = self.global_position
	
	queue_free()
