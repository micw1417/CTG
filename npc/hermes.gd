extends RigidBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite: AnimatedSprite2D = $Sprite



var lines: Array[String] = [
	"To stop Zeus and Poseidon from fighting",
	"Help pick some words to calm them down!",
	"Enter the temple and go to the left!"
]
func _process(delta: float) -> void:
	pass

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	#sprite.play("idle")
func _on_interact():
	DialogManager.start_dialog(global_position, lines)
	
