extends Node3D

const _lerp_velocity: float = 0.15

var is_upset: bool = false
var is_eating: bool = false

@export_category("Objects")
@export var _client: CharacterBody3D = null
@export var _animation: AnimationPlayer = null

func apply_rotation(_velocity: Vector3) -> void:
	rotation.y = lerp_angle(rotation.y, 
	atan2(-_velocity.x, -_velocity.z), 
	_lerp_velocity)
	
func _ready() ->void:
	initialize()
	
func initialize() -> void:
	_animation.connect("animation_finished", Callable(self, "_on_animation_finished"))
	
func animate(_velocity: Vector3) -> void:
	if _velocity:
		_animation.play("Walk")
		return
	_animation.play("Idle")
	
func animation_action(_action: String, _rotation:float = PI) -> void:
	rotation.y = _rotation
	_animation.play(_action)
	
	if _action == "Sitting_Eating":
		is_eating = true
		globals.spawn_sfx("res://musics/sfx/assets/eat.mp3", self)
	
func _on_animation_finished(_anim_name: String) -> void:
	match _anim_name:
		"Sitting_Start":
			if _client.on_table:
				recipes.order_random_food(_client)
			_animation.play("Sitting_Idle")
		
		"Sitting_End":
			if is_eating:
				_client.update_state("go_away", Vector3.ZERO, Vector3(0,0, -45))
				is_eating = false
				_client.on_table = false
				return
				
			if not is_eating and is_upset:
				_client.update_state("go_away", Vector3.ZERO, Vector3(0, 0, -45))
				return
				
			if _client.on_sofa:
				_client.on_sofa = false
				_client.update_state("seek_table")
				


func _on_eating_timeout() ->void:
	_animation.play("Sitting_End")
