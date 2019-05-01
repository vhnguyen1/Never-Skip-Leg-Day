extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Collision detection
func _on_body_enter(other):
	print(self.m_name + " collision with " + other.get_name())
	# if self.getName() == "GoldCoin" points += GOLD_POINTS_BONUS: