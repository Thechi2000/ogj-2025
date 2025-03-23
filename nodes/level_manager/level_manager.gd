extends Node

@export var arm_modules : Dictionary[String, PackedScene]
@export var leg_modules : Dictionary[String, PackedScene]
@export var body_modules : Dictionary[String, PackedScene]
@export var currently_selected : Dictionary[Player.ModuleSlot, String]

@export var levels : Array[PackedScene]

var current_level := 0
var current_choices : Dictionary[Player.ModuleSlot, Array] = {}

func _ready():
	current_level = -1
	next_level()

func finish_level():
	var modules = get_tree().get_nodes_in_group("ModulePickup")
	
	current_choices = {}
	
	for i in currently_selected:
		current_choices[i] = [currently_selected[i]]
	
	for i in modules:
		if i is PickupModule:
			current_choices[i.module].append(i.module_name)
	get_tree().change_scene_to_file("res://module_menu.tscn")

func load_choices():
	return current_choices

func set_choices(selections : Dictionary[Player.ModuleSlot, String]):
	currently_selected = selections

func next_level():
	current_level += 1
	get_tree().change_scene_to_packed(levels[current_level])
	# Wait two frames for loading
	await get_tree().process_frame
	await get_tree().process_frame
	var player = get_tree().get_nodes_in_group("Player")[0] as Player
	for module in currently_selected:
		if module == Player.ModuleSlot.LeftArm or module == Player.ModuleSlot.RightArm:
			player.add_module(module, arm_modules[currently_selected[module]].instantiate())
		elif module == Player.ModuleSlot.LeftLeg or module == Player.ModuleSlot.RightLeg:
			player.add_module(module, leg_modules[currently_selected[module]].instantiate())
		else:
			player.add_module(module, body_modules[currently_selected[module]].instantiate())
