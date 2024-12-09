extends Control
#
@onready var noun_options: OptionButton = $Panel/MarginContainer/VBoxContainer/HBoxContainer/NounOptions
@onready var title_options: OptionButton = $Panel/MarginContainer/VBoxContainer/HBoxContainer/TitleOptions
@onready var verb_options: OptionButton = $Panel/MarginContainer/VBoxContainer/HBoxContainer2/VerbOptions
@onready var exit_button: Button = $Panel/MarginContainer/VBoxContainer/ExitButton

static var noun_value := ""
static var title_value := ""
static var verb_value := ""

func _on_noun_options_item_selected(index: int) -> void:
	noun_value = noun_options.get_item_text(noun_options.selected)
	if noun_value and title_value and verb_value:
		exit_button.visible = true;

func _on_title_options_item_selected(index: int) -> void:
	title_value = title_options.get_item_text(title_options.selected)
	if noun_value and title_value and verb_value:
		exit_button.visible = true;

func _on_verb_options_item_selected(index: int) -> void:
	verb_value = verb_options.get_item_text(verb_options.selected)
	if noun_value and title_value and verb_value:
		exit_button.visible = true;
	
