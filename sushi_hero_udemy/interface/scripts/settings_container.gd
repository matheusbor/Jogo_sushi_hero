extends ColorRect
class_name SettingsContainer

var _world_environment: WorldEnvironment = null

@export_category("Objects")
@export var _fps: ColorRect = null
#Invalid set index 'visible' (on base: 'Nil') with value of type 'bool'.

func _ready() -> void:
	_world_environment = get_tree().get_nodes_in_group("environment")[0]#os grupos tem nomes específicos
	for button in get_tree().get_nodes_in_group("options_button"):
		if button is CheckBox:
			button.pressed.connect(_on_button_pressed.bind(button))
		if button is OptionButton:
			button.item_selected.connect(_on_button_selected.bind(button))

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"): # o exc
		visible = not visible
		get_tree().paused = not get_tree().paused #isso vai inverter sempre o valor
		if visible:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			return
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_button_pressed(button: CheckBox)-> void:
	var _parent: HBoxContainer = button.get_parent().get_parent()
	var _text: String = _parent.name.to_snake_case()
	
	match _text:
		"display_fps": #fica tudo minusculo mesmo que o nome original seja maiusculo
			_fps.visible = button.button_pressed
		"taa":
			get_viewport().use_taa = button.button_pressed
		"ssr":
			_world_environment.environment.ssr_enabled = button.button_pressed
		"ssao":
			_world_environment.environment.ssao_enabled = button.button_pressed
		"ssil":
			_world_environment.environment.ssil_enabled = button.button_pressed
		"sdfgi":
			_world_environment.environment.sdfgi_enabled = button.button_pressed
			
	button.release_focus()
	
	
	
func _on_button_selected(button_index: int, button: OptionButton) -> void:
	var _parent: HBoxContainer = button.get_parent().get_parent()
	var _text: String = _parent.name.to_snake_case()
	
	match _text:
		"screen_space_aa":
			_update_screen_space_aa(button_index)
		"msaa_3d":
			_update_msaa_3d(button_index)
	button.release_focus()
	
func _update_msaa_3d(index: int) -> void:
	var viewport: Viewport = get_viewport()
	
	match index:
		0:
			viewport.msaa_3d = Viewport.MSAA_DISABLED
		1:
			viewport.msaa_3d = Viewport.MSAA_2X
		2:
			viewport.msaa_3d = Viewport.MSAA_4X
		3:
			viewport.msaa_3d = Viewport.MSAA_8X
		
func _update_screen_space_aa(index: int) -> void:
	var viewport: Viewport = get_viewport()
	
	match index:
		0:
			viewport.screen_space_aa = Viewport.SCREEN_SPACE_AA_DISABLED
		1:
			viewport.screen_space_aa = Viewport.SCREEN_SPACE_AA_FXAA
