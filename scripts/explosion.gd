extends AnimatedSprite3D

func _enter_tree():	
	play("default")
	animation_looped.connect(_on_animation_finished)
	
func _on_animation_finished() -> void:
	stop()
	frame = 4
	queue_free()
	
