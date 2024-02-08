extends CharacterBody3D
class_name character

const _myf = preload("res://../character/códigos/character_body.gd")

const _normal_speed: float = 5.0
const _sprint_speed: float = 9.0

var is_freezed: bool = false
var can_interact: bool = true
var _current_speed: float 
var current_entity = null
var _last_food: String = ""
var _last_prepared_ingredient_amount: int = 0
var _last_prepared_ingredient: String = ""

@export_category("Variables")
@export var gold: int = 0

@export_category("Objects")
@export var _body: Node3D = null
@export var _spring_arm_offset: Node3D = null
@export var _item_feedback: MeshInstance3D = null
@export var _inventory: Node = null

func _ready() -> void:
	globals.character = self
	recipes.character_ref = self
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().call_group("enviroment", "update_gold", gold)
	
	
func _physics_process(_delta: float) -> void:
	if is_freezed:
		return
	_move()
	move_and_slide()
	_body.animate(velocity)

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
		_body.apply_rotation(velocity)
		return
	velocity.x = move_toward(velocity.x, 0 , _current_speed)
	velocity.z = move_toward(velocity.z, 0 , _current_speed)
	
	
func is_running() -> bool:
	if Input.is_action_pressed("shift"):
		_current_speed = _sprint_speed
		return true 
	
	_current_speed = _normal_speed
	return false
	
func freeze(_state: bool) -> void:
	_body.animation.play("Idle")
	if _state:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if not _state:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
	_spring_arm_offset.can_rotate = not _state 
	is_freezed = _state
	
func change_position(_position: Vector3, _rotation: float)-> void:
	global_position = _position
	_body.rotation.y = _rotation	

func chop(_prepared_ingredient: String, _amount: int) -> void:
	can_interact = false
	_last_prepared_ingredient_amount = _amount
	_last_prepared_ingredient = _prepared_ingredient
	
	_item_feedback.get_node("FrontTexture").texture = load(
		ingredients.ingredients_dict[_prepared_ingredient]["item_texture"])
	_item_feedback.get_node("BackTexture").texture = load(
	ingredients.ingredients_dict[_prepared_ingredient]["item_texture"])
	
	_body.is_chopping = true 
	_body.animate(velocity)
	set_physics_process(false)
	_spring_arm_offset.can_rotate = true
	_body.get_node("body/Skeleton3D/Knife").show()
	
func on_chop_finished () -> void:
	freeze(false)
	_body.is_chopping = false
	set_physics_process(true)
	_body.get_node("body/Skeleton3D/Knife").hide()
	_item_feedback.get_node("AnimationPlayer").play("show_ingredient")
	globals.spawn_sfx("res://musics/sfx/assets/interactable_pop.mp3", self)

	
func cook(_food : String) -> void:
	_last_food = _food
	can_interact = false
	
	_item_feedback.get_node("FrontTexture").texture = load(
		recipes.recipes_dict[_food]["item_texture"])#!!!
	_item_feedback.get_node("BackTexture").texture = load(
	recipes.recipes_dict[_food]["item_texture"])#!!!!!!!!!!!!!!!!!
		
	_body.is_cooking = true
	_body.animate(velocity)
	set_physics_process(false)
	_spring_arm_offset.can_rotate = true
	_body.get_node("body/Skeleton3D/Pan").show()
	
func on_cook_finished() ->void:
	freeze(false)
	_body.is_cooking = false
	set_physics_process(true)
	_body.get_node("body/Skeleton3D/Pan").hide()
	_item_feedback.get_node("AnimationPlayer").play("show")
	globals.spawn_sfx("res://musics/sfx/assets/interactable_pop.mp3", self)



func _on_item_feedback_finished(_anim_name: String) -> void:
	match _anim_name:
		"show":
			var _item: Dictionary = {}
			_item[_last_food] = {
				"item_amount" :  1,
				"item_name" : _last_food,
				"item_texture": recipes.recipes_dict[_last_food]["item_texture"],
				"price":  recipes.recipes_dict[_last_food]["price"]
			}
			
			_inventory.add_item(_item[_last_food])
		"show_ingredient":
			for i in _last_prepared_ingredient_amount:
				var _item: Dictionary = {}
				_item[_last_prepared_ingredient] = {
					"item_amount": 1,
					"item_name": _last_prepared_ingredient,
					"item_texture": ingredients.ingredients_dict[
						_last_prepared_ingredient
					]["item_texture"]
				}
				
				_inventory.add_item(_item[_last_prepared_ingredient])
	can_interact = true
	if current_entity != null:
		current_entity.can_interact(true, self)

func update_gold(_value: int, _type: String):
	match _type:
		"increase":
			gold += _value
			
		"decrease":
			gold -= _value
	globals.spawn_sfx("res://musics/sfx/assets/money.mp3", self)
	get_tree().call_group("enviroment", "update_gold", gold)#!!!!!!!!!!!!!!!!!!!


func spawn_chop_sfx() -> void:
	globals.spawn_sfx("res://musics/sfx/assets/chop.mp3", self)



