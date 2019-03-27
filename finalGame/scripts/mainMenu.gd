extends MarginContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	#$HBoxContainer/VBoxContainer/menuOptions/btn_playGame.connect("pressed", self, "playClone")
	#$HBoxContainer/VBoxContainer/menuOptions/btn_Options.connect("pressed", self, "playVariant")
	$HBoxContainer/VBoxContainer/menuOptions/btn_Quit.connect("pressed", self, "playQuit")

# Plays the game
func playGame():
	#get_tree().change_scene("res://scenes/Clone.tscn")
	pass

# Opens options probably for instructions on how to play
func playOptions():
	#get_tree().change_scene("res://scenes/Variant.tscn")
	pass
	
# quits game || closes the game
func playQuit():
	get_tree().quit()
	pass