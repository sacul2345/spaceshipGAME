extends CPUParticles3D

@export var shipRigidBody : RigidBody3D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(shipRigidBody != null):
		if(shipRigidBody.linear_velocity.length() > 40):
			emitting = true
		else:
			emitting = false
