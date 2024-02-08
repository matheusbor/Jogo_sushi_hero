extends Area3D


var _is_open: bool = false
var _character_ref: CharacterBody3D = null

@export_category("Objects")

@export var _door_timer: Timer = null
@export var _animation: AnimationPlayer = null



func _on_body_entered(_body) -> void:
	if _body is character:
		_character_ref = _body
		if not _is_open:
			_animation.play("open")


func _on_body_exited(_body) -> void:
	if _body is character:
		_character_ref = null
	
	
	pass # Replace with function body.


func _on_timer_timeout() -> void:
	if _character_ref == null:
		_animation.play("close")
		_is_open = false
		return
	_door_timer.start()
	pass # Replace with function body.


func _on_animation_player_animation_finished(_anim_name: String) -> void:
	if _anim_name == "open":
		_is_open = true
		_door_timer.start()
		
	pass # Replace with function body.

func _spawn_sfx() -> void:
	globals.spawn_sfx("res://musics/sfx/assets/automatic_door.mp3", self)
