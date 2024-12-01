extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0
@onready var main_chrachter2: CharacterBody2D = $"../main_chrachter2"

func _physics_process(delta: float) -> void:
	look_at(main_chrachter2.global_position) 
	var move_vec = Vector2(SPEED, 0).rotated(rotation) 
	global_position += move_vec * delta 
	move_and_slide
