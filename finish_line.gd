extends Area2D

var vertical_speed = 1

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
