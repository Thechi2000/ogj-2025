class_name Player
extends CharacterBody2D

@export var speed = 200 # How fast the player will move (pixels/sec).
@export var hud: HUD

var modules: Dictionary

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
	add_module(ModuleSlot.RightArm, preload("res://nodes/modules/missile_launcher/missile_launcher.tscn").instantiate())
	

func add_module(slot: ModuleSlot, module: Module):
	modules[slot] = module
	add_child(module)
	module.bind(self)

func remove_module(slot: ModuleSlot):
	if modules.has(slot):
		modules[slot].unbind()
		modules.erase(slot)

func _process(delta):
	velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
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

	var collision = move_and_collide(velocity*delta)
	if collision and collision.get_collider().has_method("damage"):
		var damages = collision.get_collider().damage(self)
		print(damages)
		update_health(-damages)

	$AnimatedSprite2D.flip_h = velocity.x < 0

func try_use(input, slot):
	if Input.is_action_pressed(input) and modules.has(slot):
		var mod: Module = modules[slot]
		mod.look_at(get_global_mouse_position())
		mod.use()

func update_health(diff):
	health += diff
	hud.set_current_health(health)
