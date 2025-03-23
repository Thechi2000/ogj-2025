class_name Module
extends Node2D

@export var leftSprite : Node2D
@export var rightSprite : Node2D

var player: Player
var slot: Player.ModuleSlot
var is_left_module: bool

func bind(player: Player, slot: Player.ModuleSlot):
	self.is_left_module = slot == Player.ModuleSlot.LeftArm or slot == Player.ModuleSlot.LeftLeg
	self.player = player
	self.slot = slot

	if leftSprite:
		leftSprite.visible = is_left_module
	if rightSprite:
		rightSprite.visible = not is_left_module

func unbind():
	pass

func use():
	pass
