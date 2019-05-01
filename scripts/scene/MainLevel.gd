extends Node2D

var platform = preload('res://objects/platform/Platform.tscn')
var platform_extra = preload('res://objects/platform/Platform2.tscn')
#var break_platform = preload('res://scenes/break_platform.tscn')
var width 

# game window is (1280 x 720)
func _ready():
	width = get_viewport_rect().size.x
	var x = -200 #initial platform under character
	var y = 0
	var y2 = 200
	
	var possible_platform #platforms that can always be jumped to
	var platform2  #extra platforms for variety, not always possible to jump to
	while y > -30000:
		possible_platform = platform.instance()
		platform2 = platform_extra.instance()
		possible_platform.set_position(Vector2(x,y))
		platform2.set_position(Vector2(rand_range(-width/2, width/2),y2))
		add_child(possible_platform)
		add_child(platform2)
		x = rand_range(x-400,x+400) # max horizontal travel distance somewhere around 400
		while(x < (-width/2)+100 or x > (width/2)-100):
			x = rand_range(x-400,x+400)
		y -= rand_range(50,220) # max jump is ~230 right now
		y2 -= rand_range(300, 700)
		
	pass # Replace with function body.