# PauseMenu.gd
extends CanvasLayer

@onready var root_control: Control = $Control
@onready var margin_container: MarginContainer = $Control/MarginContainer
@onready var options_menu: OptionsMenu = $Control/OptionsMenu
@onready var pause_menu = $Control/MarginContainer/PauseMenu

func _ready():
	# Set process mode to always process even when paused
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	# Initial setup
	setup_ui()
	hide()  # Hide the entire CanvasLayer initially
	options_menu.hide()
	
	# Connect to viewport size changes
	get_tree().root.connect("size_changed", setup_ui)

func setup_ui():
	# Setup root control to fill viewport
	root_control.anchor_right = 1
	root_control.anchor_bottom = 1
	root_control.offset_left = 0
	root_control.offset_top = 0
	root_control.offset_right = 0
	root_control.offset_bottom = 0
	
	# Setup margin container
	margin_container.anchor_right = 1
	margin_container.anchor_bottom = 1
	margin_container.offset_left = 0
	margin_container.offset_top = 0
	margin_container.offset_right = 0
	margin_container.offset_bottom = 0


#func show():
	#visible = true
	#margin_container.visible = true
#
#func hide():
	#visible = false

func reset_menus():
	margin_container.visible = true
	options_menu.visible = false
	options_menu.set_process(false)

func _on_start_button_pressed() -> void:
	#PauseManager.toggle_pause()
	pass

func _on_main_menu_pressed() -> void:
	#PauseManager.toggle_pause()
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")

func _on_option_button_pressed() -> void:
	margin_container.visible = false
	options_menu.visible = true
	options_menu.set_process(true)

func _on_exit_options_menu() -> void:
	margin_container.visible = true
	options_menu.visible = false
	options_menu.set_process(false)
