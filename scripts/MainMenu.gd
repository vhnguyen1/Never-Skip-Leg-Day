extends MarginContainer

#Commented out because the playbutton as of this time only changes the scene where the anumbis guy is swinging scepter
#--------------------------------------------------------#

const STAGE_PATH = "res://scenes/stages/"
const START_GAME_PATH = STAGE_PATH + "Level_1.tscn"
const SETTINGS_PATH = STAGE_PATH + "Settings.tscn"

const PRESSED_CODE = "pressed"

#-------------------------------------------------------------#

var paused = true;

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/MenuOptions/PlayButton.connect(PRESSED_CODE, self, "_load_game")
	$VBoxContainer/MenuOptions/SettingsButton.connect(PRESSED_CODE, self, "_load_options")
	$VBoxContainer/MenuOptions/QuitButton.connect(PRESSED_CODE, self, "_quit")
	$VBoxContainer/MenuOptions/Pause.connect(PRESSED_CODE, self, "_pause")
	
# Plays the game
##################Change the scene to the one that you guys are working on###################
func _load_game():
	get_tree().change_scene(START_GAME_PATH)
	
#pauses game
func _pause():
	get_tree().paused = !paused

# Opens options probably for instructions on how to play
func _load_options():
	get_tree().change_scene(SETTINGS_PATH)
	
# quits game || closes the game
func _quit():
	get_tree().quit()