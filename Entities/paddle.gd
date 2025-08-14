extends CharacterBody2D

enum PaddleType {PLAYER, AI}

@export var paddle_type: PaddleType = PaddleType.PLAYER
@export var up_action: String = "up"
@export var down_action: String = "down"

# AI-specific properties
@export var ball_reference: Node2D  # Drag the ball node here in inspector
@export var ai_reaction_speed: float = 0.8  # How fast AI follows ball (0.0-1.0)
@export var ai_prediction_offset: float = 50.0  # How far ahead AI tries to position

var screen_height: float
var paddle_height: float

func _ready() -> void:
	screen_height = get_viewport_rect().size.y
	paddle_height = $ColorRect.get_size().y

func _process(delta: float) -> void:
	match paddle_type:
		PaddleType.PLAYER:
			handle_player_input(delta)
		PaddleType.AI:
			handle_ai_movement(delta)
	
	position.y = clamp(position.y, paddle_height / 2, screen_height - paddle_height / 2)
	
func handle_player_input(delta: float) -> void:
	if Input.is_action_pressed("up"):
		position.y -= get_parent().PADDLE_SPEED * delta
	elif Input.is_action_pressed("down"):
		position.y += get_parent().PADDLE_SPEED * delta
		
func handle_ai_movement(delta: float) -> void:
	if not ball_reference:
		return
	
	# Calculate target position (ball Y + some prediction offset)
	var target_y = ball_reference.position.y
	
	# Simple AI: move towards the ball with some reaction delay
	var distance_to_target = target_y - position.y
	
	# Only move if the distance is significant (creates more realistic AI)
	if abs(distance_to_target) > ai_prediction_offset:
		var move_direction = sign(distance_to_target)
		var ai_speed = get_parent().PADDLE_SPEED * ai_reaction_speed
		position.y += move_direction * ai_speed * delta
