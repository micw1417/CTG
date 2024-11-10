class_name  HotkeyRebindButton
extends Control

@onready var label: Label = $HBoxContainer/Label
@onready var button: Button = $HBoxContainer/Button

@export var action_name : String = "left"


func _ready() -> void:
	set_process_unhandled_key_input(false)
	set_action_name()
	set_text_for_key()
	
func set_action_name() -> void:
	label.text = action_name
	
	match action_name:
		"left":
			label.text = "Move Left"
		"right":
			label.text = "Move Right"
		"up":
			label.text = "Move Up"
		"down":
			label.text = "Move Down"
		"interact":
			label.text = "Interact"
		"advance_dialog":
			label.text = "Advance Dialog"

func set_text_for_key() -> void:
	var action_events = InputMap.action_get_events(action_name)
	var action_event = action_events[0]
	var action_keycode = OS.get_keycode_string(action_event.physical_keycode)
	
	button.text = "%s" % action_keycode


func _on_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		button.text = "Press any key..."
		set_process_unhandled_key_input(toggled_on)
		
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = false
				i.set_process_unhandled_input(false)
	else:
		for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = true
				i.set_process_unhandled_input(false)
				
		
		set_text_for_key() 
		
func _unhandled_key_input(event: InputEvent) -> void:
	rebind_action_key(event)
	button.button_pressed = false


func rebind_action_key(event):
	print("WAT")
	var is_duplicate = false
	var action_event = event
	var action_keycode = OS.get_keycode_string(action_event.physical_keycode)

	for i in get_tree().get_nodes_in_group("hotkey_button"):
			if i.action_name != self.action_name:
				if i.button.text == "%s" % action_keycode:
					is_duplicate = true
					self.button.text = "'" + action_keycode + "' already bound"
					await get_tree().create_timer(2.0).timeout
					set_process_unhandled_key_input(false)
					set_text_for_key()
					break

	if not is_duplicate:
		InputMap.action_erase_events(action_name)
		InputMap.action_add_event(action_name,event)
		set_process_unhandled_key_input(false)
		set_text_for_key()
		set_action_name()
