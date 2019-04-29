extends MarginContainer

#Commented out because the playbutton as of this time only changes the scene where the anumbis guy is swinging scepter
#--------------------------------------------------------#

#const start_game_path = "res://scenes/TestScene.tscn" 

#-------------------------------------------------------------#

var paused = true;
# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/MenuOptions/PlayButton.connect("pressed", self, "_load_game")
	$VBoxContainer/MenuOptions/SettingsButton.connect("pressed", self, "_load_options")
	$VBoxContainer/MenuOptions/QuitButton.connect("pressed", self, "_quit")
	$VBoxContainer/MenuOptions/Pause.connect("pressed", self, "_pause")
func _process(delta):
	pass
	
# Plays the game
##################Change the scene to the one that you guys are working on###################
func _load_game():
	#get_tree().change_scene(start_game_path)
	pass
	
#pauses game
func _pause():
	if(paused == true):
		get_tree().paused = paused
		paused = false
	elif(paused == false):
		get_tree().paused = paused
		paused = true

# Opens options probably for instructions on how to play
func _load_options():
	get_tree().change_scene("res://scenes/Setting.tscn")
	pass
	
# quits game || closes the game
func _quit():
	get_tree().quit()