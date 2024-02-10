extends Area2D

var lateral_speed = 400
@export var vertical_speed = 1
var screen_size

const speed_multiplicator = 5

func start(pos):
	position = pos
	
func _ready():
	screen_size = get_viewport_rect().size


func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * lateral_speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	vertical_speed = vertical_speed + delta * speed_multiplicator 
