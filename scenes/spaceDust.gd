extends CPUParticles3D

@export var shipRigidBody : RigidBody3D
@export var particleMultiplier : float

var shipSpeed : float
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	shipSpeed = shipRigidBody.linear_velocity.length()
	if(shipRigidBody != null):
		if(shipSpeed > 50):
			emitting = true
			#amount = shipSpeed * particleMultiplier
			#print(shipSpeed * particleMultiplier)
		else:
			emitting = false

		
		
		
