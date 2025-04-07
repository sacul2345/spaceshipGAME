extends Node3D
var time : float

func _process(delta: float) -> void:
	
	position.y += sin(.4*time) * delta
	rotation.x = 2*sin(.4*time) * delta
	time+=.01
