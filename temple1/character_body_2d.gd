extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
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
