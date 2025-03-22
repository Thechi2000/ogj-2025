extends CharacterBody2D

@export var movement_speed := 100.0

@onready var navigation_agent := $NavigationAgent2D
var target : Node2D = null


func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 12.0
	navigation_agent.target_desired_distance = 12.0

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

func _physics_process(delta):
	if target != null:
		set_movement_target(target.global_position)
	
	if navigation_agent.is_navigation_finished():
		return
	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	move_and_slide()
