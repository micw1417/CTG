extends Camera2D

# Define the "base" resolution you want to maintain
var base_resolution = Vector2(1280, 720)

func _ready():
	var screen_size = get_viewport().size
	var scale_factorX = screen_size.x / base_resolution.x
	var scale_factorY = screen_size.y / base_resolution.y
	scale = Vector2(scale_factorX, scale_factorY)
