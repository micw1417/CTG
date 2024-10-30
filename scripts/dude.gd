extends CharacterBody2D

var speed = 100  # speed in pixels/sec
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

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
	move_and_slide()
