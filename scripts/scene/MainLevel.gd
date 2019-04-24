extends Node2D

var platform = preload('res://scenes/mainPlatform.tscn')
var break_platform = preload('res://scenes/break_platform.tscn')
var width 

func _ready():
	width = get_viewport_rect().size.x
	var y = 0
	while y > -30000:
		var new_platform = platform.instance()
		var cloud = break_platform.instance()
		new_platform.set_position(Vector2(rand_range(-width/4,width/4),y))
		cloud.set_position(Vector2(rand_range(-width/3,width/3),y))
		add_child(new_platform)
		add_child(cloud)
		y -= rand_range(0,180)
	pass # Replace with function body.

	