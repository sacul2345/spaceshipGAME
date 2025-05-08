extends Node

var MAXCLIENTS : int = 5

var gameLoaded : bool = false

@export var portInput : LineEdit
@export var nameInput : LineEdit

@export var menuNode : Node3D

var clientPeer
var address = "127.0.0.1"

@export var ipInput : LineEdit

func _ready() -> void:
	multiplayer.peer_connected.connect(playerConnected)
	multiplayer.peer_disconnected.connect(playerDisconnected)
	multiplayer.connected_to_server.connect(serverConnected)
	multiplayer.connection_failed.connect(connectionFailed)

func _on_lan_host_pressed() -> void:
	var serverPeer = ENetMultiplayerPeer.new()
	var error = serverPeer.create_server(portInput.text.to_int(), MAXCLIENTS)
	if error != OK:
		print("connection failed " + error)
		return
	multiplayer.multiplayer_peer = serverPeer
	print("Waiting for Players!")
	playerInfo(nameInput.text, multiplayer.get_unique_id())

func _on_lan_join_pressed() -> void:
	clientPeer = ENetMultiplayerPeer.new()
	clientPeer.create_client(ipInput.text,portInput.text.to_int())
	multiplayer.multiplayer_peer = clientPeer
	
@rpc("any_peer")
func playerInfo(playerName, id):
	if !GameManager.Players.has(id):
		GameManager.Players[id] = {
			"name: ": playerName,
			"id: ": id
		}
	if multiplayer.is_server():
		for i in GameManager.Players:
			print(GameManager.Players)
			playerInfo.rpc(GameManager.Players[i]["name: "], i)
				
func playerConnected(id):
	print("Player Connected " + str(id))
	
func playerDisconnected(id):
	print("Player Disconnected " + str(id))
	
func serverConnected() -> void:
	print("Connection Successful ")
	playerInfo.rpc_id(1, nameInput.text, multiplayer.get_unique_id())
	
func connectionFailed(id):
	print("Connection Failed " + id)
	
@rpc("any_peer","call_local")
func loadGame() -> void:
	var scene = load("res://scenes/game_area.tscn").instantiate()
	get_tree().root.add_child(scene)
	menuNode.queue_free()
	Hud.show()
	
func _on_start_button_pressed() -> void:
	if !gameLoaded:
		loadGame.rpc()
		gameLoaded = true


func _on_theme_button_pressed() -> void:
	pass # Replace with function body.
