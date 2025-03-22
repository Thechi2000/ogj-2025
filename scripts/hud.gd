class_name HUD
extends CanvasLayer

func set_max_health(max_health):
	$ProgressBar.max_value = max_health

func set_current_health(health):
	$ProgressBar.value = health
