extends Node3D

const _CLIENTS: Array = [
	preload("res://character/scenes/clients/panda.tscn"),
	#preload("res://character/scenes/clients/rabbit_bald.tscn"),
	#preload("res://character/scenes/clients/rabbit_blond.tscn") 
]

@export var _spawn_timer: Timer = null

func _ready () -> void:
	_spawn_client()
	_spawn_timer.start()
	
func _spawn_client () -> void:
	var _client = _CLIENTS[randi() % _CLIENTS.size()].instantiate()
	add_child(_client)

func _on_spawn_timeout() -> void:
	_spawn_client()
	_spawn_timer.start()
