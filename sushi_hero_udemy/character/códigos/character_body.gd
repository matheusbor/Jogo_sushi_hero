extends Node3D
class_name body

@export_category("Objects")
@export var _character: CharacterBody3D = null
@export var animation: AnimationPlayer = null
@export var _cooking_timer: Timer = null
@export var _chopping_timer: Timer = null
const _lerp_velocity: float = 0.15
var is_cooking: bool = false
var is_chopping: bool = false
var is_enabled: bool = false

func apply_rotation(_velocity: Vector3) -> void:
	rotation.y = lerp_angle(rotation.y, atan2(-_velocity.x, -_velocity.z), _lerp_velocity)

func animate(_velocity: Vector3) -> void:
	if on_action():
		return
	if _velocity:
		if _character.is_running():
			animation.play("Run") 
			return
		animation.play("Walk")
		return
	animation.play("Idle")

func on_action() -> bool:
	if is_cooking and not is_enabled:
		animation.play("Pan_Start")
		is_enabled = true
		return true
		
	if is_chopping and not is_enabled:
		animation.play("Chop_Start")
		is_enabled = true
		return true
		
		
	if is_cooking or is_chopping:
		return true
	return false
	

func _on_animation_finished(anim_name: String) -> void:
	match anim_name:
		"Pan_Start":
			_cooking_timer.start()
			animation.play("Pan")
		"Chop_Start":
			_chopping_timer.start()
			animation.play("Chop")
		"Pan_end":
			is_enabled = false
			_character.on_cook_finished()
	


func _on_cooking_timer_timeout() -> void:
	animation.play('Pan_end')
	pass # Replace with function body.


func _on_chopping_timer_timeout():
	pass # Replace with function body.
