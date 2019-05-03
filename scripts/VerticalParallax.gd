extends ParallaxBackground

const SCROLLING_SPEED = 0.75

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	$BackgroundLayer.motion_offset.y += SCROLLING_SPEED