extends RigidBody2D


@onready var sprite: AnimatedSprite2D = $Sprite
@onready var interaction_area: InteractionArea = $InteractionArea

var interacted_with = false

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	if interacted_with:
		return
	sprite.play("horizontal")
	interaction_area.queue_free()
	interacted_with = true
