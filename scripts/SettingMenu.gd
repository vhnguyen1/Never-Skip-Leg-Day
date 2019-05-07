extends MarginContainer

const MAIN_MENU_PATH = "../MainMenu"
const AVATAR_SPRITE_PATH = "../Avatar"
const CLICK_TO_START_PATH = "../ClickText"

var clicked = true
var main_menu
var avatar
var click_text

# Called when the node enters the scene tree for the first time.
func _ready():
	main_menu = get_node(MAIN_MENU_PATH)
	avatar = get_node(AVATAR_SPRITE_PATH)
	click_text = get_node(CLICK_TO_START_PATH)
	click_text.visible = false
		
	$VBoxContainer/MenuOptions/BackButton.connect("pressed", self, "_main_menu")
	$VBoxContainer/MenuOptions/FullscreenButton.connect("pressed", self, "_load_fullscreen")
	$VBoxContainer/MenuOptions/MusicButton.connect("pressed", self, "_music")

# Goes back to main menu
func _main_menu():
	self.visible = false
	click_text.visible = false
	main_menu.visible = true
	avatar.visible = true

# enables/disables fullscreen
func _load_fullscreen():
	OS.window_fullscreen = !OS.window_fullscreen

# starts stops main music
func _music():
	if(clicked):
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
		clicked = false
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
		clicked = true