extends Node3D

@export var gunTimer : Timer
@export var gunShot : AudioStreamPlayer3D

var explosionInstance = preload("res://scenes/explosion.tscn")

var weaponsFiring : bool
var gunRPMTimer = .1

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
	if(weaponsFiring):
		fireWeapons()
	
func _input(_event):
	if(Input.is_action_pressed("attack")):
		weaponsFiring = true
	else:
		weaponsFiring = false

func fireWeapons():
	await gunTimer.timeout
	muzzleFlash()
	hitScan()
	gunShot.play()
	gunTimer.start(gunRPMTimer)
		
		
func muzzleFlash():
	if(gun1Flash.visible == false):
		gun1Flash.visible = true
		gun2Flash.visible = true
		await get_tree().create_timer(.05).timeout
		gun1Flash.visible = false
		gun2Flash.visible = false

func hitScan():
	if(gun1.is_colliding()):
		var explosion : Node3D = explosionInstance.instantiate()
		get_tree().current_scene.add_child(explosion)
		var explosionPos = gun1.get_collision_point()
		explosion.position = explosionPos
	if(gun2.is_colliding()):
		var explosion : Node3D = explosionInstance.instantiate()
		get_tree().current_scene.add_child(explosion)
		var explosionPos = gun2.get_collision_point()
		explosion.position = explosionPos

	
		
