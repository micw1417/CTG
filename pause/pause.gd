extends Control

@onready var margin_container: MarginContainer = $MarginContainer
@onready var options_menu: OptionsMenu = $OptionsMenu

var paused = false

func _ready():
	self.visible = false
	options_menu.visible = false

func _input(event):
	if event.is_action_pressed("pause"):
		toggle_pause()

func get_active_camera() -> Camera2D:
	# Get the currently active camera from the viewport
	var camera = get_viewport().get_camera_2d()
	# Check if the active camera is of type Camera2D
	if camera and camera is Camera2D:
		return camera

	return null


func toggle_pause():
	paused = !paused
	get_tree().paused = paused
	self.visible = paused

	if paused:
		update_pause_menu_position()


func update_pause_menu_position():
	var camera = get_active_camera()
	if camera:
		
		self.size = camera.get_viewport_rect().size
		self.rect_position	 = camera.global_position - (self.size / 2)
	else:
		print("No active camera found.")


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game/overworld.tscn")

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")

func _on_option_button_pressed() -> void:
	margin_container.visible = false
	options_menu.visible = true
	options_menu.set_process(true)
	print("Options menu opened.")

func _on_exit_options_menu() -> void:
	margin_container.visible = true
	options_menu.visible = false
	print("Exited options menu.")
