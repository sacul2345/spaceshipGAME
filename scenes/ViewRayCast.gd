extends RayCast3D

signal hasTarget
var targetPos

func _ready():
	targetPos = get_collision_point()

func _physics_process(_delta):
	if is_colliding():
		hasTarget.emit()
		#print(targetPos)
