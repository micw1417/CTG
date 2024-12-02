extends RigidBody2D

var speed = 100
var push_force = 5000

func _physics_process(delta):
	var move_vector = Vector2()

	# Handle player input for movement
	if Input.is_action_pressed("right"):
		move_vector.x += 1
	if Input.is_action_pressed("left"):
		move_vector.x -= 1
	if Input.is_action_pressed("down"):
		move_vector.y += 1
	if Input.is_action_pressed("up"):
		move_vector.y -= 1
	
	move_vector = move_vector.normalized() * speed
	linear_velocity = move_vector
