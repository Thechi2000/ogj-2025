class_name BaseEnemy
extends CharacterBody2D

@export var max_health := 40.0
var health := max_health

@export var movement_speed := 100.0

@onready var navigation_agent := $NavigationAgent2D
var target : Player = null

@export var weapons : Array[EnemyWeapon]

var drops = [
	[Player.ModuleSlot.LeftArm, "Gun"],
	[Player.ModuleSlot.RightArm, "Gun"],
	[Player.ModuleSlot.LeftArm, "Missile"],
	[Player.ModuleSlot.RightArm, "Missile"],
	[Player.ModuleSlot.LeftArm, "Sword"],
	[Player.ModuleSlot.RightArm, "Sword"],
	
	[Player.ModuleSlot.LeftLeg, "Base"],
	[Player.ModuleSlot.RightLeg, "Base"],
	[Player.ModuleSlot.LeftLeg, "Dash"],
	[Player.ModuleSlot.RightLeg, "Dash"],
	
	
	[Player.ModuleSlot.Body, "Base"],
	[Player.ModuleSlot.Body, "Warper"],
	[Player.ModuleSlot.Body, "Camouflage"],
]

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

		if randi() % 3 > 0:
			var selected_drop = drops[randi() % drops.size()]

			var drop = preload("res://nodes/pickups/pickup_module.tscn").instantiate()
			drop.module = selected_drop[0]
			drop.module_name = selected_drop[1]
			drop.global_position = global_position
			
			add_sibling(drop)
			drop.texture = preload("res://arts/mobs/bad_mech_arm.png")
			drop.scale = Vector2(0.2, 0.2)

		queue_free()
