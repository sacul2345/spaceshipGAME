extends TextureRect

@export var centerCross : TextureRect

var viewCenter : Vector2
var mousePos : Vector2
var crossPos : Vector2

var axisDistance : Vector2
var distance : float
var centerRad : float

var arrowAlpha : float

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _input(_event):
	if(centerCross != null):
		centerCross.position = get_viewport_rect().size/2
	
	viewCenter = get_viewport_rect().size/2
	mousePos = get_viewport().get_mouse_position()
	crossPos = position
	
	axisDistance = crossPos - viewCenter
	distance = mousePos.distance_to(viewCenter)
	centerRad = atan2(axisDistance.y + 15,axisDistance.x + 10) #I have no idea why i need to add these random numbers but they center the point where the crosshair orbits
	
	if(distance < 255):
		self_modulate.a = (distance - 20)/255
	
	position = mousePos
	rotation = centerRad + PI/2
	
	
	
	
	
	
	
	
	
