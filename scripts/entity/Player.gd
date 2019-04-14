extends KinematicBody2D

export var jump = 1000.0
export var speed = 400.0
export var gravity = 100.0
export var invincibility_time = 1
export(Curve) var attack_curve

var time_in_attack = 0.0
var current_direction = 0

export var decay_speed_up = 3
var time_since_right_pressed = 9999
var velocity = Vector2(0,0)
var time_since_damage = 9999
var last_direction = 0
var last_time = 0

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	var previous_direction = current_direction
	
	if not is_on_floor():
		velocity.y += gravity*delta
	else:
		velocity.y = 0
	if Input.is_key_pressed(KEY_LEFT) or Input.is_key_pressed(KEY_A):
		current_direction = -1
		last_direction = -1
		
		$PlayerSprite.flip_h = true
		if $PlayerSprite/AnimationPlayer.current_animation != "Walk":
			$PlayerSprite/AnimationPlayer.play("Walk")
	elif Input.is_key_pressed(KEY_RIGHT) or Input.is_key_pressed(KEY_D):
		current_direction = 1
		last_direction = 1
		$PlayerSprite.flip_h = false
		if $PlayerSprite/AnimationPlayer.current_animation != "Walk":
			$PlayerSprite/AnimationPlayer.play("Walk")
	else:
		current_direction = 0
		$PlayerSprite/AnimationPlayer.play("Idle")
	
	if current_direction != previous_direction:
		last_time = time_in_attack
		time_in_attack = 0
	else:
		time_in_attack += delta
		
	if is_on_wall():
		print("hit wall")
	
	if is_on_floor() and Input.is_key_pressed(KEY_UP) or Input.is_key_pressed(KEY_W):
		velocity.y = -jump
		$JumpSound.playing = true
		
	if current_direction == 0:
		velocity.x = last_direction*speed*attack_curve.interpolate(last_time-time_in_attack*decay_speed_up)
	else:	
		velocity.x = last_direction*speed*attack_curve.interpolate(time_in_attack)
	
	move_and_slide(velocity,Vector2(0,-1))
	
	if time_since_damage <= invincibility_time:
		time_since_damage += delta
		# Halve opacity every uneven frame counts
		self.modulate.a = 0.15 if Engine.get_frames_drawn() % 8 < 4 else 1.0
	else:
		self.modulate.a = 1.0
	
func hit():
	if time_since_damage > invincibility_time:
		time_since_damage = 0
		print("OW")

func _on_HurtBox_area_entered(area):
	if area.is_in_group("enemy"):
		if velocity.y > 30:
			
			area.get_parent().hit()
		else:
			hit()
	