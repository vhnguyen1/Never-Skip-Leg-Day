extends Node2D

var platform = preload('res://objects/platform/Platform.tscn')
var width 

func _ready():
	width = get_viewport_rect().size.x
	#width = get_viewport().get_rect().size.x
	var y = 0
	while y > -3000:
		var new_platform = platform.instance()
		new_platform.set_position(Vector2(rand_range(-width/2,width/2),y))
		add_child(new_platform)
		y -= rand_range(0,210)
	pass # Replace with function body.
