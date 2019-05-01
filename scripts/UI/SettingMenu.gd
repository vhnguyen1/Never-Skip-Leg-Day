extends MarginContainer

const start_game_path = "res://scenes/MainMenu.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/MenuOptions/BackButton.connect("pressed", self, "_main_menu")
	$VBoxContainer/MenuOptions/SettingsButton.connect("pressed", self, "_load_options")
	$VBoxContainer/MenuOptions/QuitButton.connect("pressed", self, "_quit")
	#Music.play()
func _process(delta):
	pass

# Plays the game
func _main_menu():
	get_tree().change_scene(start_game_path)

# Opens options probably for instructions on how to play
func _load_options():
	#get_tree().change_scene("res://scenes/Setting.tscn")
	pass

# quits game || closes the game
func _quit():
	get_tree().quit()