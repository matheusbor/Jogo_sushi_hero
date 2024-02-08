extends InteractableObject
class_name Oven

@export_category("Variables")
@export var _rotation: float = -PI/2
@export var _position: Vector3 = Vector3(11.3, +0.770, -5.731)

func _interact() -> void:
	_character_ref.change_position(_position, _rotation)
	get_tree().call_group("oven_container", "display", self, true)
