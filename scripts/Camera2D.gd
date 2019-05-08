extends Camera2D



# Called when the node enters the scene tree for the first time.
func _ready():
	self.limit_left = 0
	self.limit_right = 5000
	self.limit_bottom = 735
	set_process(true)