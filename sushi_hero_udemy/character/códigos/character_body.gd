extends Node3D
class_name body

@export_category("Objects")
@export var _character: CharacterBody3D = null
@export var animation: AnimationPlayer = null


const _lerp_velocity: float = 0.15

func apply_rotation(_velocity: Vector3) -> void:
	rotation.y = lerp_angle(rotation.y, atan2(-_velocity.x, -_velocity.z), _lerp_velocity)

func animate(_velocity: Vector3) -> void:
	if _velocity:
		if _character.is_running():
			animation.play("Run") 
			return
		animation.play("Walk")
		return
	animation.play("Idle")
