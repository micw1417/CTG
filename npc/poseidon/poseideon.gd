extends RigidBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var insult_word_picker: CanvasLayer = $InsultWordPicker



var lines: Array[String] = [
	"Welcome to my temple",
	"I need you to... help make an apology",
	"Hermes told you you could help pick some words"
	
]
func _process(delta: float) -> void:
	pass

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	#sprite.play("idle")
	insult_word_picker.visible = false

func _on_interact():
	DialogManager.start_dialog(global_position, lines)
	await DialogManager.dialog_finished
	insult_word_picker.visible = true;
	DialogManager.is_dialog_active = true;
	


func _on_exit_button_pressed() -> void:
	insult_word_picker.visible = false;
	DialogManager.is_dialog_active = false;
