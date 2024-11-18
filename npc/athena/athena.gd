extends RigidBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite: AnimatedSprite2D = $Sprite



var lines: Array[String] = [
	"To gain Wisdon's favor...",
	"find my owl",
	"Explore this maze...",
	"Go Venture forth!"
]
func _process(delta: float) -> void:
	pass

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	#sprite.play("idle")
func _on_interact():
	DialogManager.start_dialog(global_position, lines)
	
