extends ParallaxBackground

var vertical_speed
var c = 2
 
func _process(delta: float) -> void:
	var camera_velocity = Vector2(0, vertical_speed * c)
	var new_offset: Vector2 = get_scroll_offset() + camera_velocity * delta
	set_scroll_offset( new_offset )
	
func set_vertical_speed(speed):
	vertical_speed = speed
