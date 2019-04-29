extends MarginContainer

const start_game_path = "res://stages/Level_1.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	$MenuOptions/PlayButton.connect("pressed", self, "_load_game")
	$MenuOptions/SettingsButton.connect("pressed", self, "_load_options")
	$MenuOptions/QuitButton.connect("pressed", self, "_quit")
	#Music.play()
func _process(delta):
	pass

# Plays the game
func _load_game():
	get_tree().change_scene(start_game_path)

# Opens options probably for instructions on how to play
func _load_options():
	get_tree().change_scene("res://scenes/Setting.tscn")
	pass

# quits game || closes the game
func _quit():
	get_tree().quit()