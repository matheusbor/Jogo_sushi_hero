extends InterfaceContainer

@export_category("Variables")
@export var _amount: int = 20

func _ready() -> void:
	initialize_fridge()
	
func initialize_fridge() -> void:
	var _keys: Array = ingredients.ingredients_dict.keys()
	var _added: bool = false
	for i in _amount:
		var _random_index: int = randi() % _keys.size()
		for children in _interactable_container.get_children():
			var _item: Dictionary = children.get_item()
			if _item["item_name"] == ingredients.ingredients_dict[_keys[_random_index]]["item_name"]:
				update_interactable("update", ingredients.ingredients_dict[_keys[_random_index]])
				_added = true
				break
				
		if _added:
			_added = false
			continue
			
		update_interactable("add", ingredients.ingredients_dict[_keys[_random_index]])
		
func _change_current_container()->void:
	globals.current_container = "fridge"

func _close() -> void:
	globals.spawn_sfx("res://musics/sfx/assets/close_door.mp3", self)
	visible = false
	get_tree().paused = false
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
