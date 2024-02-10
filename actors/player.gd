extends StaticBody2D

class_name Player
var lateral_speed = 800
var screen_size
@onready var flames_animation = $FlamesAnimation

const turning_constante = PI/8

func start(pos):
	position = pos
	
func _ready():
	screen_size = get_viewport_rect().size
	flames_animation.play()

func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		rotation = turning_constante
	elif Input.is_action_pressed("move_left"):
		velocity.x -= 1
		rotation = -turning_constante
	else:
		rotation = 0

	if velocity.length() > 0:
		velocity = velocity.normalized() * lateral_speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
func stop(pos):
	position = pos
