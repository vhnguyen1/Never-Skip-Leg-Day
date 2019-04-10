extends Sprite

func _ready():
  #draw in the middle of the screen
  position = Vector2(get_viewport().size.x/2,get_viewport().size.y/2)
  
  #scale to 30%
  scale = Vector2(0.3,0.3)
  
  #rotate by 90degrees
  rotate(deg2rad(90))
  
  set_process(false)
  
func _process(delta):
  # each frame rotate by 90deg/sec
  rotation = self.rotation + deg2rad(90.0 * delta)
  
  # move left by 100 pixels / sec
  # once you go off left side of screen, jump to the right
  translate(Vector2(-100*delta,0))
  if(position.x < 0):
    position = Vector2(get_viewport().size.x, get_viewport().size.y/2)