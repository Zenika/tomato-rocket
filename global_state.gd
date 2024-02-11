extends Node

# Avatars
var avatars
var selected_avatar = 0
var winner_index = 0

var health = 30

# Game State
var is_race_finished = false

func reset():
	health = 30
	is_race_finished = false
