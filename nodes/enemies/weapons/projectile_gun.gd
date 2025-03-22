extends EnemyWeapon

@export var cooldown := 1.0

var can_fire := true

func is_ready() -> bool:
	return can_fire

func should_fire(position: Vector2, target: Vector2) -> bool:
	
	return false

func fire(target: Vector2):
	can_fire = false
	var projectile = preload("res://nodes/projectile/projectile.tscn").instantiate()
	get_tree().create_timer(cooldown).timeout.connect(func(): can_fire = true)
