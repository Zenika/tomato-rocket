extends Node2D

class_name Minimap

@export var adversaires = []

# Called when the node enters the scene tree for the first time.
func _ready():
	var adversaire_1 = Adversaire.new()
	adversaire_1.nom_adversaire = "Jeff Bezos"
	adversaire_1.speed = 300
	adversaires.append(adversaire_1)
	var adversaire_2 = Adversaire.new()
	adversaire_2.nom_adversaire = "Yuri Gagarine"
	adversaire_2.speed = 700
	adversaires.append(adversaire_2)
	
	for adversaire in adversaires:
		add_child(adversaire)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
