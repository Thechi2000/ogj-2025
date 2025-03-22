class_name Player
extends Area2D

@export var speed = 200 # How fast the player will move (pixels/sec).

@export var left_arm_module: Module
@export var right_arm_module: Module
@export var left_leg_module: Module
@export var right_leg_module: Module
@export var torso_module: Module

func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
	$AnimatedSprite2D.flip_h = velocity.x < 0
