extends Node

@onready var adversaires = $".."

@export var player_vertical_position = 300

const distance_visible_to_player = 800

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for adversaire in adversaires.adversaires:
		if !adversaire.on_screen and abs(adversaire.vertical_position - player_vertical_position) < distance_visible_to_player:
			adversaire.on_screen = true
			adversaires.depasse_adversaire.emit(adversaire)
	
