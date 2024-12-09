extends RigidBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite: AnimatedSprite2D = $Sprite

@onready var noun_options: OptionButton = $"../Poseidon/InsultWordPicker/InsultWordControl/Panel/MarginContainer/VBoxContainer/HBoxContainer/NounOptions"
@onready var title_options: OptionButton = $"../Poseidon/InsultWordPicker/InsultWordControl/Panel/MarginContainer/VBoxContainer/HBoxContainer/TitleOptions"
@onready var verb_options: OptionButton = $"../Poseidon/InsultWordPicker/InsultWordControl/Panel/MarginContainer/VBoxContainer/HBoxContainer2/VerbOptions"
@onready var transition_scene: CanvasLayer = $TransitionScene

@onready var animation_player: AnimationPlayer = $AnimationPlayer


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
	await DialogManager.dialog_finished
	
	if StateManager.chooeseInsult == true:
		transition_scene.transition()
		transition_scene.visible = true
		await get_tree().create_timer(1.75).timeout
		transition_scene.visible = false
		animation_player.play('zeus_smite')
		
func get_lines() -> Array[String]:
	if StateManager.chooeseInsult == false:
		return startLines
	
	var noun = noun_options.get_item_text(noun_options.selected)

	if noun == "κόπρος":
		noun = "κόπρος (Scum)"
	elif noun == "κακός":
		noun = "κακός (Evil Person)"
	elif noun == "βλάκας":
		noun = "βλάκας (Idiot)"
	elif noun == "ζώον":
		noun = "ζώον (Animal/Brute)"
	
	var title = title_options.get_item_text(title_options.selected)

	if title == "αμάθης":
		title = "αμάθης (Ignorant)"
	elif title == "βδελυρός":
		title = "βδελυρός (Hideous)"
	elif title == "ματαιόδοξος":
		title = "ματαιόδοξος (Vain)"
	elif title == "ἄσχετος":
		title = "ἄσχετος (Irrelevant/Incompetent)"
		
	var verb = verb_options.get_item_text(verb_options.selected)

	if verb == "βάλλ' εἰς κόρακας":
		verb = "βάλλ' εἰς κόρακας (Go to H*ll)!!"
	elif verb == "ἐξόλοιο":
		verb = 'ἐξόλοιο (Drop dead)!!'
	var afterChosenLines: Array[String] = [
		"Oh you have to present something?",
		"... WHAT DID YOU JUST SAY TO ME!!",
		"YOU... YOU DARE CALL ME A " + title + " " + noun + " THAT SHOULD... " + verb,  
	]
	return afterChosenLines
