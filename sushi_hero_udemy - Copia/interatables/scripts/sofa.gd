extends MeshInstance3D


var off_set: Vector3 = Vector3(0, 0.25, 0.02)#dar impressao que ele está sentado
var _is_avaiable: bool = true

func change_avaiable_state(state: bool) -> void:
	_is_avaiable = state #vai ficar alternando
	
func is_avaiable(_entity) ->void:
	if _is_avaiable:
		_entity.update_state("walking", off_set, global_position)
		change_avaiable_state(false)
		return
	_entity.update_state("seek_sofa")
	
