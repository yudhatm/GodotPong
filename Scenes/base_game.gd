extends Node2D

var score := [0,0]
const PADDLE_SPEED = 500.0

@onready var ball: CharacterBody2D = $Ball

func _on_ball_timer_timeout() -> void:
	ball.reset_ball()
