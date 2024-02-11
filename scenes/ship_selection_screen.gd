extends Node2D

var selected_ship = GlobalState.selected_ship
@onready var ship_1 = $Ship1
@onready var ship_rect_1 = $Ship1Rect
@onready var ship_2 = $Ship2
@onready var ship_rect_2 = $Ship2Rect
@onready var ship_3 = $Ship3
@onready var ship_rect_3 = $Ship3Rect
@onready var ship_4 = $Ship4
@onready var ship_rect_4 = $Ship4Rect
var ships
var ships_name
var rect_ships

var initial_color = Color("000063")
var selected_color = Color.WEB_GRAY

func _ready():
	ships = [ship_1, ship_2, ship_3, ship_4]
	ships_name = ["ship1", "ship2", "ship3", "ship4"]
	rect_ships = [ship_rect_1, ship_rect_2, ship_rect_3, ship_rect_4]
	GlobalState.ships = ships
	GlobalState.ships_name = ships_name
	rect_ships[selected_ship].color = selected_color

func _process(delta):
	$Label.text = "Choose your ship with <= or => and press SPACE"
	if Input.is_action_just_pressed("move_right"):
		rect_ships[selected_ship].color = initial_color
		selected_ship += 1
		selected_ship = selected_ship % ships.size()
		rect_ships[selected_ship].color = selected_color
	if Input.is_action_just_pressed("move_left"):
		rect_ships[selected_ship].color = initial_color
		selected_ship -= 1
		selected_ship = (selected_ship + ships.size()) % ships.size()
		rect_ships[selected_ship].color = selected_color
	if Input.is_action_just_pressed("boost"):
		GlobalState.selected_ship = selected_ship
		get_tree().change_scene_to_file('res://scenes/race_screen.tscn')
