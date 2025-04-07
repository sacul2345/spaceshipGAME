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
	pivot_offset = size / 2


func _input(_event):
	if(centerCross != null):
		centerCross.position = get_viewport_rect().size/2
	
	viewCenter = get_viewport_rect().size/2
	mousePos = get_viewport().get_mouse_position()
	crossPos = position
	
	axisDistance = crossPos - viewCenter
	distance = mousePos.distance_to(viewCenter)
	centerRad = atan2(axisDistance.y + size.y/2, axisDistance.x + size.x/2)
	
	if(distance < 255):
		self_modulate.a = (distance - 5)/255
	
	position = mousePos - size/2
	rotation = centerRad + PI/2
