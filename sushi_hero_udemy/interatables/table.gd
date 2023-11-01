extends Area3D

const stool: PackedScene = preload("res://furniture/environment/stool.tscn")

var chair_position: Array = [
	Vector3(0, 0, 2),
	Vector3(2, 0, 0),
	Vector3(0, 0, -2),
	Vector3(-2, 0, 0)
]

var chair_offset_position: Array = [
	Vector3(0, 0, 0.4),
	Vector3(0.4, 0, 0),
	Vector3(0, 0, -0.4),
	Vector3(-0.4, 0, 0)
]

var angle_rotation: Array = [
	0,
	PI/2,
	-PI + PI/2,
	PI
]

var off_set: Vector3 = Vector3.ZERO

@export_category("Variables")
@export var _is_avaiable: bool = true
@export var chair_count: int = 1

@export_category("Objects")
@export var _stools: Node3D = null

func _ready()->void:
	for chair in chair_count:
		var new_chair = stool.instantiate()
		new_chair.transform.origin = chair_position[chair]
		_stools.add_child(new_chair)

func is_avaiable(_entity) ->void:
	if not _is_avaiable:
		_entity.update_state("seek_table")
		return
	var _index: int = randi() % _stools.get_child_count()
	var _rotation: float = angle_rotation[_index]
	change_avaiable_state(false)
	
	off_set = chair_position[_index] - chair_offset_position[_index]
	_entity.update_state("walking", off_set, global_position, rotation)
	
func change_avaiable_state(state: bool) -> void:
	_is_avaiable = state
	
