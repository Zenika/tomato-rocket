extends Node2D

@export var finish_line_scene: PackedScene
@export var vertical_speed = 200
const speed_multiplicator = 50
var is_finished = false

const race_length = 10000
const window_height = 950
var traveled_distance = 0

func new_game():
	$Player.start($PlayerPosition.position)

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (is_finished):
		vertical_speed = 0
	else:
		vertical_speed = vertical_speed + delta * speed_multiplicator
	$Enemy.set_vertical_speed(vertical_speed)
	$Background.set_vertical_speed(vertical_speed)
	traveled_distance += vertical_speed * delta
	if (traveled_distance > race_length - window_height):
		$FinishLine.set_process(true)
		$FinishLine.set_vertical_speed(vertical_speed)
	
func finish_game():
	is_finished = true
	print(traveled_distance)
	$Player.stop($PlayerPosition.position)
