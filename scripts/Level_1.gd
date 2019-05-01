extends Node

const SFX_PLAYER_PATH = "./SFXPlayer"
const PLATFORM_SCENE_PATH = "res://scenes/platforms/"
const PLANK_PATH = PLATFORM_SCENE_PATH + "Plank.tscn"

const SPEED = 2

#************some numbers here************

var back_size
var screenW = 0
var timer = 0
var score = 0
var max_score = 0
var need_save = false
var gamedata = 'user://gamedata-test.save' #Place to save result

var GAME = true
var SAVE = 0

var fs
var planke # Create scene as var

func _ready():
	fs = File.new()
	planke = preload(PLANK_PATH)
	
#	back_size = $Background/background_image.texture.get_size()
#	screenW = get_viewport().get_visible_rect().size.y
	#screenW = 920
	back_size = $Node2D/Sprite.texture.get_size()
	screenW = get_viewport().get_visible_rect().size.y
	
	
	#************loading save from file************
	fs.open(gamedata, File.READ)
	max_score = fs.get_64()
	fs.close()
	#**********************************************
	
	print ("loaded")
	get_tree().paused = true
	
	#************saving result func************
func savegame():
	fs.open(gamedata, File.WRITE)
	fs.store_64(score)
	fs.close()
	print('saved')
	#******************************************

func _physics_process(delta):
	#************moving backgroung************
	timer += delta
	#*****************************************
	
	
	if timer > 0.7:
	#************falling obj************
		var plank = planke.instance()
		randomize()
		plank.position.y = screenW - rand_range(760, 860)
		randomize()
		plank.position.x = rand_range(30, 530)
		$planks.add_child(plank)
	#************score count************
		score += 1
		if (score == 33):
			$GameMusic.play()
		timer = 0
	#***********************************
	
	#************score and end game print************
	$GUI/score.text = 'SCORE: ' + str(score)
	$End_screen/ColorRect/your_score.text = 'YOUR SCORE: ' + str(score)
	if max_score > score:
		need_save = false
		
		$End_screen/ColorRect/max_score.text = 'HIGH SCORE: ' + str(max_score)
	else:
		need_save = true
		
		$End_screen/ColorRect/max_score.text = 'HIGH SCORE: ' + str(score)
		max_score = score
	#************************************************
	
#************exit btn proc************
func _on_Exit_pressed():
	if (need_save):
		savegame()
	get_tree().quit()

#************pause btn proc************
func _on_PauseButton_pressed():
	if ($GameMusic/GameMusic.is_playing() == true):
		$GameMusic/GameMusic.stop()
	get_tree().paused = true
	$Pause_screen.show()

#************resume btn proc************
func _on_Resume_pressed():
	$Pause_screen.hide()
	get_tree().paused = false

#************retry btn proc************
func _on_Retry_pressed():
	if (need_save):
		savegame()
	SAVE = 0
	score = 0
	$End_screen.hide()
	$GUI.show()
	#timer = 0
	$StartPlank.timer=0
	$StartPlank.position.x=330
	$StartPlank.position.y=850
	for i in $planks.get_children():
    	i.queue_free()
	
	#$Player.global_position.x=-300
	#$Player.global_position.y= 2800
	GAME = true
	get_tree().paused = false
	$Start_screen/ColorRect/StartButton/Start_music/StartSound.play('soundstart')
	
func _play_sound(sound_path):
	sfx_player.stream = load(sound_path)
	sfx_player.play(0.0)