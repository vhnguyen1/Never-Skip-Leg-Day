extends MarginContainer

const start_game_path = "res://scenes/MainMenu.tscn"
var clicked = true
# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/MenuOptions/BackButton.connect("pressed", self, "_main_menu")
	$VBoxContainer/MenuOptions/FullscreenButton.connect("pressed", self, "_load_fullscreen")
	$VBoxContainer/MenuOptions/MusicButton.connect("pressed", self, "_music")
func _process(delta):
	pass
# Goes back to main menu
func _main_menu():
	get_tree().change_scene(start_game_path)

# enables/disables fullscreen
func _load_fullscreen():
 	   OS.window_fullscreen = !OS.window_fullscreen
# starts stops main music
func _music():
	if( clicked == true):
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), true)
		clicked = false
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), false)
		clicked = true