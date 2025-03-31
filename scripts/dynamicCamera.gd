extends Camera3D

@export var CAM_WEIGHT : float
@export var RETURN_SPEED : float

var rigidBody : RigidBody3D

var cameraBasis : Basis
var globalVelocity : Vector3
var relativeVelocity : Vector3

var verticalVelocity : float
var horizontalVelocity : float

func _ready():
	rigidBody = get_parent()
	
func _physics_process(_delta) -> void:
	#print(relativeVelocity)
	if(rigidBody):
		cameraBasis = global_transform.basis
		globalVelocity = rigidBody.angular_velocity
		relativeVelocity = cameraBasis.inverse() * globalVelocity
		
		offsetCam(relativeVelocity)
		
func offsetCam(localShipVelocity):
	var target_h_offset = (localShipVelocity.y) * -RETURN_SPEED
	var target_v_offset = (localShipVelocity.x) * RETURN_SPEED
	
	h_offset = lerp(h_offset,target_h_offset, CAM_WEIGHT)
	v_offset = lerp(v_offset,target_v_offset, CAM_WEIGHT)
		
	
	
	
