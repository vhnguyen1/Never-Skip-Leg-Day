extends ParallaxBackground

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	$ParallaxLayer.motion_offset.x -= 0.5