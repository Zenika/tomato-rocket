extends Node2D

@export var enemy_scene: PackedScene
@export var boost_scene: PackedScene
@export var vertical_speed = 200
@onready var health_label = $Health
@onready var distance_label = $Distance
@onready var boost_progress_bar = $BoostProgressBar
@onready var enemy_timer = $EnemyTimer
@onready var boost_duration_timer = $BoostDurationTimer
@onready var pickup_boost_sound = $PickupBoostSound
@onready var boost_activation_sound = $BoostActivationSound
@onready var hit_asteroid_sound = $HitAsteroidSound
@onready var adversaires = $Adversaires

const speed_multiplicator = 20
const max_speed = 1600
var is_finished = false

const race_length = 80000
var traveled_distance = 0

const window_height = 950
const window_width = 1920

var is_boost_enabled = false

const distance_between_asteroids = 250.0

var is_boosting = false
var last_speed_before_boost = 0

func _ready():
	new_game()
	
func new_game():
	health_label.text = str(GlobalState.health)
	distance_label.text = str(traveled_distance) + '/' + str(race_length)
	boost_progress_bar.value = 0
	adversaires.distance_totale = race_length
	
	$EnemyTimer.start()
	$BoostTimer.start()
	$Player.start($PlayerPosition.position)
	
func hurt_player():
	GlobalState.health -= 10
	health_label.text = str(GlobalState.health)
	vertical_speed /= 2
	hit_asteroid_sound.play()
	if GlobalState.health <= 0:
		finish_game()
		
func fill_boost():
	pickup_boost_sound.play()
	boost_progress_bar.value += 25
	is_boost_enabled = boost_progress_bar.value >= 100

func _process(delta):
	if (is_finished):
		vertical_speed = 0
	else:
		adversaires.position_player = traveled_distance
		if !is_boosting:
			vertical_speed = min(vertical_speed + delta * speed_multiplicator, max_speed)
		if Input.is_action_pressed("boost"):
			boost()

	$Background.set_vertical_speed(vertical_speed)
	traveled_distance += vertical_speed * delta
	if (traveled_distance > race_length - window_height):
		$FinishLine.set_process(true)
		$FinishLine.set_vertical_speed(vertical_speed)
	
	distance_label.text = str(int(traveled_distance)) + ' / ' + str(race_length)
	
	# Augmenter la fréquence des astéroides en fonction de la vitesse
	if vertical_speed != 0:
		enemy_timer.wait_time = max(distance_between_asteroids / vertical_speed, 0.45)
	else:
		enemy_timer.stop()
	
func _on_enemy_timer_timeout():
	var enemy = enemy_scene.instantiate()
	enemy.position = Vector2(window_width * randf(), -100)
	add_child(enemy)
	
func boost():
	if is_boost_enabled:
		reset_boost()
		boost_activation_sound.play()
		boost_duration_timer.start()
		last_speed_before_boost = vertical_speed
		is_boosting = true
		vertical_speed = max_speed * 2

func _on_boost_timer_timeout():
	var jerrycan = boost_scene.instantiate()
	jerrycan.position = Vector2(window_width * randf(), -100)
	add_child(jerrycan)
	
func win_game():
	vertical_speed = 0
	finish_game()
	
func finish_game():
	is_finished = true
	$Player.stop($PlayerPosition.position)
	get_tree().change_scene_to_file("res://scenes/finish_screen.tscn")
	
func reset_boost():
	boost_progress_bar.value = 0
	is_boost_enabled = false

func _on_boost_duration_timer_timeout():
	vertical_speed = last_speed_before_boost
	is_boosting = false
