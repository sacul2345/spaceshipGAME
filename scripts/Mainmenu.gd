extends Control

@export var freeRoamButton : Button

@export var multiplayerButton : Button
@export var multiplayerWindow : Window

@export var settingsButton : Button
@export var settingsWindow : Window



@export var menuMusic : AudioStreamPlayer

var freeRoamScene = preload("res://scenes/game_area.tscn")
var playMusic : bool = true

func _input(_event: InputEvent) -> void:
	if(menuMusic.playing == false && menuMusic != null && playMusic == true):
		menuMusic.playing = true

func _on_free_roam_button_pressed() -> void:
	menuMusic.playing = false
	GameManager.Players[0] = {
		"name: ": "FREEROAM"
	}
	var scene = load("res://scenes/game_area.tscn").instantiate()
	get_tree().root.add_child(scene)
	get_parent().queue_free()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Hud.show()

func _on_window_close_requested() -> void:
	multiplayerWindow.hide()
func _on_multiplayer_button_pressed() -> void:
	multiplayerWindow.show()


func _on_settings_button_pressed() -> void:
	settingsWindow.show()


func _on_settings_window_close_requested() -> void:
	settingsWindow.hide()

func _on_theme_button_pressed() -> void:
	menuMusic.seek(menuMusic.stream.get_length())
