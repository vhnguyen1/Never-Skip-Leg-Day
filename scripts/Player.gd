extends KinematicBody2D

signal death

const DEFAULT_ENEMY_CODE = "enemy"
const DEFAULT_HIT_CODE = "hit"

export (NodePath) var visibility_notifier_path
onready var visibility_notifier = get_node("visibility_notifier_path")

const LEFT_ARROW_CODE = "ui_left"
const RIGHT_ARROW_CODE = "ui_right"

const SPEED = 250
const GRAV = 15
const JUMP = 500

var vel = Vector2()
var collision

func _ready():
	#print (global_position)
	pass

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
	if position.x < -350:
		position.x = 350
	
	if position.x > 350:
		position.x = -350
	
	collision = move_and_collide(vel * delta)	#calculate the collision if hit enemy 
	#************if player falls from screen************
#	#if position.y > 930:
#		print ('fail')
#		position.x= 360
#		position.y= 700
#		vel.y = 0
#		$"../../".GAME = false
#		get_tree().paused = true
#		$"../../End_screen".show()
#		$"../../Start_screen/ColorRect/StartButton/Start_music".stop()
#		$"../../GameMusic".stop()
#		$"../../GUI".hide()
#		#if ($"../../".score < $"../../".max_score):
#			#$"../../".savegame()

func _on_VisibilityNotifier2D_screen_exited():
	if position.y < 0:
		print("going up")
	if position.y > -750:
		print("going down")
		emit_signal("death")

func _on_PlayerChar_death():
	position.x= 360
	position.y= 700
	
	if global_position.y > 835:
		print ('Death')
		position.x= 0
		position.y= 30
		vel.y = 0
		$"../../".GAME = false
		get_tree().paused = true
		$"../../End_screen".show()
		$"../../Start_screen/ColorRect/StartButton/Start_music".stop()
		$"../../GameMusic".stop()
		$"../../GUI".hide()
		
		#if ($"../../".score < $"../../".max_score):
			#$"../../".savegame()

#func _on_PlayerChar_death():
#	position.x= 293
#	position.y= 593
#	vel.y = 0
#	$"../../".GAME = false
#	get_tree().paused = true
#	$"../../End_screen".show()
#	$"../../Start_screen/ColorRect/StartButton/Start_music".stop()
#	$"../../GameMusic".stop()
#	$"../../GUI".hide()

func _on_Player_area_entered(area):
	if area.is_in_group(DEFAULT_ENEMY_CODE):
		vel = vel.bounce(collision.normal)
		if collision.collider.has_method(DEFAULT_HIT_CODE):
			collision.collider.hit()
			print("hit!")
			$CollisionShape2D.disabled = false