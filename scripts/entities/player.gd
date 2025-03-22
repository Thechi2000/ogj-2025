class_name Player
extends Area2D

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

func add_module(slot: ModuleSlot, module: Module):
	modules[slot] = module
	module.bind(self)

func remove_module(slot: ModuleSlot):
	if modules.has(slot):
		modules[slot].unbind()
		modules.erase(slot)

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

	if Input.is_action_pressed("use_left_arm_module") and modules.has(ModuleSlot.LeftArm):
		modules[ModuleSlot.LeftArm].use()
	if Input.is_action_pressed("use_right_arm_module") and modules.has(ModuleSlot.RightArm):
		modules[ModuleSlot.RightArm].use()
	if Input.is_action_pressed("use_left_leg_module") and modules.has(ModuleSlot.LeftLeg):
		modules[ModuleSlot.LeftLeg].use()
	if Input.is_action_pressed("use_right_leg_module") and modules.has(ModuleSlot.RightLeg):
		modules[ModuleSlot.RightLeg].use()
	if Input.is_action_pressed("use_body_module") and modules.has(ModuleSlot.Body):
		modules[ModuleSlot.Body].use()

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
	$AnimatedSprite2D.flip_h = velocity.x < 0

func update_health(diff):
	health += diff
	hud.set_current_health(health)
