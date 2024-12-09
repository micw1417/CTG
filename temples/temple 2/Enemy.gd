extends RigidBody2D

var speed = 50
@onready var main: CharacterBody2D = $"../main_chrachter2"
# Called when the node enters the scene tree for the first time.
	
func _physics_process(delta): 
	var direction = (main.position - position).normalized()
	var move_vector = direction * speed
	linear_velocity = move_vector
	
	pass
