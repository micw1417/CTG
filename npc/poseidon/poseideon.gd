extends RigidBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var insult_word_picker: CanvasLayer = $InsultWordPicker



var startLines: Array[String] = [
	"Welcome to my temple",
	"I need you to... help make an apology",
	"Hermes told you you could help pick some words",
	"Talk to me again when you finish",
]

var afterChosenLines: Array[String] = [
	"Good... Now do me a small favor",
	"Walk up and present this insult to zeus"
]
func _process(delta: float) -> void:
	pass

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	sprite.play("idle")
	insult_word_picker.visible = false

func _on_interact():
	if insult_word_picker.visible == true:
		return
	
	DialogManager.start_dialog(global_position, get_lines())
	await DialogManager.dialog_finished
	insult_word_picker.visible = true
	if (StateManager.chooeseInsult != true):
		insult_word_picker.visible = true


func _on_exit_button_pressed() -> void:
	insult_word_picker.visible = false
	StateManager.chooeseInsult = true
	
func get_lines() -> Array[String]:
	if StateManager.chooeseInsult == true:
		return afterChosenLines
	return startLines
