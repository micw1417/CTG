
extends CharacterBody2D

var loop_active = false
var speed = 100  # speed in pixels/sec
const JUMP_VELOCITY = -600

var accumulated = 0;
const START_ANGLE = 5
const END_ANGLE = 60;


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite_2d: AnimatedSprite2D = $Sprite
	
func _physics_process(delta):
	if DialogManager.is_dialog_active:
		return
	
	if StateManager.diedUpsidedown:

		var direction = Input.get_axis("left", "right")
		if is_on_floor():
			if direction:
				if direction > 0:
					animated_sprite_2d.play("right")
				elif direction < 0:
					animated_sprite_2d.play("left")
				else:
					animated_sprite_2d.play("idle")
				velocity.x = direction * speed
			else:
				velocity.x = move_toward(velocity.x, 0, speed)
		else:
			velocity.x *= 1 - 0.01 * delta
		
		if not is_on_floor():
			velocity.y += gravity * delta
			#if velocity.x > 0:
				#animated_sprite_2d.play("right_leap")
			#if velocity.x < 0:
				#animated_sprite_2d.play("left_leap")
				#
		if Input.is_action_pressed("up") and is_on_floor():
			animated_sprite_2d.play("crouch")
			accumulated += delta;
			if accumulated > 1:
				print("fs")
				Input.action_release("up")
			return
			
		
		if Input.is_action_just_released("up") and is_on_floor():
			if direction != 0:
				
				var angle = lerp(START_ANGLE, END_ANGLE, clamp(accumulated * 1.2, 0, 1))
				velocity.x = cos(deg_to_rad(angle)) * (1 if direction < 0 else -1) * JUMP_VELOCITY * .3
				velocity.y = sin(deg_to_rad(angle)) * JUMP_VELOCITY
			else:
				velocity.y = JUMP_VELOCITY * accumulated
			accumulated = 0
			
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
	
	
	
	
func smoothstep(edge0: float, edge1: float, x: float) -> float:
	# Clamp x to the range [0, 1]
	x = clamp((x - edge0) / (edge1 - edge0), 0.0, 1.0)
	# Apply the smoothstep formula
	return x * x * (3.0 - 2.0 * x)

			
	#if Input.is_action_pressed("advance_dialog"):
		#loop_active = true
		#
	#if loop_active == true:
		#rotation += 1 * delta
	
	


func _on_collision_polygon_2d_child_exiting_tree(node: Node) -> void:
	print("DUDE LEFT")
