extends CanvasLayer

@export var module_selectors : Dictionary[Player.ModuleSlot, OptionButton]
var possible_choices : Dictionary[Player.ModuleSlot, Array]

func _ready():
	possible_choices = LevelManager.load_choices()
	for i in possible_choices:
		module_selectors[i].clear()
		for j in possible_choices[i]:
			module_selectors[i].add_item(j)

func _exit():
	LevelManager.next_level()

func cancel():
	_exit()

func confirm():
	var chosen = {}
	for i in module_selectors:
		chosen[i] = module_selectors[i].get_item_text(module_selectors[i].selected)
	
	LevelManager.set_choices(chosen)
	_exit()
