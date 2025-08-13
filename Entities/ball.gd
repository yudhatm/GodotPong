extends CharacterBody2D

const BASE_SPEED: int = 500
const ACCEL: int = 50
var ball_speed: int
var window_size: Vector2
var direction: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	window_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	move_and_collide(direction * ball_speed * delta)

func reset_ball():
	position.x = window_size.x / 2
	position.y = randf_range(200, window_size.y - 200)
	ball_speed = BASE_SPEED
	direction = random_direction()
	
func random_direction():
	var new_dir: Vector2
	new_dir.x = [1, -1].pick_random()
	new_dir.y = randf_range(-1, 1)
	return new_dir.normalized()
	
