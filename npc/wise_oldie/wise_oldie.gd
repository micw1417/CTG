extends RigidBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite: AnimatedSprite2D = $Sprite



var startLines: Array[String] = [
	"*EHEHEM*",
	"You seem to be a bit lost young lad",
	"If you want to find you way back, follow the left path"
]

var temple1Lines: Array[String] = [
	"finsiehd 1"
]

var temple2Lines: Array[String] = [
	"finished 2"
]

var temple3Lines: Array[String] = [
	"templ45s"
]
func _process(delta: float) -> void:
	pass

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	#sprite.play("idle")
func _on_interact():
	DialogManager.start_dialog(global_position, get_lines())
	await DialogManager.dialog_finished

func get_lines() -> Array[String]:
	if StateManager.finishedTemple3:
		return temple3Lines
	if StateManager.finishedTemple2:
		return temple2Lines
	if StateManager.finishedTemple1:
		return temple1Lines
	return startLines
