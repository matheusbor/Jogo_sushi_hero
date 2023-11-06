extends InterfaceContainer

class_name OvenContainer


func _on_cook_button_pressed():
	var _ingredients: Dictionary = {}
	for _children in _interactable_container.get_children():
		var _item: Dictionary = _children.get_alt_item()
		_ingredients[_item["item_name"]]= {
			"name": _item["item_name"],
			"amount": _item["item_amount"]
		}
		var _recipes: Dictionary = {}
		for _recipe in recipes.recipes_dict:
			for _ingredient in recipes.recipes_dict[_recipe]["ingredients"]:
				if not _recipes.has(_recipe):
					_recipes[_recipe] = {}
				
				_recipes[_recipe][_ingredient] ={ 
					"name": _ingredient, 
					"amount": recipes.recipes_dict[_recipe]["ingredients"][_ingredients]["amount"]
				}
				
			for _r in _recipes:
				if _recipes[_r] == _ingredients:
					for _childrenn in _interactable_container.get_children():
						var _amount: int = _childrenn.get_alt_item()["item_amount"]
						for i in _amount:
							update_interactable("update", _childrenn.get_item(), "decrease")
					#globals.character.cook(_r)
					_close()
					return
					
func change_current_container() -> void:
	globals.current_container = "oven"
					
				
