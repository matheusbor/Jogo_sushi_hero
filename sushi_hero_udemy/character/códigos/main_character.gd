extends CharacterBody3D
class_name character

const _myf = preload("res://../character/códigos/character_body.gd")

const _normal_speed: float = 5.0
const _sprint_speed: float = 9.0

var _current_speed: float 

@export_category("Objects")
@export var _body: Node3D = null
@export var _spring_arm_offset: Node3D = null

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	
func _physics_process(_delta: float) -> void:
	_move()
	move_and_slide()
	#_body.animate(velocity)

func _move() -> void:
	var _input_direction: Vector2 = Input.get_vector(
		"move_left", "move_right",
		"move_foward", "move_backward" 
		)
	var _direction: Vector3 = transform.basis * Vector3(
		_input_direction.x, 
		0,
		_input_direction.y
		).normalized()
	
	is_running()#definir ela dentro da _move() para ela só executar enquanto o personagem se mover
	_direction = _direction.rotated(Vector3.UP, _spring_arm_offset.rotation.y)#é o objeto deste código
	
	if _direction:
		velocity.x = _direction.x * _current_speed
		velocity.z = _direction.z * _current_speed
#		_body.apply_rotation(velocity)
		return
	velocity.x = move_toward(velocity.x, 0 , _current_speed)
	velocity.z = move_toward(velocity.z, 0 , _current_speed)
	
	
func is_running() -> bool:
	if Input.is_action_pressed("shift"):
		_current_speed = _sprint_speed
		return true 
	
	_current_speed = _normal_speed
	return false
	
