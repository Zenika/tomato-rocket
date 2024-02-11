extends Node2D
@onready var audio_stream_player_2d = $AudioStreamPlayer2D


# Called when the node enters the scene tree for the first time.
func _ready():
	audio_stream_player_2d.play() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalState.health > 0:
		$RichTextLabel.text = "[center]Level Complete[/center]"
	else:
		$RichTextLabel.text = "[center]Game Over[/center]"
	if Input.is_action_pressed("boost"):
		GlobalState.reset()
		get_tree().change_scene_to_file("res://scenes/race_screen.tscn")
