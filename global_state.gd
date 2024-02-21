extends Node

# Avatars
var avatars
var avatars_name
var selected_avatar = 0

# Ships
var ships
var ships_name
var selected_ship = 0

# Characters
var player = Character.new()
var opponents = []

# Game State
var level = 1
var race_length = 40000
var is_race_finished = false
var health: float = 0
const max_health: float = 30
	
func init_game():
	health = max_health
	
	player.id = 0
	player.avatar = avatars[selected_avatar]
	player.avatar_name = avatars_name[selected_avatar]
	player.ship = ships[selected_ship]
	player.ship_name = ships_name[selected_ship]
	player.ranking_position = 0
	player.is_player = true
	
	var remaining_avatars = [] + avatars
	remaining_avatars.remove_at((selected_avatar + remaining_avatars.size()) % remaining_avatars.size())
	var remaining_avatars_name =  [] + avatars_name
	remaining_avatars_name.remove_at(selected_avatar)
	var remaining_ships =  [] + ships
	remaining_ships.remove_at(selected_ship)
	var remaining_ships_name =  [] + ships_name
	remaining_ships_name.remove_at(selected_ship)

	for i in range(remaining_avatars.size()):
		var opponent = Character.new()
		opponent.id = i + 1
		opponent.avatar = remaining_avatars[i]
		opponent.avatar_name = remaining_avatars_name[i]
		opponent.ship = remaining_ships[i]
		opponent.ship_name = remaining_ships_name[i]
		opponent.ranking_position = i + 1
		opponents.append(opponent)
	
func reset():
	level = 1
	race_length = 40000
	is_race_finished = false
	selected_avatar = 0
	selected_ship = 0
	
func next_level():
	level += 1
	race_length = race_length * 1.5
	is_race_finished = false
