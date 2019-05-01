extends AudioStreamPlayer

func _ready():
	self.connect("finished", self, "_loop")

func _loop():
	self.play(0.0)