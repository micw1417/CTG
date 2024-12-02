
extends CharacterBody2D

var loop_active = false
var speed = 100  # speed in pixels/sec
@onready var animated_sprite_2d: AnimatedSprite2D = $Sprite
	
func _physics_process(delta):
	if DialogManager.is_dialog_active:
		return
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
	#if Input.is_action_pressed("advance_dialog"):
		#loop_active = true
		#
	#if loop_active == true:
		#rotation += 1 * delta
	
	
