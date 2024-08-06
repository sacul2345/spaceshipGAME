extends Node3D

var aimPos : Vector3

var viewCast : RayCast3D

var gun1 : RayCast3D
var gun2 : RayCast3D

func _on_view_ray_cast_tree_entered():
	viewCast = $"../shipBody/ThirdPersonCam/ViewRayCast"
func _on_gun_1_tree_entered():
	gun1 = $Gun1
func _on_gun_2_tree_entered():
	gun2 = $Gun2

func _on_view_ray_cast_has_target():
	print(viewCast.get_collision_point())







