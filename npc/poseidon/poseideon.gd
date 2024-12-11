extends RigidBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var insult_word_picker: CanvasLayer = $InsultWordPicker
@onready var dude: CharacterBody2D = $"../Dude"



var startLines: Array[String] = [
	"Hello traveler.",
	"I need you to... help make an apology",
	"Hermes told me you could help make it",
	"Talk to me again when you finish",
]

var afterChosenLines: Array[String] = [
	"Good... Now do me a small favor",
	"Walk up and present this... apology to zeus"
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
	if (StateManager.chooeseInsult != true):
		insult_word_picker.visible = true
		StateManager.isInWordPicker = true
		dude.process_mode = Node.PROCESS_MODE_DISABLED


func _on_exit_button_pressed() -> void:
	insult_word_picker.visible = false
	StateManager.chooeseInsult = true
	dude.process_mode = Node.PROCESS_MODE_INHERIT
	StateManager.isInWordPicker = false
	
func get_lines() -> Array[String]:
	if StateManager.chooeseInsult == true:
		return afterChosenLines
	return startLines
