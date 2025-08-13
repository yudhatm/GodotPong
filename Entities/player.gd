extends CharacterBody2D

var screen_height: float
var paddle_height:float

func _ready() -> void:
	screen_height = get_viewport_rect().size.y
	paddle_height = $ColorRect.get_size().y

func _process(delta: float) -> void:
	if Input.is_action_pressed("up"):
		position.y -= get_parent().PADDLE_SPEED * delta
	elif Input.is_action_pressed("down"):
		position.y += get_parent().PADDLE_SPEED * delta
	
	position.y = clamp(position.y, paddle_height / 2, screen_height - paddle_height / 2)
	
