extends Sprite

var time_elapsed
var time_start

var menu

# Called when the node enters the scene tree for the first time.
func _ready():
	time_start = OS.get_unix_time()
	menu = get_node("../MainMenu")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !menu.visible:
		time_elapsed = OS.get_unix_time()
	
		if time_elapsed % 2 == 1:
			self.visible = false
		else:
			self.visible = true
	
	#var elapsed = time_elapsed - time_start
	#var minutes = elapsed / 60
	#var seconds = elapsed % 60
	#time_elapsed = "%02d : %02d" % [minutes, seconds]
	
	#self.text = "Time: " + time_elapsed
	#print(self.text)