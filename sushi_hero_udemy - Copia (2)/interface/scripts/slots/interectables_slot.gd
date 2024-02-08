extends BaseSlot

func _on_send_button_pressed():
	get_tree().call_group("character_inventory", "add_item", _item)
	update_item("decrease")
