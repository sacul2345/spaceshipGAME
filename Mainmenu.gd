extends Control

@export var freeRoamButton : Button
@export var menuMusic : AudioStreamPlayer
var freeRoamScene = preload("res://scenes/game_area.tscn")
var playMusic : bool = true

func _input(_event: InputEvent) -> void:
	if(menuMusic.playing == false && menuMusic != null && playMusic == true):
		menuMusic.playing = true

func _on_free_roam_button_pressed() -> void:
	menuMusic.playing = false
	get_tree().change_scene_to_file("res://scenes/game_area.tscn")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Hud.visible = true
