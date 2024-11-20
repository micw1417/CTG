extends RigidBody2D
var speed = 100 
const PUSH_FORCE = 15.0 
const MIN_PUSH_FORCE = 10.0 # speed in pixels/sec 

@onready var animated_sprite_2d: AnimatedSprite2D = $Sprite 
func _physics_process(delta): 
	var direction = Vector2.UP 
	
	
