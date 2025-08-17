extends CanvasLayer

@onready var easy: Button = $VBoxContainer/Easy
@onready var medium: Button = $VBoxContainer/Medium
@onready var hard: Button = $VBoxContainer/Hard
@onready var ai: CharacterBody2D = %AI

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED

func _hide_menu():
	visible = false
	get_parent().start_game()

func _on_easy_pressed() -> void:
	ai.set_ai_difficulty(Enums.Difficulty.EASY)
	_hide_menu()

func _on_medium_pressed() -> void:
	ai.set_ai_difficulty(Enums.Difficulty.MEDIUM)
	_hide_menu()

func _on_hard_pressed() -> void:
	ai.set_ai_difficulty(Enums.Difficulty.HARD)
	_hide_menu()
