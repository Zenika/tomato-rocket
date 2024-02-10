extends Node2D

func new_game():
	$Player.start($PlayerPosition.position)

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$FinishLine.set_vertical_speed($Player.vertical_speed)

