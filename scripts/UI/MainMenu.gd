extends ParallaxBackground

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#$HBoxContainer/VBoxContainer/MenuOptions/btn_playGame.connect("pressed", self, "playClone")
	#$HBoxContainer/VBoxContainer/MenuOptions/btn_Options.connect("pressed", self, "playVariant")
	#$VBoxContainer/MenuOptions/PlayButton.connect("pressed", self, "playQuit")

func _process(delta):
	$ParallaxLayer.motion_offset.x -= 0.5
	
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