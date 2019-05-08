# This class containts the necessary functionality for the Sky Level (which is also the easiest/first level).
#
# May 01, 2019
# @version 1.0.0
# @author Chy Lim
# @author Vincent Nguyen

extends Node2D

#------------------------- Directory Paths ------------------------------------#

const SCENE_DIRECTORY = "res://scenes/"
const PLATFORM_SCENE_PATH = SCENE_DIRECTORY + "platforms/"
const PLANK_PATH = PLATFORM_SCENE_PATH + "WaterPlank.tscn"
const NARROW_PLANK_PATH = PLATFORM_SCENE_PATH + "WaterNarrowPlank.tscn"
const WIDE_PLANK_PATH = PLATFORM_SCENE_PATH + "WaterWidePlank.tscn"
const KNIGHT_PLANK_PATH = PLATFORM_SCENE_PATH + "YetiPlank.tscn"
#const WIZARD_PLANK_PATH = PLATFORM_SCENE_PATH + "Plank.tscn"
#const ANUBIS_PLANK_PATH = PLATFORM_SCENE_PATH + "Plank.tscn"
const GAME_DATA_FILE_SAVE = 'res://scores/GAME_DATA_FILE_SAVE-test.save' # Place to save result
const SQL_DATABASE_PATH = "res://scripts/db/Database.gd"

#------------------------- Constants ------------------------------------#

const SPEED = 2
const MEME_TIME_AMOUNT = 33
const DEFAULT_SCORE = 0
const DEFAULT_TIMER_AMOUNT = 0
const DEFAULT_SCORE_INCREMENT = 1
const PLATFORM_TIMER_DELAY = 0.7

const START_PLANK_X = -36
const START_PLANK_Y = -160
const DEFAULT_SCREEN_WIDTH_DIMENSION = 800
const PLANK_SPAWN_Y_MIN_BOUND = 900
const PLANK_SPAWN_Y_MAX_BOUND = 1000
const PLANK_SPAWN_X_MIN_BOUND = 0
const PLANK_SPAWN_X_MAX_BOUND = 500

const SCORE = "SCORE: "
const YOUR_SCORE = "YOUR SCORE: "
const HIGH_SCORE = "HIGH SCORE: "
const GAME_LOADED = "Level 1 loaded!"
const GAME_SAVED = "Progress saved!"
const DATABASE_POINTS_CODE = "sky_points"
const BASE_PLAYER_ID = 1

#------------------------- Adjustable variables #-------------------------#

var back_size
var screen_width = 0
var timer = 0
var score = 0
var max_score = 0
var needs_saving = false
var music_time = 0
var GAME = true
var SAVE = 0

#------------------------- Resources ------------------------------------#

var fs
var planke #Create scene as var
var yeti_plank
#var wizard_plank
#var anubis_plank
var waternarrow_plank
var waterwide_plank
var random_plank_spawner
var database

#------------------------- Functions ------------------------------------#

# Called when the node enters the scene tree for the first time.
func _ready():
	# Load up necessary resources
	fs = File.new()
	planke = preload(PLANK_PATH)
	waternarrow_plank = preload(NARROW_PLANK_PATH)
	waterwide_plank = preload(WIDE_PLANK_PATH)
	yeti_plank = preload(KNIGHT_PLANK_PATH)
	#_plank = preload(WIZARD_PLANK_PATH)
	#_plank = preload(ANUBIS_PLANK_PATH)
	#database = load(SQL_DATABASE_PATH).new()
	
	# Initialize screen dimensions
	#back_size = $Background/background_image.texture.get_size()
	#screen_width = get_viewport().get_visible_rect().size.y
	screen_width = DEFAULT_SCREEN_WIDTH_DIMENSION
	
	# Load save from database
	#max_score = database._get_value(BASE_PLAYER_ID, DATABASE_POINTS_CODE)
	
	# Load save from file
	fs.open(GAME_DATA_FILE_SAVE, File.READ)
	max_score = fs.get_64()
	fs.close()
	
	# Pauses the game (for click to start)
	print(GAME_LOADED)
	get_tree().paused = true

# Saves the player's current score into the database
# Saving result func
func _save_game():
	# Update player save in database
	#database._update(BASE_PLAYER_ID, DATABASE_POINTS_CODE, score)
	
	# Open up save file and makes it writable
	fs.open(GAME_DATA_FILE_SAVE, File.WRITE)
	
	# Stores the player score to be added
	fs.store_64(score)
	
	# Closes the file
	fs.close()
	
	print(GAME_SAVED)

