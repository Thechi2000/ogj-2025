class_name Player
extends CharacterBody2D

@export var speed = 200 # How fast the player will move (pixels/sec).
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

func _ready():
	add_module(ModuleSlot.LeftArm, preload("res://nodes/modules/gun/gun.tscn").instantiate())
	add_module(ModuleSlot.RightArm, preload("res://nodes/modules/missile_launcher/missile_launcher.tscn").instantiate())
	add_module(ModuleSlot.LeftLeg, preload("res://nodes/modules/dash/dash.tscn").instantiate())
	add_module(ModuleSlot.RightLeg, preload("res://nodes/modules/dash/dash.tscn").instantiate())
	add_module(ModuleSlot.Body, preload("res://nodes/modules/base_torso/base_torso.tscn").instantiate())

func add_module(slot: ModuleSlot, module: Module):
	modules[slot] = module
	module_positions[slot].add_child(module)
	module.bind(self, slot == ModuleSlot.LeftArm or slot == ModuleSlot.LeftLeg)

func remove_module(slot: ModuleSlot):
	if modules.has(slot):
		modules[slot].unbind()
		modules[slot].queue_free()
		modules.erase(slot)

func _process(_delta):
	if allowed & AllowedActions.Movement != 0:
		velocity = Vector2.ZERO # The player's movement vector.
		if Input.is_action_pressed("move_right"):
			velocity.x += 1
			$AnimatedSprite2D.flip_h = false
		if Input.is_action_pressed("move_left"):
			velocity.x -= 1
			$AnimatedSprite2D.flip_h = true
		if Input.is_action_pressed("move_down"):
			velocity.y += 1
		if Input.is_action_pressed("move_up"):
			velocity.y -= 1

		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
			
	if modules.has(ModuleSlot.LeftArm):
		modules[ModuleSlot.LeftArm].look_at(get_global_mouse_position())
	if modules.has(ModuleSlot.RightArm):
		modules[ModuleSlot.RightArm].look_at(get_global_mouse_position())

	try_use("use_left_arm_module", ModuleSlot.LeftArm, AllowedActions.ModuleLeftArm)
	try_use("use_right_arm_module", ModuleSlot.RightArm, AllowedActions.ModuleRightArm)
	try_use("use_left_leg_module", ModuleSlot.LeftLeg, AllowedActions.ModuleLeftLeg)
	try_use("use_right_leg_module", ModuleSlot.RightLeg, AllowedActions.ModuleRightLeg)
	try_use("use_body_module", ModuleSlot.Body, AllowedActions.ModuleBody)

	move_and_slide()

func try_use(input, slot, flag):
	if Input.is_action_pressed(input) and modules.has(slot) && allowed & flag != 0:
		var mod: Module = modules[slot]
		mod.use()

func update_health(diff):
	health += diff
	hud.set_current_health(health)
