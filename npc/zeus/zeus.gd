extends RigidBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite: AnimatedSprite2D = $Sprite

@onready var noun_options: OptionButton = $Poseidon/InsultWordPicker/Control/Panel/MarginContainer/VBoxContainer/HBoxContainer/NounOptions
@onready var title_options: OptionButton = $Poseidon/InsultWordPicker/Control/Panel/MarginContainer/VBoxContainer/HBoxContainer/TitleOptions
@onready var verb_options: OptionButton = $Poseidon/InsultWordPicker/Control/Panel/MarginContainer/VBoxContainer/HBoxContainer2/VerbOptions



var startLines: Array[String] = [
	"What is it you want??",
	"(Try talking to Poseidon)",
]



func _process(delta: float) -> void:
	pass
	

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	sprite.play("idle")
	

func _on_interact():
	DialogManager.start_dialog(global_position, get_lines())


	
func get_lines() -> Array[String]:
	if StateManager.chooeseInsult == true:
		var afterChosenLines: Array[String] = [
			"Oh you have to present something?",
			"... WHAT DID YOU JUST SAY TO ME!!",
			"(The apology was... " + noun_options.get_item_text(noun_options.selected),  
		]
		return afterChosenLines
	return startLines
