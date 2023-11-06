extends InterectabeObject
class_name Fridge

func _interact()->void:
	get_tree().call_group("fridge_container", "display", self, true)
