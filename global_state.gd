extends Node

# Avatars
var avatars
var selected_avatar = 0

# Ships
var ships
var ships_name
var selected_ship = 0

# Characters
var player = Character.new()
var opponents = []

# Game State
var is_race_finished = false
var health: float = 0
var winner_index = 0
const max_health: float = 30;
	
func init_game():
	health = max_health
	
	player.avatar = avatars[selected_avatar]
	player.ship = ships[selected_ship]
	player.ship_name = ships_name[selected_ship]
	player.ranking_position = 0
	player.is_player = true
	
	var remaining_avatars = [] + avatars
	remaining_avatars.remove_at((selected_avatar + remaining_avatars.size()) % remaining_avatars.size())
	var remaining_ships =  [] + ships
	remaining_ships.remove_at(selected_ship)
	var remaining_ships_name =  [] + ships_name
	remaining_ships_name.remove_at(selected_ship)

	for i in range(remaining_avatars.size()):
		var opponent = Character.new()
		opponent.avatar = remaining_avatars[i]
		opponent.ship = remaining_ships[i]
		opponent.ship_name = remaining_ships_name[i]
		opponent.ranking_position = i + 1
		opponents.append(opponent)
	
func reset():
	health = 30
	is_race_finished = false
	selected_avatar = 0
	selected_avatar = 0	
