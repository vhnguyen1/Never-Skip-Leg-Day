extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	#set_fixed_process(true)
	#self.get_global_mouse_pos()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input_event(viewport, event, shape_idx):
	if event.type == InputEvent.MOUSE_BUTTON \
	and event.button_index == BUTTON_LEFT \
	and event.pressed:
		print("Clicked")