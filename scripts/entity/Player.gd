extends "res://scripts/entity/Entity.gd"

var velocity = Vector2(0,0)

export var jump = 1000.0
export var gravity = 100.0

export var speed = 400.0
export(Curve) var attack_curve
var time_in_attack = 0.0
var current_direction = 0

var time_since_right_pressed = 9999

var animation_sequence = null
var animation_sequence_script = null

const animation_sequence_node_path = "Animations"
const animation_sequence_script_path = "res://scripts/entity/AnimatedSequence.gd"

# Called when the node is added to the scene for the first time.
func _ready():
	animation_sequence = get_node(animation_sequence_node_path)
	animation_sequence_script = load(animation_sequence_script_path).new()

func _process(delta):
	velocity.x = current_direction * speed
	move_and_slide(velocity)
	velocity.x = 0
	velocity.y = 0
	
func _input(event):
	var previous_direction = current_direction
	
	if Input.is_key_pressed(KEY_LEFT) or Input.is_key_pressed(KEY_A):
		current_direction = -1
		animation_sequence.set_flip_h(true)
		animation_sequence.animation = animation_sequence_script.RUNNING
		print("Moving Left.")
	elif Input.is_key_pressed(KEY_RIGHT) or Input.is_key_pressed(KEY_D):
		current_direction = 1
		animation_sequence.set_flip_h(false)
		animation_sequence.animation = animation_sequence_script.RUNNING
		print("Moving Right.")
	elif (Input.is_key_pressed(KEY_UP) or Input.is_key_pressed(KEY_W)): # and is_on_floor()
		velocity.y = -jump
		animation_sequence.animation = animation_sequence_script.JUMPING
		print("Jumping.")
	else:
		current_direction = 0
		if not animation_sequence.animation == animation_sequence_script.JUMPING:
			animation_sequence.animation = animation_sequence_script.DEFAULT