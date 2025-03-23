extends CanvasLayer

@export var module_selectors : Dictionary[Player.ModuleSlot, Node]

func _exit():
	pass

func cancel():
	_exit()

func confirm():
	_exit()
