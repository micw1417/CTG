extends CharacterBody2D
var speed = 100 
const PUSH_FORCE = 15.0 
const MIN_PUSH_FORCE = 10.0 # speed in pixels/sec 

@onready var animated_sprite_2d: AnimatedSprite2D = $Sprite 
func _physics_process(delta): 
	var direction = Vector2.UP 
	##rotation += 1 * delta 
	if Input.is_action_pressed("interact"): 
		direction *= speed 
		move_and_slide()
		for i in get_slide_collision_count():
			var c = get_slide_collision(i)
			if c.get_collider() is RigidBody2D:
				var push_force = (PUSH_FORCE * velocity.length() / speed) + MIN_PUSH_FORCE
				c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
