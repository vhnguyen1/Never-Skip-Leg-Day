# Entity.gd
# @version 1.0.0
# @author Vincent Nguyen
#
# Parent class that all other character/entity objects will inherit from.
# Base visual assets: Anubis
# Base audio assets: Dog

extends KinematicBody2D

var m_name = null	# Entity name
var m_health = 100	# Health Points (HP)
var m_attack = 1	# Attack Power (AP)

# Plays various sound effects that the entity uses.
var m_sfx_player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	# Overrides the on_body_enter method
	self.m_name = self.get_name()
	
	connect("body_enter", self, "_on_body_enter")
	set_process(true)
	
	# Initialize AudioStreamPlayer2D
	self.m_sfx_player = get_node("./SFXPlayer")
	
	# Informs console when Entity is created.
	print(self.m_name + " has spawned!")

# Called every frame.
# @param delta The elapsed time since the previous frame.
func _process(delta):
	pass
	
# Collision detection
func _on_body_enter(other):
	print(self.m_name + " collision with " + other.get_name())
	
	if(other.is_in_group("enemy")):
		self._damage(other.m_attack())
	
# Plays a given sound effect.
# @param path The sound file path.
func _play_sound_effect(path):
	self.m_sfx_player.stream = load(path)
	self.m_sfx_player.play(0.0)
	
func _damage(amount):
	self.m_health -= amount
	
# Returns a String representation of the Entity.
# @returns The String representation of the Entity.
func to_string():
	return "Name: " + self.m_name + "\nHealth: " + self.m_health + "\nAttack: " + self.m_attack
	
# Prints a String representation of the Entity to the console.
func console():
	print(self.to_string())