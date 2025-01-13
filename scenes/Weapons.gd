extends Node3D

var aimPos : Vector3

var viewCast : RayCast3D

var gun1 : RayCast3D
var gun2 : RayCast3D

var gun1Flash : Sprite3D
var gun2Flash : Sprite3D
func _on_view_ray_cast_tree_entered():
	viewCast = $"../ThirdPersonCam/ViewRayCast"
func _on_gun_1_tree_entered():
	gun1 = $Gun1
	gun1Flash = gun1.get_child(0)
func _on_gun_2_tree_entered():
	gun2 = $Gun2
	gun2Flash = gun2.get_child(0)

func _physics_process(_delta):
	moveFlash()
	
func _input(_event):
	if(Input.is_action_pressed("attack")):
		gun1Flash.visible = true
		gun2Flash.visible = true
	else:
		gun1Flash.visible = false
		gun2Flash.visible = false
	

func _on_view_ray_cast_has_target():
	print(viewCast.get_collision_point())

func moveFlash():
	if(gun1Flash.offset.x < 10000):
		gun1Flash.offset.x += 1500
		gun2Flash.offset.x += 1500
	else:
		gun1Flash.offset.x = 0
		gun2Flash.offset.x = 0
		





