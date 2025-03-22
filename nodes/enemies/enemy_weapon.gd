class_name EnemyWeapon
extends Node

func is_ready() -> bool:
	return false

func should_fire(position: Vector2, target: Vector2) -> bool:
	return false

func fire(target: Vector2):
	pass
