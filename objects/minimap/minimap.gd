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

const player_ship = "player_ship"

# Called when the node enters the scene tree for the first time.
func start():
	sprite_adversaire_1.animation = GlobalState.opponents[0].ship_name
	sprite_adversaire_2.animation = GlobalState.opponents[1].ship_name
	sprite_adversaire_3.animation = GlobalState.opponents[2].ship_name
	var adversaire_1 = Adversaire.new()
	adversaire_1.nom_adversaire = GlobalState.opponents[0].ship_name
	adversaire_1.speed = 100.0
	adversaire_1.icone = sprite_adversaire_1
	adversaire_1.character = GlobalState.opponents[0]
	adversaires.append(adversaire_1)
	var adversaire_2 = Adversaire.new()
	adversaire_2.nom_adversaire = GlobalState.opponents[1].ship_name
	adversaire_2.speed = 400.0
	adversaire_2.icone = sprite_adversaire_2
	adversaire_2.character = GlobalState.opponents[1]
	adversaires.append(adversaire_2)
	var adversaire_3 = Adversaire.new()
	adversaire_3.nom_adversaire = GlobalState.opponents[2].ship_name
	adversaire_3.speed = 800.0
	adversaire_3.icone = sprite_adversaire_3
	adversaire_3.character = GlobalState.opponents[2]
	adversaires.append(adversaire_3)
	
	animated_sprite_player.animation = GlobalState.player.ship_name
	
	for adversaire in adversaires:
		add_child(adversaire)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for adversaire in adversaires:
		var icone = adversaire.icone
		icone.position.y = calculate_position_on_progress(adversaire.vertical_position)
	animated_sprite_player.position.y = calculate_position_on_progress(position_player)
	
	# Calculer l'ordre des joueurs
	var ranking_players = [] + adversaires
	var player_character = Adversaire.new()
	player_character.nom_adversaire = "player"
	player_character.character = GlobalState.player
	player_character.vertical_position = position_player
	ranking_players.append(player_character)
	ranking_players.sort_custom(func(adv1: Adversaire, adv2: Adversaire): return adv1.vertical_position > adv2.vertical_position)
	
	# Update ranking position of each character in Global State
	for i in range(ranking_players.size()):
		var character = ranking_players[i]
		if character.nom_adversaire == "player":
			GlobalState.player.ranking_position = i
		else:
			for opponent in GlobalState.opponents:
				if opponent.id == character.character.id:
					opponent.ranking_position = i
	
	#for adversaire in adversaires:
		#ranking_players.append([adversaire.nom_adversaire, adversaire.vertical_position])
	#ranking_players.sort_custom(func(a, b): return a[1] > b[1])
	#for ranked_player_index in ranking_players.size():
		#var ranked_player = ranking_players[ranked_player_index]
		#if ranked_player[0] == player_ship:
			#GlobalState.player.ranking_position = ranked_player_index
		#else:
			#var global_state_opponent = GlobalState.opponents.filter(func(opponent): return opponent.ship_name == ranked_player[0])[0]
			#global_state_opponent.ranking_position = ranked_player_index
	#print(GlobalState.opponents.map(func(opponent): return opponent.ship_name + " " + str(opponent.ranking_position)))

func calculate_position_on_progress(pos: float):
	return pos * (finish_line.position.y - start_line.position.y) / distance_totale  + start_line.position.y
