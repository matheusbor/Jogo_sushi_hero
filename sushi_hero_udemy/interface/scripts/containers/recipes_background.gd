extends ColorRect


const _RECIPE: PackedScene = preload("res://interface/scenes/slots/recipes_slot.tscn")

var _sign_ref = null

@export_category("Objects")
@export var _recipes: VBoxContainer = null

func _ready() -> void:
	for _recipe in recipes.recipes_dict.keys():
		var _recipe_slot  = _RECIPE.instantiate()
		_populate_slot(_recipe, _recipe_slot)
		_recipes.add_child(_recipe_slot)
		
func _populate_slot(_recipe: String, _recipe_slot: VBoxContainer) -> void:
	var _v_container: VBoxContainer = _recipe_slot.get_node("VBoxContainer")
	
	_v_container.get_node("Hcontainer/texture_container/TextureRect").texture = load( 
		recipes.recipes_dict[_recipe]["item_texture"]
		 )

	_v_container.get_node("Hcontainer/texture_container/Label").text = _recipe.capitalize()
	
	var _ingredients_dict: Dictionary = recipes.recipes_dict[_recipe]["ingredients"]
	var _ingredients_keys: Array = _ingredients_dict.keys()
	
	var _ingredients: HBoxContainer = _v_container.get_node("container/HBoxContainer/HBoxContainer")
	
	for _i in _ingredients_dict.size():
		var _ingredients_slot: VBoxContainer = _ingredients.get_child(_i)
		
		var _ingredient_texture: TextureRect = _ingredients_slot.get_node("VBoxContainer/HBoxContainer/TextureRect")
		var _ingredient_name: Label = _ingredients_slot.get_node("VBoxContainer/HBoxContainer/VBoxContainer/ingredient")
		var _ingredient_amount: Label = _ingredients_slot.get_node("VBoxContainer/HBoxContainer/VBoxContainer/amount")
		
		_ingredients_slot.show()
		_ingredient_texture.texture = load(_ingredients_dict[_ingredients_keys[_i]]["item_texture"])
		_ingredient_name.text = _ingredients_keys[_i].capitalize()
		_ingredient_amount.text = str(_ingredients_dict[_ingredients_keys[_i]]["amount"]) + "x"

func _process(_delta: float) -> void:
	if get_tree().paused and not visible:
		return
		
	if Input.is_action_just_pressed("ui_quit") and visible:
		visible = false
		get_tree().paused = false
		_sign_ref.change_state(true)
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
func display(_target, _visibility: bool) -> void:
	_sign_ref = _target
	visible = _visibility
	
		
