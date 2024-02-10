extends Area2D

var vertical_speed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	velocity.y += 1

	if velocity.length() > 0:
		velocity = velocity.normalized()
		
	position += delta * velocity * vertical_speed
	
func set_vertical_speed(speed):
	vertical_speed = speed

func _on_collision_polygon_2d_body_entered(body):
	if body is Player:
		get_parent().vertical_speed = 0
		get_parent().finish_game()
