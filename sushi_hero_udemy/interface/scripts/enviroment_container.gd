extends ColorRect

var _is_game_finished: bool = false

@export_category("Objects")
@export var _money_label: Label = null
@export var _reputation_label: Label = null

func _ready() -> void:
	update_reputation(50)
	globals.interface = self
	
func update_reputation(_reputation: int) -> void:
	if _is_game_finished:
		return
	if _reputation <= 0 and not _is_game_finished:
		_is_game_finished = true
		globals.reset_reputation()
		
		transition_screen.fade_in()
		
	_reputation_label.text = "Reputation: " + str(_reputation)

func update_gold(_gold: int) -> void:
	_money_label.text = "$ " + str(_gold)
