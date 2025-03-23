class_name BaseEnemy
extends CharacterBody2D

@export var max_health := 40.0
var health := max_health

@export var movement_speed := 100.0

@onready var navigation_agent := $NavigationAgent2D
var target : Player = null

@export var weapons : Array[EnemyWeapon]

func _target_player():
	var players = get_tree().get_nodes_in_group("Player")
	var visible_players = players.filter(func(p): return !p.invisible)
	if not visible_players.is_empty():
		target = visible_players[0]

func _ready():
	_target_player()
	navigation_agent.max_speed = movement_speed

func _process(delta: float):
	if target == null:
		_target_player()
	elif target.invisible:
		target = null

func set_movement_target(movement_target: Vector2):
	if movement_target.distance_squared_to(navigation_agent.target_position) > 400.0:
		navigation_agent.target_position = movement_target

func _physics_process(_delta):
	if target != null:
		set_movement_target(target.global_position)
		for i in weapons:
			if i.is_ready() and i.should_fire(global_position, target.global_position):
				i.fire(target.global_position)
	
	if navigation_agent.is_navigation_finished():
		return
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	move_and_slide()

func update_health(diff):
	if health <= 0:
		return
	
	health += diff

	if health <= 0:
		var explosion = preload("res://nodes/explosion/explosion.tscn").instantiate()
		explosion.global_position = global_position
		explosion.DAMAGE = 0
		add_sibling(explosion)
		queue_free()
