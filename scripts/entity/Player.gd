extends RigidBody2D

var jump_speed = 600 # how high character will jump
var speed = 300 # how fast movement left to right

var sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite = get_node("Sprite") # uncomment when we get the sprite to work
	set_physics_process(true) # set_fixed_process(true)
	pass

func _physics_process(delta): # _fixed_process
	var left_key = Input.is_action_pressed("ui_left") 
	var right_key = Input.is_action_pressed("ui_right")

	if left_key: # when left key presssed, move left
		set_linear_velocity(Vector2(-speed, get_linear_velocity().y))
		$Sprite.flip_h = false  # character faces left
	if right_key: # when right key pressed, move right
		set_linear_velocity(Vector2(speed, get_linear_velocity().y))
		$Sprite.flip_h = true    # character faces right
	if !left_key and !right_key: # when none of keys are pressed
		set_linear_velocity(Vector2(0, get_linear_velocity().y))
	
# will jump once hits a platform, like doodle jump. will never be at rest
func collision(body):
	if body.is_in_group('Paddles') and get_linear_velocity().y >= 0:
		set_linear_velocity(Vector2(0,-jump_speed))
	pass # Replace with function body.