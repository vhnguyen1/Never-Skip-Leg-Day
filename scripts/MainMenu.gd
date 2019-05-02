# This class containts the necessary functionality for the Main Menu.
#
# May 01, 2019
# @version 1.0.0
# @author Miguel Menjivar
# @author Andres Guerrero
# @author Vincent Nguyen

extends MarginContainer

#------------------------- Directory Paths ------------------------------------#

const STAGE_PATH = "res://scenes/stages/"
const START_GAME_PATH = STAGE_PATH + "SkyLevel.tscn"
const SETTINGS_PATH = STAGE_PATH + "Settings.tscn"

const VBOX_MENU_OPTIONS_PATH = "./VBoxContainer/MenuOptions/"
const VBOX_MENU_OPTIONS_PLAY_BUTTON_PATH = VBOX_MENU_OPTIONS_PATH + "PlayButton"
const VBOX_MENU_OPTIONS_SETTINGS_BUTTON_PATH = VBOX_MENU_OPTIONS_PATH + "SettingsButton"
const VBOX_MENU_OPTIONS_QUIT_BUTTON_PATH = VBOX_MENU_OPTIONS_PATH + "QuitButton"

#------------------------- Constants ------------------------------------#

const PRESSED_CODE = "pressed"
const LOAD_GAME_FUNCTION_NAME = "_load_game"
const LOAD_OPTIONS_FUNCTION_NAME = "_load_options"
const QUIT_FUNCTION_NAME = "_quit"
const PAUSE_GAME_FUNCTION_NAME = "_pause"

#------------------------- Adjustable Variables ------------------------------------#

var paused = true;
var play_button
var settings_button
var quit_button

#------------------------- Functions ------------------------------------#

# Called when the node enters the scene tree for the first time.
func _ready():
	# Link play button to the level scenes
	play_button = get_node(VBOX_MENU_OPTIONS_PLAY_BUTTON_PATH)
	play_button.connect(PRESSED_CODE, self, LOAD_GAME_FUNCTION_NAME)
	
	# Link settings button to the options menu
	settings_button = get_node(VBOX_MENU_OPTIONS_SETTINGS_BUTTON_PATH)
	settings_button.connect(PRESSED_CODE, self, LOAD_OPTIONS_FUNCTION_NAME)
	
	# Link quit button to exit the game
	quit_button = get_node(VBOX_MENU_OPTIONS_QUIT_BUTTON_PATH)
	quit_button.connect(PRESSED_CODE, self, QUIT_FUNCTION_NAME)
	
	#$VBoxContainer/MenuOptions/PlayButton.connect(PRESSED_CODE, self, LOAD_GAME_FUNCTION_NAME)
	#$VBoxContainer/MenuOptions/SettingsButton.connect(PRESSED_CODE, self, LOAD_OPTIONS_FUNCTION_NAME)
	#$VBoxContainer/MenuOptions/QuitButton.connect(PRESSED_CODE, self, QUIT_FUNCTION_NAME)
	#$VBoxContainer/MenuOptions/Pause.connect(PRESSED_CODE, self, PAUSE_GAME_FUNCTION_NAME)

# Plays the game
func _load_game():
	get_tree().change_scene(START_GAME_PATH)

# Opens options probably for instructions on how to play
func _load_options():
	get_tree().change_scene(SETTINGS_PATH)

# Quits game || closes the game
func _quit():
	get_tree().quit()

# Pauses the game
func _pause():
	get_tree().paused = !paused