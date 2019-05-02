extends KinematicBody2D

#------------------------- Constants ------------------------------------#

const SPEED = 3.5 # Rate at which Plank falls
const UPPER_Y_BOUND = 980
const MEME_CAP = 32

#------------------------- Functions ------------------------------------#

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Physics processing means that the frame rate is synced to the physics, i.e. the delta variable should be constant.
# @param delta Time passed
func _physics_process(delta):
	# Rate at w
	position.y += SPEED

	# Removes a given plank if it is not in the screen boundaries
	if position.y > UPPER_Y_BOUND:
		queue_free()
		
	# Play the color-swapping plank animation for Meme Overload
	if $"../../".score > MEME_CAP:
		$AnimatedSprite.play()