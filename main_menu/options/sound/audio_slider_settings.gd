extends Control

@onready var audio_name: Label = $HBoxContainer/AudioName
@onready var h_slider: HSlider = $HBoxContainer/HSlider
@onready var audio_value: Label = $HBoxContainer/AudioValue

@export_enum("Master", "Music", "SFX") var bus_name : String

var bus_index : int = 0

func _ready() -> void:
	set_name_label_text()
	get_bus_name_by_index()
	set_slider_value()
	

func set_name_label_text() -> void:
	audio_name.text = str(bus_name) + " Volume"

func set_audio_num_label_text() -> void:
	audio_value.text = str(h_slider.value * 100) + "%"
	
func get_bus_name_by_index() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	
	
func set_slider_value() -> void:
	h_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	set_audio_num_label_text()

func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	set_audio_num_label_text()
