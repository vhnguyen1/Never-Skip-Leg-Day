extends VideoPlayer

var STATUS

func _ready():
	play()
	
func _physics_process(delta):
	STATUS = is_playing()
	
	if !STATUS:
		$"../../".hide()