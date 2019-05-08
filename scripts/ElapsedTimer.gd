extends Sprite

var time_elapsed
var time_start

var main_menu
var settings_menu

# Called when the node enters the scene tree for the first time.
func _ready():
	time_start = OS.get_unix_time()
	main_menu = get_node("../MainMenu")
	settings_menu = get_node("../SettingsMenu")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !main_menu.visible and !settings_menu.visible:
		time_elapsed = OS.get_unix_time()
	
		if time_elapsed % 2 == 1:
			self.visible = false
		else:
			self.visible = true