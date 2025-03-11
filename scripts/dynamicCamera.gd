extends Camera3D

const CAM_FOV = 75
const CAM_WEIGHT = .05
var rigidBody : RigidBody3D

var verticalVelocity : float
var horizontalVelocity : float

func _ready():
	rigidBody = get_parent()
	
func _physics_process(_delta) -> void:
	print(rigidBody.transform.basis.z)
	print(rigidBody.transform.basis.y)

#func _input(_event):
#	var desiredPos =  MovingCross.viewCenter - MovingCross.mousePos
#	h_offset =- (desiredPos.x/150 - h_offset) * CAM_WEIGHT
#	v_offset =+ (desiredPos.y/150 - v_offset) * CAM_WEIGHT
