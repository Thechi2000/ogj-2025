class_name AnimatedLeg
extends CooldownModule

@export var left_sprite : Texture
@export var right_sprite : Texture

@export var leg_end_path : NodePath
@export var target_path : NodePath
@export var max_distance : float
@export var rest_position : Vector2

@onready var leg_end = get_node(leg_end_path)
@onready var target = get_node(target_path)

func bind(player: Player, slot: Player.ModuleSlot):
	super(player, slot)
	if not self.is_ready():
		await self.ready
	$Skeleton2D/TopLeg/TopLegSprite.texture = left_sprite if self.is_left_module else right_sprite
	$Skeleton2D/TopLeg/BottomLeg/BottomLegSprite.texture = left_sprite if self.is_left_module else right_sprite

func _physics_process(delta: float) -> void:
	if target.global_position.distance_squared_to(leg_end.global_position) >= max_distance*max_distance:
		reset_target()

func reset_target():
	var tween = get_tree().create_tween()
	tween.tween_property(target, "global_position", global_position + rest_position, 0.1)
