extends CharacterBody2D

@export var movement_speed := 100.0

@onready var navigation_agent := $NavigationAgent2D
var target : Node2D = null

var weapons : Array[EnemyWeapon] = []

func _ready():
	var players = get_tree().get_nodes_in_group("Player")
	if not players.is_empty():
		target = players[0]
	weapons.assign(get_children().filter(func(child: Node): return child is EnemyWeapon))
	navigation_agent.max_speed = movement_speed

func set_movement_target(movement_target: Vector2):
	if movement_target.distance_squared_to(navigation_agent.target_position) > 400.0:
		navigation_agent.target_position = movement_target

func _physics_process(delta):
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
