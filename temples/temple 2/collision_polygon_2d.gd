extends CollisionPolygon2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(self.get)


#func _on_child_exiting_tree(node: Node) -> void:
	##get_tree().change_scene_to_file("res://temples/temple1.tscn")
	#print("worked")
