extends AudioStreamPlayer3D

@export var shipRigidBody : RigidBody3D
@export var engineAmbient : AudioStreamPlayer3D
@export var engineWah : AudioStreamPlayer3D

func _physics_process(_delta: float) -> void:
	if(shipRigidBody != null && engineAmbient != null && engineWah != null):
		pitch_scale = 1 + shipRigidBody.linear_velocity.length()/150
		engineAmbient.volume_db = (-5 - shipRigidBody.linear_velocity.length()/5)
		if(shipRigidBody.linear_velocity.length() > 40):
			engineWah.volume_db = -30 + (shipRigidBody.linear_velocity.length()/4)
			engineWah.pitch_scale = shipRigidBody.linear_velocity.length()/150
		else:
			engineWah.volume_db = -30

#I LOVE MAGIC NUMBERS!!! SURELY THIS WONT CAUSE ANY ISSUES
