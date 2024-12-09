extends CanvasLayer

signal transitioned

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	transition()
	
func transition():
	animation_player.play("fade_to_black")
	print("fading to black")
	
	
func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_to_black":
		emit_signal("transitioned")
		print("emit signal tras")
		animation_player.play("fade_to_normal")
		await  animation_player.animation_finished
