extends Area2D

var vertical_speed
var speed_coef
const side_movement = 0.4

var velocity = Vector2.ZERO

func _ready():
	rotation = randf() * PI
	speed_coef = randf()
	
	velocity.y += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):		
	rotation += 4 * delta
	vertical_speed = get_parent().vertical_speed
	position += delta * velocity * vertical_speed
	
func set_vertical_speed(speed):
	vertical_speed = speed * speed_coef

func _on_collision_polygon_2d_body_entered(body):
	if body is Player:
		get_parent().fill_boost()
		queue_free()
		

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
