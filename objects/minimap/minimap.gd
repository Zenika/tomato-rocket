extends Node2D

class_name Minimap

@export var adversaires = []
@export var distance_totale = 20000
@export var position_player = 0

@onready var sprite_adversaire_1 = $DisplayOpponents/AnimatedSpriteOpponent1
@onready var sprite_adversaire_2 = $DisplayOpponents/AnimatedSpriteOpponent2
@onready var sprite_adversaire_3 = $DisplayOpponents/AnimatedSpriteOpponent3

@onready var finish_line_label = $DisplayOpponents/FinishLineLabel
@onready var start_line_label = $DisplayOpponents/StartLineLabel

@onready var animated_sprite_player = $DisplayOpponents/AnimatedSpritePlayer

@onready var finish_line = $DisplayOpponents/FinishLine
@onready var start_line = $DisplayOpponents/StartLine
signal depasse_adversaire(adversaire: Adversaire)

# Called when the node enters the scene tree for the first time.
func start():
	sprite_adversaire_1.animation = GlobalState.opponents[0].ship_name
	sprite_adversaire_2.animation = GlobalState.opponents[1].ship_name
	sprite_adversaire_3.animation = GlobalState.opponents[2].ship_name
	var adversaire_1 = Adversaire.new()
	adversaire_1.nom_adversaire = "Jeff Bezos"
	adversaire_1.speed = 300.0
	adversaire_1.icone = sprite_adversaire_1
	adversaires.append(adversaire_1)
	var adversaire_2 = Adversaire.new()
	adversaire_2.nom_adversaire = "Yuri Gagarine"
	adversaire_2.speed = 700.0
	adversaire_2.icone = sprite_adversaire_2
	adversaires.append(adversaire_2)
	var adversaire_3 = Adversaire.new()
	adversaire_3.nom_adversaire = "Claudie Hignerai"
	adversaire_3.speed = 1200.0
	adversaire_3.icone = sprite_adversaire_3
	adversaires.append(adversaire_3)
	
	animated_sprite_player.animation = GlobalState.player.ship_name
	
	for adversaire in adversaires:
		add_child(adversaire)
		



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for adversaire in adversaires:
		var icone = adversaire.icone
		icone.position.y = calculate_position_on_progress(adversaire.vertical_position)
	animated_sprite_player.position.y = calculate_position_on_progress(position_player)

func calculate_position_on_progress(pos: float):
	return pos * (finish_line.position.y - start_line.position.y) / distance_totale  + start_line.position.y
