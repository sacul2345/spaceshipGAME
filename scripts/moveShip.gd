extends RigidBody3D

const DEADZONE = .2
const MULTIPLIER = .5

var mousePos : Vector2
var rotationVector : Vector3
var arrowDistance : float

var yaw : float
var pitch : float

func _ready():
	pass

func _physics_process(delta):
	mousePos = (MovingCross.axisDistance)/50
	arrowDistance = MovingCross.distance
	rotationVector = Vector3(-mousePos.y,-mousePos.x,0).normalized()
	yaw = rotationVector.y * MULTIPLIER * delta
	pitch = rotationVector.x  * MULTIPLIER * delta
	
	if(abs(mousePos.x) > DEADZONE or abs(mousePos.y) > DEADZONE): 
		apply_torque_impulse((transform.basis.x * pitch) * arrowDistance)
		apply_torque_impulse((transform.basis.y * yaw) * arrowDistance)
		
	
	if(Input.is_action_pressed("roll_Left")): apply_torque_impulse(transform.basis.z * MULTIPLIER)
	if(Input.is_action_pressed("roll_Right")): apply_torque_impulse(-transform.basis.z * MULTIPLIER)
	if(Input.is_action_pressed("foward")): apply_central_impulse(-transform.basis.z + -transform.basis.z * (Input.is_action_pressed("boost") as int) * 2)
	if(Input.is_action_pressed("back")): apply_central_impulse(transform.basis.z)
	if(Input.is_action_pressed("up")): apply_central_impulse(transform.basis.y)
	if(Input.is_action_pressed("down")): apply_central_impulse(-transform.basis.y)
	if(Input.is_action_pressed("strafe_Left")): apply_central_impulse(-transform.basis.x)
	if(Input.is_action_pressed("strafe_Right")): apply_central_impulse(transform.basis.x)

	#print(linear_velocity.length())
