extends RigidBody2D

@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var main : CharacterBody2D = $"../main_chrachter2"
var speed = 50
@onready var main_chrachter_2: CharacterBody2D = $"../main_chrachter2"
@onready var player_score: Label = $"../HUD/PlayerScore"
@onready var ares_score: Label = $"../HUD/AresScore"

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
		return
		
	interaction_area.visible = true
	
	DialogManager.start_dialog(global_position, lines)
	await DialogManager.dialog_finished
	position = Vector2(200, -67)
	main_chrachter_2.position = Vector2(100, -67)
	StateManager.isFightingAres = true
	InteractionManager.visible = false
	player_score.visible = true
	ares_score.visible = true
	
func _on_collision_polygon_2d_child_exiting_tree(node: Node) -> void:
	var prev_value = int(player_score.chr(-1))
	prev_value += 1
	
	player_score.text[-1] = prev_value