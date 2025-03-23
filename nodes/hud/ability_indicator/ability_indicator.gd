class_name AbilityIndicator
extends ColorRect

@export var KEYBIND: String

func _ready():
	mark_ready()
	$Keybind.text = KEYBIND


func update_timer(time: float):
	$Keybind.add_theme_color_override("font_color", Color.DIM_GRAY)
	$Cooldown.show()
	$Cooldown.text = ("%.0f" if time >= 10 else "%.1f") % time
	
func mark_ready():
	$Keybind.add_theme_color_override("font_color", Color.WHITE)
	$Cooldown.hide()
