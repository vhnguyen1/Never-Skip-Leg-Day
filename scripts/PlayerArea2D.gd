extends Area2D

const PLAYER_KINEMATIC_BODY_PATH = "./PlayerChar"

var player_kinematic_body

# Called when the node enters the scene tree for the first time.
func _ready():
	player_kinematic_body = get_node(PLAYER_KINEMATIC_BODY_PATH)
	print(player_kinematic_body.get_position())
	self.position = Vector2(293, 599.484009)
	print(self.get_position())
	pass # Replace with function body.

func _process(delta):
	pass