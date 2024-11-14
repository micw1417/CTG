extends RigidBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite: AnimatedSprite2D = $Sprite

var lines: Array[String] = [
	"Congratulations",
]
func _process(delta: float) -> void:
	pass

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	sprite.play("idle")
func _on_interact():
	DialogManager.start_dialog(global_position, lines)
	await DialogManager.dialog_finished
	get_tree().change_scene_to_file("res://game/overworld.tscn")
