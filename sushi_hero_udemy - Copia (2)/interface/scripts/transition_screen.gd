extends CanvasLayer
class_name TransitionScreen

@export_category("Objects")
@export var _animation: AnimationPlayer = null

func fade_in() ->void:
	_animation.play("fade_in")

	
func _on_animation_player_animation_finished(_anim_name: String) -> void:
	if _anim_name  == "fade_in":
		get_tree().reload_current_scene()
		_animation.play("fade_out")
		
	
