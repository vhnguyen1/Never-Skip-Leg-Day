extends "res://scripts/Enemy.gd"

var player = null
var enemy_to_player

var fov_range = 10
var direction = 1

# Called when the node enters the scene tree for the first time.
func _ready():
#	enemy_to_player = player.translation - self.translation
	
#	if enemy_to_player.length() < fov_range:
#		if acos(enemy_to_player.normalized().dot(direction)) < FOV:
#			#Next step awaits.
#			$DetectionRay.cast_to = enemy_to_player
#			if $RayCast2D.is_colliding():
#				if $RayCast2D.get_collider() == Player:
#					#Do what ever you do when a player is detected
#					pass
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass