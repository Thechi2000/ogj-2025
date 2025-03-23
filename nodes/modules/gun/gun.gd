extends CooldownModule

@export var DAMAGE := 10.0
@export var FIRING_DIR := Vector2.RIGHT*100.0
@export_flags_2d_physics var collision_layer: int
@export_flags_2d_physics var collision_mask: int
var is_left = false

func cooldown():
	return 0.2

func _use():
	var new_projectile = preload("res://nodes/projectile/projectile.tscn").instantiate()
	new_projectile.DAMAGE = DAMAGE
	new_projectile.direction = FIRING_DIR.rotated(self.rotation) * 3.5
	new_projectile.rotation = self.global_rotation
	new_projectile.position = $LCannon.global_position if is_left_module else $RCannon.global_position
	new_projectile.collision_layer = collision_layer
	new_projectile.collision_mask = collision_mask
	get_tree().current_scene.add_child(new_projectile)
