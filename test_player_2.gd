extends RigidBody2D

var speed = 50

@onready var test_player: RigidBody2D = $"../TestPlayer"

func _physics_process(delta): 
	#var direction = (test_player.position - position).normalized()
	#var move_vector = direction * speed
	#linear_velocity = move_vector
	pass
