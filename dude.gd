
extends CharacterBody2D

var loop_active = false
var speed = 100  # speed in pixels/sec
const JUMP_VELOCITY = -650

var accumulated = 0;
const START_ANGLE = 5
const END_ANGLE = 60;

@onready var ray_cast_2d: RayCast2D = $RayCast2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite_2d: AnimatedSprite2D = $Sprite
@onready var random_sfx_jump: AudioStreamPlayer = $"../RandomSFXJump"

@onready var player_score: Label = $"../HUD/PlayerScore"
@onready var ares_score: Label = $"../HUD/AresScore"
	
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
					
				velocity.x = direction * speed
			else:
				velocity.x = move_toward(velocity.x, 0, speed)
				animated_sprite_2d.play("idle")
		else:
			velocity.x *= 1 - 0.01 * delta
		
		if not is_on_floor():
			var space_state = get_world_2d().direct_space_state
			var query = PhysicsRayQueryParameters2D.create(position, Vector2(position.x + (-10 if velocity.x < 0 else 10), position.y+12))
			query.exclude = [self]
			var result = space_state.intersect_ray(query)
			
			if result:
				velocity.x = -velocity.x * .8
				
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
				Input.action_release("up")
			return
			
		
		if Input.is_action_just_released("up") and is_on_floor():
			if direction != 0:
				
				var angle = lerp(START_ANGLE, END_ANGLE, clamp(accumulated * 1.2, 0, 1))
				velocity.x = cos(deg_to_rad(angle)) * (1 if direction < 0 else -1) * JUMP_VELOCITY * .35
				velocity.y = sin(deg_to_rad(angle)) * JUMP_VELOCITY
			else:
				velocity.y = JUMP_VELOCITY * accumulated
			accumulated = 0
			
			random_sfx_jump.play()
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
	var prev_value = int(ares_score.chr(-1))
	prev_value += 1
	
	ares_score.text[-1] = prev_value
	print("DUDE EXITED")


func _on_portal_area_entered(area: Area2D) -> void:
	get_tree().change_scene_to_file("res://credits.tscn")
