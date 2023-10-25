extends Node3D

class_name SpringArmCharacter

const _mouse_sensibility:float  = 0.003

@export_category("Objects")
@export var _spring_arm: SpringArm3D = null#vincular ao braço

func _unhandled_input(_event) -> void:
	if _event is InputEventMouseMotion: #se for um movimento do mouse
		rotate_y(-_event.relative.x * _mouse_sensibility)#por que o x pega o y e o y pega o x
		_spring_arm.rotate_x(-_event.relative.y * _mouse_sensibility) #usamos o objeto que guardamos referência para acessar o objeto real?
		_spring_arm.rotation.x = clamp(_spring_arm.rotation.x, -PI/4, PI/24)
	
