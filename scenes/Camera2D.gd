extends Camera2D

export(NodePath) var Player
var player

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node(Player)
#	self.limit_bottom = 2000
#	self.limit_left = 0
#	self.limit_right = 2000
	pass # Replace with function body.