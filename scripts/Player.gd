extends KinematicBody2D

const SFX_PLAYER_PATH = "./SFXPlayer"
const BOUNCE_SOUND_EFFECT_PATH = "res://assets/audio/sound_effects/player/bounce.wav"

const LEFT_ARROW_CODE = "ui_left"
const RIGHT_ARROW_CODE = "ui_right"

const SPEED = 350
const GRAV = 15
const JUMP = 700

var vel
var sfx_player

func _ready():
	vel = Vector2()
	sfx_player = get_node(SFX_PLAYER_PATH)
	print (global_position)

func _physics_process(delta):
	#************left right buttons************
	if Input.is_action_pressed(LEFT_ARROW_CODE):
		vel.x = -SPEED
	elif Input.is_action_pressed(RIGHT_ARROW_CODE):
		vel.x = SPEED
	else:
		vel.x = 0
	
	vel.y += GRAV
	#************jump when on plank************
	if is_on_floor(): #&& Input.is_action_just_pressed('ui_up'):
		vel.y = -JUMP ;
		
	vel = move_and_slide(vel, Vector2(0, -1))
	
	#************teleport to another side of screen************
	if position.x < -360:
		position.x = 360
	
	if position.x > 360:
		position.x = -360
	
	#************if player falls from screen************
	if position.y > 930:
		print ('fail')
		position.x= 360
		position.y= 700
		vel.y = 0
		$"../../".GAME = false
		get_tree().paused = true
		$"../../End_screen".show()
		$"../../Start_screen/ColorRect/StartButton/Start_music".stop()
		$"../../GameMusic".stop()
		$"../../GUI".hide()
		#if ($"../../".score < $"../../".max_score):
			#$"../../".savegame()

func _on_Area2D_body_entered(other):
	var object_name = other.get_name()
	print("Player collision with " + object_name + "!")

	if(object_name == "Plank"):
		print("*Bounce*")
		_play_sound(BOUNCE_SOUND_EFFECT_PATH)
		
func _play_sound(sound_path):
	sfx_player.stream = load(sound_path)
	sfx_player.play(0.0)