extends Node3D
var time : float
@export var world : WorldEnvironment

func _process(delta: float) -> void:
	
	position.y += .5*sin(.4*time) * delta
	rotation.x = sin(1*time) * delta
	time+= 2*delta

	#world.environment.sky_rotation.y -= 0.0000005
	#world.environment.sky_custom_fov += 0.0005
