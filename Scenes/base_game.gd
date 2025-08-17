extends Node2D

var score := [0,0]
const PADDLE_SPEED = 500.0
const WINNING_SCORE = 8

@onready var ball: CharacterBody2D = $Ball
@onready var player_score = $GameScore/PlayerScore
@onready var ai_score = $GameScore/AIScore
@onready var ball_timer = $BallTimer
@onready var game_end: CanvasLayer = $GameEnd

func _ready() -> void:
	get_tree().paused = true

func _on_ball_timer_timeout() -> void:
	ball.reset_ball()
	ball.play_start_sound()

func _on_left_body_entered(body):
	# increase enemy score
	score[1] += 1
	ai_score.text = str(score[1])
	ball.play_score_sound()
	
	if score[1] >= WINNING_SCORE:
		# Enemy wins 
		end_game(Enums.PaddleType.AI)
	else:
		ball_timer.start()

func _on_right_body_entered(body):
	# increase player score
	print(score[0])
	score[0] += 1
	player_score.text = str(score[0])
	ball.play_score_sound()
	
	if score[0] >= WINNING_SCORE:
		# PLayer wins 
		end_game(Enums.PaddleType.PLAYER)
	else:
		ball_timer.start()
	
func start_game():
	get_tree().paused = false
	ball_timer.start()
	
func end_game(value: Enums.PaddleType):
	await get_tree().create_timer(0.5).timeout
	
	get_tree().paused = true
	game_end.visible = true
	game_end.set_winning_side(value)
	
	
