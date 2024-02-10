extends Node2D

@export var vertical_speed = 200
const speed_multiplicator = 50

func new_game():
	$Player.start($PlayerPosition.position)

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	vertical_speed = vertical_speed + delta * speed_multiplicator 
	$FinishLine.set_vertical_speed(vertical_speed)
	$Background.set_vertical_speed(vertical_speed)
	
