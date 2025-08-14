extends CharacterBody2D

const BASE_SPEED: int = 500
const ACCEL: int = 50
var ball_speed: int
var window_size: Vector2
var direction: Vector2
const MAX_Y_VECTOR: float = 0.6

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	window_size = get_viewport_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var collision = move_and_collide(direction * ball_speed * delta)
	var collider
	
	if collision:
		collider = collision.get_collider()
		
		if collider == $"../Player" or collider == $"../AI":
			ball_speed += ACCEL
			direction = new_direction(collider)
		else:
			direction = direction.bounce(collision.get_normal())

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
	
func new_direction(collider):
	var ball_y = position.y
	var paddle_y = collider.position.y
	var distance = ball_y - paddle_y
	var new_dir := Vector2()
	
	#flip horizontal direction
	if direction.x > 0:
		new_dir.x = -1
	else:
		new_dir.x = 1
	
	new_dir.y = (distance / (collider.paddle_height / 2)) * MAX_Y_VECTOR
	return new_dir.normalized()
