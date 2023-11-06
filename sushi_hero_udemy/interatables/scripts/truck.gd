extends InterectabeObject

func _interact() ->void :
	get_tree().call_group("_container", "display", self, true)		

func _on_detection_body_entered(_body) -> void:
	if _body is character:
		_body.current_entity = self
		if _body.can_interact:
			can_interact(true, _body)
	


func _on_detection_body_exited(_body) -> void:
	if _body is character:
		_body.freeze(false)
		can_interact(false)
		_body.current_entity = null
