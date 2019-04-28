extends RichTextLabel

var time_elapsed = 0
var time_start = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	time_start = OS.get_unix_time()
	print("Timer Started!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_elapsed = OS.get_unix_time()
	var elapsed = time_elapsed - time_start
	var minutes = elapsed / 60
	var seconds = elapsed % 60
	time_elapsed = "%02d : %02d" % [minutes, seconds]
	
	self.text = "Time: " + time_elapsed
	#print(self.text)