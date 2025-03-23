class_name AnimatedLeg
extends CooldownModule

@export var left_sprite : Texture
@export var right_sprite : Texture

@export var leg_end : Node2D
@export var target : Node2D
@export var max_distance : float
@export var rest_position : Vector2

func _physics_process(delta: float) -> void:
	if target.global_position.distance_squared_to(leg_end.global_position) >= max_distance*max_distance:
		reset_target()

func reset_target():
	var tween = get_tree().create_tween()
	tween.tween_property(target, "global_position", global_position + rest_position, 0.1)
