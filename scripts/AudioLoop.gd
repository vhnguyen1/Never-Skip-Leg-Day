extends AudioStreamPlayer

const FINISHED_CODE = "finished"

func _ready():
	self.connect(FINISHED_CODE, self, "_loop")

func _loop():
	self.play(0.0)