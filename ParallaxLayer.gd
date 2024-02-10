extends ParallaxLayer

func _ready():
	set_mirroring(motion_mirroring)

func _process(delta):
	motion_mirroring = Vector2(0,1920)
