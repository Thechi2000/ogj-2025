class_name Module
extends Node2D

@export var leftSprite : Node2D
@export var rightSprite : Node2D
var is_left_module

func bind(_player: Player, is_left_module: bool):
	self.is_left_module = is_left_module
	if leftSprite:
		leftSprite.visible = is_left_module
	if rightSprite:
		rightSprite.visible = not is_left_module

func unbind():
	pass

func use():
	pass
