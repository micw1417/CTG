extends StaticBody2D


@onready var sprite: AnimatedSprite2D = $Sprite
@onready var interaction_area: InteractionArea = $InteractionArea

var open = false

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")

func _on_interact():
	if open:
		sprite.play("close")
		open = !open
		interaction_area.action_name = "open"
		
	else:
		sprite.play("open")
		open = !open
		interaction_area.action_name = "close"
		
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://temples/temple2.tscn")
	

	
