extends RigidBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var main : CharacterBody2D = $"../main_chrachter2"
var speed = 50
@onready var main_chrachter_2: CharacterBody2D = $"../main_chrachter2"

var lines: Array[String] = [
	"Welcome to my temple.",
	"If you want to gain my favor",
	"Go and battle me..."
]
func _physics_process(delta): 
	if StateManager.isFightingAres:
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
	if StateManager.isFightingAres == true:
		InteractionManager.visible = false
		return
		
	interaction_area.visible = true
	
	DialogManager.start_dialog(global_position, lines)
	await DialogManager.dialog_finished
	position = Vector2(169, -65)
	main_chrachter_2.position = Vector2(130, -65)
	StateManager.isFightingAres = true
	
	
