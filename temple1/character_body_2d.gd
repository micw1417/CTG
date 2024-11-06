extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


var speed = 100  # speed in pixels/sec

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	if direction.x > 0:
		animated_sprite_2d.play("left")
	if (direction.x < 0):
		animated_sprite_2d.play("right")
	if direction.y > 0:
		animated_sprite_2d.play("down")
	if (direction.y < 0):
		animated_sprite_2d.play("up")
	if velocity == Vector2.ZERO:
		animated_sprite_2d.stop()
	move_and_slide()
