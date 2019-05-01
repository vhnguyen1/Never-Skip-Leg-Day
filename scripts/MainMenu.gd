# This class containts the necessary functionality for the Main Menu.
#
# May 01, 2019
# @version 1.0.0
# @author Miguel Menjivar
# @author Andres Guerrero

extends MarginContainer

#------------------------- Directory Paths ------------------------------------#

const STAGE_PATH = "res://scenes/stages/"
const START_GAME_PATH = STAGE_PATH + "Level_1.tscn"
const SETTINGS_PATH = STAGE_PATH + "Settings.tscn"

const LOAD_GAME_FUNCTION_NAME = "_load_game"
const LOAD_OPTIONS_FUNCTION_NAME = "_load_options"
const QUIT_FUNCTION_NAME = "_quit"
const PAUSE_GAME_FUNCTION_NAME = "_pause"

#------------------------- Constants ------------------------------------#

const PRESSED_CODE = "pressed"

#------------------------- Adjustable Variables ------------------------------------#

var paused = true;

#------------------------- Functions ------------------------------------#

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/MenuOptions/PlayButton.connect(PRESSED_CODE, self, LOAD_GAME_FUNCTION_NAME)
	$VBoxContainer/MenuOptions/SettingsButton.connect(PRESSED_CODE, self, LOAD_OPTIONS_FUNCTION_NAME)
	
	# Change these to NODE ON BUTTON CLICK later, so as to be able to keep track of music time elapsed	
	$VBoxContainer/MenuOptions/QuitButton.connect(PRESSED_CODE, self, QUIT_FUNCTION_NAME)
	$VBoxContainer/MenuOptions/Pause.connect(PRESSED_CODE, self, PAUSE_GAME_FUNCTION_NAME)
	
# Plays the game
func _load_game():
	get_tree().change_scene(START_GAME_PATH)
	
# Pauses game
func _pause():
	get_tree().paused = !paused

# Opens options probably for instructions on how to play
func _load_options():
	get_tree().change_scene(SETTINGS_PATH)
	
# Quits game || closes the game
func _quit():
	get_tree().quit()