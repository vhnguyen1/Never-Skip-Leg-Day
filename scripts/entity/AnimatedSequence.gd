extends AnimatedSprite

export var DEFAULT = "default"
export var DYING = "dying"
export var FALLING = "falling"
export var HURTING = "hurting"
export var ATTACKING = "attacking"
export var RUNNING = "running"
export var WALKING = "walking"

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("animation_finished", self, "_onAnimatedSprite_animation_finished")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _onAnimatedSprite_animation_finished():
	#self.animation = "run"
	#self._play_random_animation()
	
	if self.animation == DEFAULT:
		animation = DYING
	elif self.animation == DYING:
		animation = FALLING
	elif self.animation == FALLING:
		animation = HURTING
	elif self.animation == HURTING:
		animation = ATTACKING
	elif self.animation == ATTACKING:
		animation = RUNNING
	elif self.animation == RUNNING:
		animation = WALKING
	else:
		animation = DEFAULT
	
	self._print_current_animation()

func _play_random_animation():
	match randi()% 8 + 1:
		1:
			self.animation = DYING
		2:
			self.animation = FALLING
		3:
			self.animation = HURTING
		4:
			self.animation = ATTACKING
		5:
			self.animation = RUNNING
		6:
			self.animation = WALKING
		_:
			self.animation = DEFAULT

func _print_current_animation():
	print("Playing " + self.animation + " animation.")