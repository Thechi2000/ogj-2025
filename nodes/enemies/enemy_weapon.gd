class_name EnemyWeapon
extends Node2D

func is_ready() -> bool:
	return false

func should_fire(_position: Vector2, _target: Vector2) -> bool:
	return false

func fire(_target: Vector2):
	pass
