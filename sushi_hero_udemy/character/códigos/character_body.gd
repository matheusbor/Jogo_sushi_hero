extends Node3D
class_name body


const _lerp_velocity:float = 0.15

func apply_rotation(_velocity: Vector3) -> void:
	rotation.y = lerp(rotation.y, atan2(-_velocity.x, -_velocity.z), _lerp_velocity)

