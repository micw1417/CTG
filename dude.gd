
extends CharacterBody2D

var loop_active = false
var speed = 100  # speed in pixels/sec
const JUMP_VELOCITY = -200
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite_2d: AnimatedSprite2D = $Sprite
	
func _physics_process(delta):
	if DialogManager.is_dialog_active:
		return
	
	if StateManager.diedUpsidedown:
		if not is_on_floor():
			velocity.y += gravity * delta
		
		if Input.is_action_just_pressed("up") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		
		var direction = Input.get_axis("left", "right")
		if direction:
			velocity.x = direction * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
	else:
		var direction = Input.get_vector("left", "right", "up", "down")
		velocity = direction * speed
		if direction.x > 0:
			animated_sprite_2d.play("right")
		if (direction.x < 0):
			animated_sprite_2d.play("left")
		if direction.y > 0:
			animated_sprite_2d.play("down")
		if (direction.y < 0):
			animated_sprite_2d.play("up")
		if velocity == Vector2.ZERO:
			animated_sprite_2d.stop()
	move_and_slide()
	#if Input.is_action_pressed("advance_dialog"):
		#loop_active = true
		#
	#if loop_active == true:
		#rotation += 1 * delta
	
	
