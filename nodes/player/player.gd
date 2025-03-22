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

func _ready():
	add_module(ModuleSlot.LeftArm, preload("res://nodes/modules/gun/gun.tscn").instantiate())
	add_module(ModuleSlot.RightArm, preload("res://nodes/modules/sword/sword.tscn").instantiate())

func add_module(slot: ModuleSlot, module: Module):
	modules[slot] = module
	module_positions[slot].add_child(module)
	module.bind(self, slot == ModuleSlot.LeftArm or slot == ModuleSlot.LeftLeg)

func remove_module(slot: ModuleSlot):
	if modules.has(slot):
		modules[slot].unbind()
		modules[slot].queue_free()
		modules.erase(slot)

func _process(delta):
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

	try_use("use_left_arm_module", ModuleSlot.LeftArm)
	try_use("use_right_arm_module", ModuleSlot.RightArm)
	try_use("use_left_leg_module", ModuleSlot.LeftLeg)
	try_use("use_right_leg_module", ModuleSlot.RightLeg)
	try_use("use_body_module", ModuleSlot.Body)

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	move_and_slide()

func try_use(input, slot):
	if Input.is_action_pressed(input) and modules.has(slot):
		var mod: Module = modules[slot]
		mod.look_at(get_global_mouse_position())
		mod.use()

func update_health(diff):
	health += diff
	hud.set_current_health(health)
