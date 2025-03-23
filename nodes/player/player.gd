class_name Player
extends CharacterBody2D

@export var speed = 250 # How fast the player will move (pixels/sec).
@onready var hud: HUD = $HUD

var modules: Dictionary[ModuleSlot, Module]
@onready var module_positions: Dictionary[ModuleSlot, Node2D] = {
	ModuleSlot.LeftArm: $LeftArm,
	ModuleSlot.RightArm: $RightArm,
	ModuleSlot.LeftLeg: $LeftLeg,
	ModuleSlot.RightLeg: $RightLeg,
	ModuleSlot.Body: $Body,
}

var max_health = 100
var health = 100
var inertia = 3
var stop = 10

enum ModuleSlot {
	LeftArm,
	RightArm,
	LeftLeg,
	RightLeg,
	Body
}

enum AllowedActions {
	ModuleLeftArm = 1 << 0,
	ModuleRightArm = 1 << 1,
	ModuleLeftLeg = 1 << 2,
	ModuleRightLeg = 1 << 3,
	ModuleBody = 1 << 4,
	Movement = 1 << 5
}

@export_flags("LeftArm","RightArm","LeftLeg","RightLeg","Body","Movement") var allowed = -1
@export var damage_taken_factor = 1

@export var invisible = false

func _ready():
	pass

func add_module(slot: ModuleSlot, module: Module):
	modules[slot] = module
	module_positions[slot].add_child(module)
	module.bind(self, slot)

func remove_module(slot: ModuleSlot):
	if modules.has(slot):
		modules[slot].unbind()
		modules[slot].queue_free()
		modules.erase(slot)

func _process(_delta):
	if allowed & AllowedActions.Movement != 0:
		var new_velocity = Vector2.ZERO # The player's movement vector.
		if Input.is_action_pressed("move_right"):
			new_velocity.x += 1
			$AnimatedSprite2D.flip_h = false
		if Input.is_action_pressed("move_left"):
			new_velocity.x -= 1
			$AnimatedSprite2D.flip_h = true
		if Input.is_action_pressed("move_down"):
			new_velocity.y += 1
		if Input.is_action_pressed("move_up"):
			new_velocity.y -= 1
		inertia -= 1

		if (new_velocity.length() > 0) and (velocity.length() <= speed) and (inertia <= 0):
			velocity += new_velocity.normalized() * speed / 15
			if inertia == -5:
				inertia = 4
		elif velocity.length() >= stop:
			velocity -= velocity.normalized() * stop
		else:
			velocity = Vector2.ZERO

	try_use("use_left_arm_module", ModuleSlot.LeftArm, AllowedActions.ModuleLeftArm)
	try_use("use_right_arm_module", ModuleSlot.RightArm, AllowedActions.ModuleRightArm)
	try_use("use_left_leg_module", ModuleSlot.LeftLeg, AllowedActions.ModuleLeftLeg)
	try_use("use_right_leg_module", ModuleSlot.RightLeg, AllowedActions.ModuleRightLeg)
	try_use("use_body_module", ModuleSlot.Body, AllowedActions.ModuleBody)

	move_and_slide()

func try_use(input, slot, flag):
	if Input.is_action_pressed(input) and modules.has(slot) && allowed & flag != 0:
		var mod: Module = modules[slot]
		if slot == ModuleSlot.LeftArm or slot == ModuleSlot.RightArm:
			mod.look_at(get_global_mouse_position())
		mod.use()

func update_health(diff):
	if health <= 0:
		return
	
	health += diff * damage_taken_factor
	hud.set_current_health(health)

	if health <= 0:
		var explosion = preload("res://nodes/nuke/nuke.tscn").instantiate()
		explosion.global_position = global_position
		explosion.scale *= Vector2(2, 2)
		add_sibling(explosion)

		hide()
		allowed = 0
		invisible = true

		get_tree().create_timer(3.0).timeout.connect(func(): get_tree().change_scene_to_file("res://nodes/game_over/game_over.tscn"))
