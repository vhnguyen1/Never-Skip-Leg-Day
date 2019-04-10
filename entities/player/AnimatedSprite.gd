extends AnimatedSprite

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("animation_finished", self, "_onAnimatedSprite_animation_finished")
	#pass
	
func _onAnimatedSprite_animation_finished():
	self.animation = "Run"
	
	#if self.animation == "Run":
		#animation = "Run"
	#else:
		#animation = "Run"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass