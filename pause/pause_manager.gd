# PauseManager.gd
extends Node

var pause_scene: PackedScene = preload("res://pause/pause.tscn")
var current_pause_menu: CanvasLayer = null
var is_paused: bool = false

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	add_pause_menu()

func is_menu_valid() -> bool:
	return current_pause_menu != null and is_instance_valid(current_pause_menu) and !current_pause_menu.is_queued_for_deletion()

func add_pause_menu():
	if is_menu_valid():
		current_pause_menu.queue_free()
	
	# Instance the new pause menu
	current_pause_menu = pause_scene.instantiate()
	
	# Add directly to root as CanvasLayer is scene-independent
	get_tree().root.add_child(current_pause_menu)
	current_pause_menu.hide()

func _input(event):
	if event.is_action_pressed("pause"):
		toggle_pause()

func toggle_pause():
	if !is_menu_valid():
		add_pause_menu()
		if !is_menu_valid():
			push_error("Failed to create pause menu!")
			return
	
	is_paused = !is_paused
	get_tree().paused = is_paused
	
	if is_paused:
		current_pause_menu.show()
	else:
		current_pause_menu.hide()

# Optional: Add this to stop music when paused
func _on_pause_state_changed():
	var audio_nodes = get_tree().get_nodes_in_group("music")
	for audio in audio_nodes:
		if audio.has_method("set_stream_paused"):
			audio.set_stream_paused(is_paused)
