extends CooldownModule

@export var DAMAGE := 10.0
@export var FIRING_DIR := Vector2.RIGHT*100.0
@export_flags_2d_physics var collision_mask

func cooldown():
	return 0.2

func _use():
	var new_projectile = preload("res://nodes/projectile/projectile.tscn").instantiate()
	new_projectile.DAMAGE = DAMAGE
	new_projectile.direction = FIRING_DIR.rotated(self.rotation)
	new_projectile.rotation = self.global_rotation
	new_projectile.position = self.global_position
	new_projectile.set_collision_mask_value(collision_mask, true)
	get_tree().current_scene.add_child(new_projectile)