# Physics processing means that the frame rate is synced to the physics, i.e. the delta variable should be constant.
# @param delta Time passed
func _physics_process(delta):
	# Parallax Background
	timer += delta
	
	if timer > PLATFORM_TIMER_DELAY:
		# Generate random plank spawn obj
		#random_plank_spawner = randi() % 3 + 1
		
		# var plank
#		if random_plank_spawner == 1:
#			plank = planke.instance()
#		elif random_plank_spawner == 2:
#			plank = knight_plank.instance()
#		elif random_plank_spawner == 3:
#			plank = wizard_plank.instance()
		
		var plank
		match randi() % 6 + 1:
			1:
				plank = planke.instance()
			2:
				plank = yeti_plank.instance()
			#3:
			#	plank = wizard_plank.instance()
			#4:
			#	plank = anubis_plank.instance()
			5:
				plank = waternarrow_plank.instance()
			6:
				plank = waterwide_plank.instance()
			#_:
				#plank = planke.instance()
		
		#var plank = planke.instance()
		randomize()
		
		plank.position.y = screen_width - rand_range(PLANK_SPAWN_Y_MIN_BOUND, PLANK_SPAWN_Y_MAX_BOUND)
		randomize()
		
		plank.position.x = rand_range(PLANK_SPAWN_X_MIN_BOUND, PLANK_SPAWN_X_MAX_BOUND)
		$Plank.add_child(plank)
	#************ score count ************
		score += DEFAULT_SCORE_INCREMENT
		
		if (score == MEME_TIME_AMOUNT):
			$GameMusic.play()
			
		timer = DEFAULT_TIMER_AMOUNT
	#***********************************
	
	#************ Score and end game print ************
	$GUI/score.text = SCORE + str(score)
	$End_screen/ColorRect/your_score.text = YOUR_SCORE + str(score)
	
	# Checks the score and if it is higher than the one in the database,
	# then the new value replaces the old one.
	if max_score > score:
		needs_saving = false
		$End_screen/ColorRect/max_score.text = HIGH_SCORE + str(max_score)
	else:
		needs_saving = true
		$End_screen/ColorRect/max_score.text = HIGH_SCORE + str(score)
		max_score = score
	#************************************************

# Exits the game
# Exit button proc
func _on_Exit_pressed():
	# Saves game
	if (needs_saving):
		_save_game()
		
	# Exits the game
	get_tree().quit()

# Pauses the game (assuming it is unpaused).
# Pause button proc
func _on_PauseButton_pressed():
	# Checks if music is playing and stops it if it is
	if ($GameMusic/GameMusic.is_playing()):
		music_time = $GameMusic/GameMusic.get_playback_position()
		$GameMusic/GameMusic.stop()
		
		print(music_time)
		print($Start_screen/ColorRect/StartButton/Start_music.get_playback_position())
	
	# Pauses the game
	get_tree().paused = true
	$Pause_screen.show()

# Resumes gameplay (assuming the game is currently paused).
# Resume button proc
func _on_Resume_pressed():
	#music_time = $Start_screen/ColorRect/StartButton/Start_music.get_playback_position()
	#print(music_time)
	#$Start_music/StartSound.play('soundstart')
	
	$Pause_screen.hide()
	get_tree().paused = false

# Resets the level back to the beginning and resumes gameplay.
# Retry button proc
func _on_Retry_pressed():
	# Saves game
	if (needs_saving):
		_save_game()
		
	# Reset current points back to default
	SAVE = DEFAULT_SCORE
	score = DEFAULT_SCORE
	
	# Stop game and show post-defeat screen
	$End_screen.hide()
	$GUI.show()
	
	# Reset start plank to default location
	$StartPlank.timer = DEFAULT_TIMER_AMOUNT
	$StartPlank.position.x = START_PLANK_X
	$StartPlank.position.y = START_PLANK_Y
	
	# Rids previously generated platforms to reset
	for i in $Plank.get_children():
    	i.queue_free()

	# Reveal player at start location (above start plank)
	$Player.show()
	#$Player.global_position.x= -300
	#$Player.global_position.y= 2800
	
	# Resumes playing and unpauses the screen
	GAME = true
	get_tree().paused = false
	$Start_screen/ColorRect/StartButton/Start_music.play()