extends Node2D

@export var enemy_scene: PackedScene
@export var finish_line_scene: PackedScene
@export var vertical_speed = 200
const speed_multiplicator = 50
var is_finished = false

const race_length = 100000
const window_height = 950
const window_width = 1920
var traveled_distance = 0

func new_game():
	$EnemyTimer.start()
	$Player.start($PlayerPosition.position)

func _ready():
	new_game()

func _process(delta):
	if (is_finished):
		vertical_speed = 0
	else:
		vertical_speed = vertical_speed + delta * speed_multiplicator
	# $Enemy.set_vertical_speed(vertical_speed)
	$Background.set_vertical_speed(vertical_speed)
	traveled_distance += vertical_speed * delta
	if (traveled_distance > race_length - window_height):
		$FinishLine.set_process(true)
		$FinishLine.set_vertical_speed(vertical_speed)
	
func finish_game():
	is_finished = true
	print(traveled_distance)
	$Player.stop($PlayerPosition.position)


func _on_enemy_timer_timeout():
	var enemy = enemy_scene.instantiate()
	enemy.position = Vector2(window_width * randf(), -100)
	add_child(enemy)
	#enemy.set_vertical_speed(vertical_speed)
