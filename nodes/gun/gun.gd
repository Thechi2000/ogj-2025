extends Node2D

@export var DAMAGE := 10.0
@export var FIRING_DIR := Vector2.RIGHT*100.0

func fire():
	var new_projectile = preload("res://nodes/projectile/projectile.tscn").instantiate()
	new_projectile.DAMAGE = DAMAGE
	new_projectile.direction = FIRING_DIR.rotated(self.rotation)
	new_projectile.rotation = self.rotation
	new_projectile.position = self.position
	get_tree().current_scene.add_child(new_projectile)
