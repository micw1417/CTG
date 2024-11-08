extends StaticBody2D


@onready var sprite: AnimatedSprite2D = $Sprite
@onready var interaction_area: InteractionArea = $InteractionArea

var open = false

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	print(global_position)

func _on_interact():
	if open:
		sprite.play("close")
		open = !open
		interaction_area.action_name = "open"
	else:
		sprite.play("open")
		open = !open
		interaction_area.action_name = "close"
