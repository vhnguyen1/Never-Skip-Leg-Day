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

const BUTTON_SFX_PLAYER_PATH = "../ButtonSFXPlayer"
const SETTINGS_PATH = "../SettingsMenu"
const AVATAR_SPRITE_PATH = "../Avatar"
const CLICK_TO_START_PATH = "../ClickText"
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

var paused
var play_button
var settings_button
var quit_button
var button_sfx_player
var is_displaying_splashscreen

#------------------------- Resources ------------------------------------#

var avatar_sprite
var click_text
var settings_menu

#------------------------- Functions ------------------------------------#

# Called when the node enters the scene tree for the first time.
func _ready():
	paused = true;
	is_displaying_splashscreen = true
	settings_menu = get_node(SETTINGS_PATH)
	avatar_sprite = get_node(AVATAR_SPRITE_PATH)
	click_text = get_node(CLICK_TO_START_PATH)
	button_sfx_player = get_node(BUTTON_SFX_PLAYER_PATH)
	
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

func _play_button_sound():
	button_sfx_player.play(0.0)

func _input(event):
	if is_displaying_splashscreen and event.is_pressed() and event.button_index == BUTTON_LEFT:
		_play_button_sound()
		self.visible = true
		avatar_sprite.visible = true
		click_text.visible = false
		get_tree().set_input_as_handled()
		is_displaying_splashscreen = false
	elif !is_displaying_splashscreen and event is InputEventKey and event.is_pressed() and event.scancode == KEY_ESCAPE:
		_play_button_sound()
		self.visible = false
		avatar_sprite.visible = false
		click_text.visible = true
		is_displaying_splashscreen = true
		get_tree().set_input_as_handled()

# Plays the game
func _load_game():
	_play_button_sound()
	self.visible = false
	avatar_sprite.visible = false
	get_tree().change_scene(START_GAME_PATH)

# Opens options probably for instructions on how to play
func _load_options():
	_play_button_sound()
	self.visible = false
	click_text.visible = false
	avatar_sprite.visible = false
	settings_menu.visible = true
	get_tree().set_input_as_handled()

# Quits game || closes the game
func _quit():
	_play_button_sound()
	get_tree().quit()

# Pauses the game
func _pause():
	get_tree().paused = !paused