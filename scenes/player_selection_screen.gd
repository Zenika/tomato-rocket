extends Node3D

@onready var avatar_1 = $Avatar1
@onready var avatar_2 = $Avatar2
@onready var avatar_3 = $Avatar3
@onready var avatar_4 = $Avatar4
var avatars
var selected_avatar

# Called when the node enters the scene tree for the first time.
func _ready():
	selected_avatar = GlobalState.selected_avatar
	avatars = [avatar_1, avatar_2, avatar_3, avatar_4]
	GlobalState.avatars = avatars
	avatars[selected_avatar].visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(selected_avatar)
	print(avatars[selected_avatar].visible)
	if (GlobalState.is_race_finished):
		avatars[selected_avatar].visible = false
		avatars[GlobalState.winner_index].visible = true
		$Label.text = "The winner is... PLAYER " + str(GlobalState.winner_index)
		if Input.is_action_just_pressed("boost"):
			GlobalState.reset()
			selected_avatar = GlobalState.selected_avatar
			avatars[GlobalState.winner_index].visible = false
			avatars[selected_avatar].visible = true
	else:
		for avatar in avatars:
			avatar.rotation.y += 0.05
		$Label.text = "Choose your avatar with <= or => and press SPACE"
		if Input.is_action_just_pressed("move_right"):
			avatars[selected_avatar].visible = false
			selected_avatar += 1
			selected_avatar = selected_avatar % avatars.size()
			avatars[selected_avatar].visible = true
		if Input.is_action_just_pressed("move_left"):
			avatars[selected_avatar].visible = false
			selected_avatar -= 1
			selected_avatar = (selected_avatar + avatars.size()) % avatars.size()
			avatars[selected_avatar].visible = true
		if Input.is_action_just_pressed("boost"):
			GlobalState.selected_avatar = selected_avatar
			avatars[selected_avatar].visible = false
			get_tree().change_scene_to_file('res://scenes/ship_selection_screen.tscn')
