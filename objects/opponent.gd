extends Area2D

var vertical_speed
const side_movement = 0.4

var velocity = Vector2.ZERO


func _ready():
	# TODO: choisir le vaisseau
	velocity.y += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	vertical_speed = get_parent().vertical_speed
	position += delta * velocity * vertical_speed
	
func set_vertical_speed(speed):
	vertical_speed = speed

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
