extends InterfaceContainer
class_name ChoppingContainer

func _on_chop__button_pressed():
	var _prepared_ingredients: Dictionary = {}
	for _children in _interactable_container.get_children():
		var _item: Dictionary = _children.get_alt_item()
		if not _item.has("prepared_ingredient"):
			_prepared_ingredients["null"] = 1
			continue #return
		
		var _prepared: Dictionary = _item["prepared_ingredient"]
		for _ingredient in _prepared:
			if not _prepared_ingredients.has(_ingredient):
				_prepared_ingredients[_ingredient] = {
					"item_amount": 1 * _item["item_amount"],
					"item_name": _ingredient,
					"item_texture": _prepared[_ingredient]["item_texture"]
				}
				continue
			_prepared_ingredients[_ingredient]["item_amount"] += 1 * _item["item_amount"]
			
	if _prepared_ingredients.size() == 1 and not _prepared_ingredients.has("null"): #!!!!
		var _items: Array = []
		for _children in _interactable_container.get_children():
			for _amount in _children.get_alt_item()["item_amount"]:
				_items.append(_children.get_item()["item_name"])
				update_interactable("update", _children.get_item(), "decrease")
				
		var _ingredient: String = _prepared_ingredients.keys()[0]
		globals.character.chop(_ingredient, _prepared_ingredients[_ingredient]["item_amount"])
		_interactable.chop(_items)
		_close()
		
func _change_current_container() -> void:
	globals.current_container = "chopping"
