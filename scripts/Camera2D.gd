extends Camera2D

const POINTS_LABEL_Y_ADDITIONAL_OFFSET = -600
const PAUSE_BUTTON_Y_ADDITIONAL_OFFSET = -600

#export(NodePath) var player_path
const PLAYER_PATH = "../Player/PlayerChar"
const POINTS_LABEL_PATH = "../GUI/score"
const PAUSE_BUTTON_PATH = "../GUI/PauseButton"

var player
var points_label
var pause_button

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node(PLAYER_PATH)
	points_label = get_node(POINTS_LABEL_PATH)
	pause_button = get_node(PAUSE_BUTTON_PATH)
	set_process(true)

func _process(delta):
	var player_y = player.get_position().y
	
	if player_y <= get_position().y:
		set_position(Vector2(0, player_y))
		points_label.set_position(Vector2(points_label.get_position().x, _get_camera_center().y + POINTS_LABEL_Y_ADDITIONAL_OFFSET))
		pause_button.set_position(Vector2(pause_button.get_position().x, _get_camera_center().y + PAUSE_BUTTON_Y_ADDITIONAL_OFFSET))
		
func _get_camera_center():
    var vtrans = get_canvas_transform()
    var top_left = -vtrans.get_origin() / vtrans.get_scale()
    var vsize = get_viewport_rect().size
    return top_left + 0.5*vsize/vtrans.get_scale()