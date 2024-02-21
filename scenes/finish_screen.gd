extends Node3D

@onready var text_label = $TextLabel
@onready var ranking_label = $RankingLabel
@onready var avatar_1 = $Avatar1
@onready var avatar_2 = $Avatar2
@onready var avatar_3 = $Avatar3
@onready var avatar_4 = $Avatar4

var avatars
var window_size
var ranking = []
var winner

func _ready():
	window_size = get_window().size
	winner = _get_winner()
	avatars = [avatar_1, avatar_2, avatar_3, avatar_4]
		
	if GlobalState.health > 0:
		if winner.is_player == true:
			ranking_label.text = "[center]You won![/center]"
		else:
			ranking_label.text = "[center]The winner is... player "+str(winner.id)+"[/center]"
		
		for avatar in avatars:
			if avatar.name == winner.avatar_name:
				avatar.visible = true
		
		text_label.text = "[center]Level Complete[/center]"
	else:
		text_label.position.y = window_size.y / 2
		text_label.text = "[center]Game Over[/center]"
		
func _process(_delta):
	if Input.is_action_pressed("boost"):
		for avatar in avatars:
			if avatar.name == winner.avatar_name:
				avatar.visible = false
		ranking_label.text = ""
		if GlobalState.health > 0:
			GlobalState.next_level()
			get_tree().change_scene_to_file("res://scenes/race_screen.tscn")
		else:
			GlobalState.reset()
			get_tree().change_scene_to_file("res://scenes/player_selection_screen.tscn")

func _get_winner():
	ranking = [GlobalState.opponents[0], GlobalState.opponents[1], GlobalState.opponents[2], GlobalState.player]
	ranking.sort_custom(func(char_1: Character, char_2: Character): return char_1.ranking_position < char_2.ranking_position)
	return ranking[0]
