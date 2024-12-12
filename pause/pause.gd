# PauseMenu.gd
extends CanvasLayer

@onready var root_control: Control = $Control
@onready var margin_container: MarginContainer = $Control/MarginContainer
@onready var options_menu: OptionsMenu = $Control/OptionsMenu

func _ready():
	# Set process mode to always process even when paused
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	hide()
	options_menu.hide()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed('pause'):
		toggle_paused()

func toggle_paused():
	if visible:
		hide()
		margin_container.visible = true
		options_menu.visible = false
		options_menu.set_process(false)
		get_tree().paused = false
	else:
		show()
		get_tree().paused = true
func reset_menus():
	margin_container.visible = true
	options_menu.visible = false
	options_menu.set_process(false)

func _on_start_button_pressed() -> void:
	print("IHIIHIH")
	toggle_paused()

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")

func _on_option_button_pressed() -> void:
	margin_container.visible = false
	options_menu.visible = true
	options_menu.set_process(true)

func _on_exit_options_menu() -> void:
	margin_container.visible = true
	options_menu.visible = false
	options_menu.set_process(false)
