extends Node2D

class_name Adversaire

@export var speed = 200
@export var nom_adversaire = "default"
@export var icone: AnimatedSprite2D
@export var vertical_position = 0
@export var on_screen = false

signal on_update_position(position: int)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	update_vertical_position(delta)

func update_vertical_position(delta: float):
	vertical_position += speed * delta
	on_update_position.emit(position)

