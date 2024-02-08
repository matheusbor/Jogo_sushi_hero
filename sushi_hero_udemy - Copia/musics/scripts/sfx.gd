extends AudioStreamPlayer3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play()

func _on_sfx_finished():
	queue_free()

func _on_finished() -> void:
	return
