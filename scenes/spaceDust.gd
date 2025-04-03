extends Node3D

@export var shipRigidBody : RigidBody3D
@export var particleMultiplier : float
@export var particles : CPUParticles3D

var shipSpeed : float

func _physics_process(_delta: float) -> void:
	if(shipRigidBody != null && particles != null):
		shipSpeed = shipRigidBody.linear_velocity.length()
		if(shipSpeed > 45):
			particles.emitting = true
			look_at(global_position - shipRigidBody.linear_velocity, Vector3.FORWARD)
		else:
			particles.emitting = false
