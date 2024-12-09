extends MarginContainer
class_name TextBox

@onready var timer: Timer = $LetterDisplayTimer
@onready var label: Label = $MarginContainer/Label


const max_width = 200

var text = ""
var letter_index = 0

var letter_time = 0.03
var space_time = 0.06
var punctuation_time = 0.2

signal finished_displaying()

func display_text(text_to_display: String):
	text = text_to_display
	label.text = text_to_display
	
	await resized
	
	custom_minimum_size.x = min(size.x, max_width)
	if size.x > max_width:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized # wait for x resize?? 
		#await resized # wait for y resize?? 
		custom_minimum_size.y = size.y

	global_position.x -= size.x / 3
	global_position.y -= (size.y + 24) * scale.y
	
	label.text = ""
	_display_letter()
	
func _display_letter():
	label.text += text[letter_index]
	letter_index += 1
	
	if letter_index >= text.length():
		finished_displaying.emit()
		return
		
	match text[letter_index]:
		"!", ".", ",", "?":
			timer.start(punctuation_time)
		" ":
			timer.start(space_time)
		_:
			timer.start(letter_time)
			
			
func _on_letter_display_timer_timeout() -> void:
	_display_letter()
