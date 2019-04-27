extends Camera2D

export(NodePath) var mainPlayer_path
var mainplayer

# Called when the node enters the scene tree for the first time.
func _ready():
	mainplayer = get_node(mainPlayer_path)
	set_process(true)
	pass # Replace with function body.

func _process(delta):
	var player_y = mainplayer.get_position().y
	if player_y <= get_position().y:
		set_position(Vector2(0, player_y))
	pass