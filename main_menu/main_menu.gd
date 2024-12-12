extends Control
@onready var margin_container: MarginContainer = $MarginContainer
@onready var options_menu: OptionsMenu = $OptionsMenu
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label_2: Label = $AnimationPlayer/Node/Label2
@onready var label_3: Label = $AnimationPlayer/Node/Label3
@onready var label_4: Label = $AnimationPlayer/Node/Label4
@onready var background_music: AudioStreamPlayer = $BackgroundMusic


func _on_start_button_pressed() -> void:
	animation_player.play("epic_cutscene")
	await  animation_player.animation_finished
	background_music.stop()
	get_tree().change_scene_to_file("res://game/overworld.tscn")

func _ready() -> void:
	StateManager.diedUpsidedown = false;
	label_2.visible = false;
	label_3.visible = false;
	label_4.visible = false;
	
func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_option_button_pressed() -> void:
	margin_container.visible = false
	options_menu.visible = true
	options_menu.set_process(true)

func _on_exit_options_menu() -> void:
	margin_container.visible = true
	options_menu.visible = false
