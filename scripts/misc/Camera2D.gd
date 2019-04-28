extends Camera2D

#export(NodePath) var player_path
const PLAYER_PATH = "../Player"
const POINTS_LABEL_PATH = "../Points"
const TIME_LABEL_PATH = "../Time"

const POINTS_LABEL_X_OFFSET = -250
const POINTS_LABEL_Y_ADDITIONAL_OFFSET = -125
const TIME_LABEL_X_OFFSET = 1050
const TIME_LABEL_Y_ADDITIONAL_OFFSET = -125

var player = null
var points_label = null
var time_label = null

# Called when the node enters the scene tree for the first time.
func _ready():
	#player = get_node(player_path)
	player = get_node(PLAYER_PATH)
	points_label = get_node(POINTS_LABEL_PATH)
	time_label = get_node(TIME_LABEL_PATH)
	set_process(true)

func _process(delta):
	var player_y = player.get_position().y
	
	if player_y <= get_position().y:
		set_position(Vector2(0, player_y))
		points_label.set_position(Vector2(POINTS_LABEL_X_OFFSET, player_y + POINTS_LABEL_Y_ADDITIONAL_OFFSET))
		time_label.set_position(Vector2(TIME_LABEL_X_OFFSET, player_y + TIME_LABEL_Y_ADDITIONAL_OFFSET))