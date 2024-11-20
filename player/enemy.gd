extends CharacterBody2D 
@onready var main_chrachter_temple: CharacterBody2D = $"../main_chrachter_temple" 
const SPEED = 2.0 
const JUMP_VELOCITY = -400.0 
const PUSH_FORCE = 15.0 
const MIN_PUSH_FORCE = 10.0 

func _physics_process(delta: float) -> void: 
	look_at(main_chrachter_temple.global_position) 
	var move_vec = Vector2(SPEED, 0).rotated(rotation) 
	global_position += move_vec * delta 
	move_and_slide()
	
