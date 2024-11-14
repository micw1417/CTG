extends Control


@onready var option_button: OptionButton = $HBoxContainer/OptionButton


const RESOLUTION_DICTIONARY : Dictionary = {
	"1920 x 1080" 	: Vector2i(1920, 1080),
	"1280 x 720" 	: Vector2i(1280, 720),
	"1366 x 768" 	: Vector2i(1366, 768),
	"2560 x 1440" 	: Vector2i(2560, 1440),
	"3840 x 2160" 	: Vector2i(3840, 2160)
}
var DISPLAY_RESOLUTION_VALUES: Array = RESOLUTION_DICTIONARY.values()

func _ready() -> void:
	add_resolution_items()
	select_current_display_resolution()

func add_resolution_items() -> void:
	for resolution_size_text in RESOLUTION_DICTIONARY:
		option_button.add_item(resolution_size_text)
	

func on_resolution_selected(index: int) -> void:
	DisplayServer.window_set_size(RESOLUTION_DICTIONARY.values()[index])
	centre_window()


func centre_window():
	var centre_screen = DisplayServer.screen_get_position() + DisplayServer.screen_get_size()/2
	var window_size = get_window().get_size_with_decorations()
	get_window().set_position(centre_screen - window_size/2)

func select_current_display_resolution():
	var current_resolution = DisplayServer.window_get_size()
	var index = DISPLAY_RESOLUTION_VALUES.find(current_resolution)
	option_button.select(index)
