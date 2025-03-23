extends CooldownModule

@export var DAMAGE := 10.0
@export var FIRING_DIR := Vector2.RIGHT*100.0

func cooldown():
	return 1.5

func _use():
	var new_projectile = preload("res://nodes/modules/missile_launcher/missile/missile.tscn").instantiate()
	new_projectile.direction = FIRING_DIR.rotated(self.rotation)
	new_projectile.rotation = self.global_rotation
	new_projectile.position = $LCannon.global_position if is_left_module else $RCannon.global_position
	get_tree().current_scene.add_child(new_projectile)
