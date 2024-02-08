extends ColorRect
class_name FPS

@export_category("Objects")
@export var _fps: Label = null

func _physics_process(_delta: float) -> void:
	_fps.text = str(Engine.get_frames_per_second()) + " FPS"


