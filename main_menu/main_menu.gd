extends Control
@onready var margin_container: MarginContainer = $MarginContainer
@onready var options_menu: OptionsMenu = $OptionsMenu


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main_startingmap/overworld.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_option_button_pressed() -> void:
	margin_container.visible = false
	options_menu.visible = true
	options_menu.set_process(true)

func _on_exit_options_menu() -> void:
	margin_container.visible = true
	options_menu.visible = false
