extends CanvasLayer

@onready var title: Label = $Control/Title

func _ready() -> void:
	visible = false
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	
func set_winning_side(value: Enums.PaddleType):
	match value:
		Enums.PaddleType.PLAYER:
			title.text = "You Win!"
			
		Enums.PaddleType.AI:
			title.text = "AI Win!"

func _on_play_button_pressed() -> void:
	get_tree().reload_current_scene() # Replace with function body.
	
