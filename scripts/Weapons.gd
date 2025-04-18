extends Node3D

@export var gunTimer : Timer
@export var gunShot : AudioStreamPlayer3D
@export var muzzleLight : OmniLight3D

@export var gun1Flash : AnimatedSprite3D
@export var gun2Flash : AnimatedSprite3D

@export var gun1 : RayCast3D
@export var gun2 : RayCast3D

var BULLETSPEED : float = 10000

var explosionInstance = preload("res://scenes/explosion.tscn")
var tracerInstance = preload("res://scenes/tracer.tscn")

var weaponsFiring : bool
var gunRPMTimer = .1

var aimPos : Vector3

var viewCast : RayCast3D



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
	gun1Flash.play("default")
	muzzleFlashPoint()
	hitScan1()
	gunShot.play()
	await get_tree().create_timer(.05).timeout
	gun2Flash.play("default")
	muzzleFlashPoint()
	hitScan2()
	gunShot.play()
	gunTimer.start(gunRPMTimer)
		
	#this is fine for now but the rpm offset should be more configurable and random

func muzzleFlashPoint():
	muzzleLight.visible = true
	await get_tree().create_timer(.05).timeout
	muzzleLight.visible = false

#shitscan funcion is BADDD and needs to be RE-WRITTEN, will do that someday... ITS LAGGING!!
#divide all this into multiple funcions, hitscans should be for HITSCAN!!!

func hitScan1():
	if(gun1.is_colliding()):
		var explosionPos = gun1.get_collision_point()
		#var gunDisatnce = explosionPos.distance_to(position)
		
		drawTracer(gun1.global_position,gun1.global_rotation_degrees,explosionPos)
		
		var explosion : Node3D = explosionInstance.instantiate()
		#await get_tree().create_timer(gunDisatnce/(BULLETSPEED)).timeout
		get_tree().current_scene.add_child(explosion)
		explosion.position = explosionPos
	else:
		drawTracer(gun1.global_position,gun1.global_rotation_degrees,get_ray_end_point(gun1,-1000))
		
func hitScan2():
	if(gun2.is_colliding()):
		var explosionPos = gun2.get_collision_point()
		#var gunDisatnce = explosionPos.distance_to(position)
		
		drawTracer(gun2.global_position,gun2.global_rotation_degrees,explosionPos)
		
		var explosion : Node3D = explosionInstance.instantiate()
		#await get_tree().create_timer(gunDisatnce/(BULLETSPEED)).timeout
		get_tree().current_scene.add_child(explosion)
		explosion.position = explosionPos
	else:
		drawTracer(gun2.global_position,gun2.global_rotation_degrees,get_ray_end_point(gun2,-1000))

func drawTracer(pos : Vector3, rot : Vector3, targetPos : Vector3):
	var tracer : Node3D = tracerInstance.instantiate()
	get_tree().current_scene.add_child(tracer)
	tracer.position = pos
	tracer.rotation_degrees = rot
	
	var tween = get_tree().create_tween()
	tween.tween_property(tracer, "position", targetPos, targetPos.distance_to(pos)/(BULLETSPEED/10.0))
	tween.tween_callback(tracer.queue_free)
	tween.tween_callback(tween.kill)
	#tween.connect("tween_all_completed", queue_free, 0)
		
func get_ray_end_point(raycast : RayCast3D, distance : float) -> Vector3:
	var start = raycast.global_position
	var direction = raycast.global_transform.basis.z.normalized()
	return start + direction * distance
