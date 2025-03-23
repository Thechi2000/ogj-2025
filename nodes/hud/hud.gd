class_name HUD
extends CanvasLayer

func set_max_health(max_health):
	$ProgressBar.max_value = max_health

func set_current_health(health):
	$ProgressBar.value = health
	
	
func _get_module_hud(module: Player.ModuleSlot) -> AbilityIndicator:
	match module:
		Player.ModuleSlot.LeftArm: return $LeftArm
		Player.ModuleSlot.RightArm: return $RightArm
		Player.ModuleSlot.LeftLeg: return $LeftLeg
		Player.ModuleSlot.RightLeg: return $RightLeg
		Player.ModuleSlot.Body: return $Body
	return null

func set_module_cooldown(module: Player.ModuleSlot, cooldown: float):
	_get_module_hud(module).update_timer(cooldown)

func set_module_ready(module: Player.ModuleSlot):
	_get_module_hud(module).mark_ready()
	
