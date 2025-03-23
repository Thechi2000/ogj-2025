extends TextureRect

@export var speed = Vector2(10.0, 10.0)

var offset = Vector2()

func _process(delta: float) -> void:
	offset += delta*speed
	if offset.x >= 1920.0:
		offset.x -= 1920.0
	if offset.y >= 1080.0:
		offset.y -= 1080.0
	position = offset - Vector2(1920, 1080)
