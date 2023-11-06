extends InterectabeObject
class_name Oven

@export_category("Variables")
@export var _rotation:float = -PI/2
@export var _position: Vector3 = Vector3( 11.5, 0.091, -0.10)

func _interact() -> void:
	_character_ref.change_position(_position, _rotation)
	get_tree().call_group("oven_container", "display", self, true)	
