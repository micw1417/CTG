extends RigidBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var main : CharacterBody2D = $"../main_chrachter2"
var speed = 50

var lines: Array[String] = [
	"Welcome to my temple"
	
]
func _physics_process(delta): 
	var direction = (main.position - position).normalized()
	var move_vector = direction * speed
	linear_velocity = move_vector
	
	pass

func _process(delta: float) -> void:
	pass

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	sprite.play("idle")
func _on_interact():
	DialogManager.start_dialog(global_position, lines)
	
	
	
