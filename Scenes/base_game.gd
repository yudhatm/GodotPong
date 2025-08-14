extends Node2D

var score := [0,0]
const PADDLE_SPEED = 500.0

@onready var ball: CharacterBody2D = $Ball
@onready var player_score = $GameScore/PlayerScore
@onready var ai_score = $GameScore/AIScore
@onready var ball_timer = $BallTimer

func _on_ball_timer_timeout() -> void:
	ball.reset_ball()

func _on_left_body_entered(body):
	# increase enemy score
	score[1] += 1
	ai_score.text = str(score[1])
	ball_timer.start()

func _on_right_body_entered(body):
	# increase player score
	print(score[0])
	score[0] += 1
	player_score.text = str(score[0])
	ball_timer.start()
