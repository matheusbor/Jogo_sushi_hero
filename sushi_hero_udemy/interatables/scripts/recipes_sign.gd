extends InterectabeObject
class_name RecipesSign


func _interact()->void:#pra interface	
	get_tree().call_group("recipes", "display", self, true)
