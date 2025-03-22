extends EnemyWeapon

@onready var raycast := $RayCast2D
@export var cooldown := 1.0
@export var damage := 10.0
@export_flags_2d_physics var collision_layer: int
@export_flags_2d_physics var collision_mask: int

var can_fire := true

func is_ready() -> bool:
	return can_fire

func should_fire(position: Vector2, target: Vector2) -> bool:
	raycast.global_position = position
	raycast.target_position = target - position
	raycast.force_raycast_update()
	return not raycast.is_colliding()

func fire(target: Vector2):
	if (target-global_position).length_squared() <= 1.0:
		return
	
	can_fire = false
	var projectile = preload("res://nodes/projectile/projectile.tscn").instantiate()
	projectile.DAMAGE = damage
	projectile.direction = (target - global_position).normalized() * 500.0
	projectile.global_position = global_position
	projectile.look_at(target)
	projectile.collision_mask = collision_mask
	projectile.collision_layer = collision_layer
	get_tree().current_scene.add_child(projectile)
	get_tree().create_timer(cooldown).timeout.connect(func(): can_fire = true)
