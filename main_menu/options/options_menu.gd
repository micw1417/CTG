extends Control
class_name OptionsMenu
@onready var exit_button: Button = $MarginContainer/VBoxContainer/ExitButton

signal exit_options_menu

func _ready() -> void:
	set_process(false)


func _on_exit_button_pressed() -> void:
	exit_options_menu.emit()
