extends Camera2D

#export(NodePath) var player_path
const PLAYER_PATH = "../Player"

var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	#player = get_node(player_path)
	player = get_node(PLAYER_PATH)
	set_process(true)

func _process(delta):
	var player_y = player.get_position().y
	
	if player_y <= get_position().y:
		set_position(Vector2(0, player_y))