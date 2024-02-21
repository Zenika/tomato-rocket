extends Node

@onready var opponents_state = $".."

const distance_visible_to_player = 800

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for adversaire in opponents_state.adversaires:
		if !adversaire.on_screen and adversaire.vertical_position - opponents_state.position_player < distance_visible_to_player and adversaire.vertical_position - opponents_state.position_player < 0:
			opponents_state.depasse_adversaire.emit(adversaire)
			adversaire.on_screen = true
			
	
