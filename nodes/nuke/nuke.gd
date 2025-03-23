extends Area2D

func _ready():
	$AnimatedSprite2D.play()


func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()


func _on_animated_sprite_2d_animation_looped() -> void:
	queue_free()
