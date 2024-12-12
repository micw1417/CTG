extends RigidBody2D
@onready var timer: Timer = $"../Timer"

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
	sprite.play("default")
	
	
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
	timer.start()
	
	#player_score.visible = true
	#ares_score.visible = true
	
func _on_collision_polygon_2d_child_exiting_tree(node: Node) -> void:
	print("go")


func _on_area_2d_body_exited(body: Node2D) -> void:
	StateManager.isFightingAres == true
	position = Vector2(200, -67)
	main_chrachter_2.position = Vector2(100, -67)
	timer.stop()
	timer.start()


func _on_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://game/overworld.tscn")
