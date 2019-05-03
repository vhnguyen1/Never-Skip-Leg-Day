extends StaticBody2D

const PLANK_TIME_CAP = 7

var timer = 0

func _physics_process(delta):
	#************falling************
	timer += delta
	position.y += delta * 25
	#************teleport offscreen************
	if timer > PLANK_TIME_CAP:
		global_position.x = 1000
		global_position.y = 1000