# Entity.gd
# @version 1.0.0
# @author Vincent Nguyen
#
# Parent class that all other character/entity objects will inherit from.
# Base visual assets: Anubis
# Base audio assets: Dog

extends KinematicBody2D

# Constants
const COLLISION_KEY = "body_enter"
const COLLISION_OVERRIDE_NAME = "_on_body_enter"
const PLAYER_CLASSIFIER = "player"
const SFX_PATH = "./SFXPlayer"
const DEFAULT_START = 0.0

# Member Variables
var m_name	# Entity name
var m_sfx_player# Plays various sound effects that the entity uses.

# Called when the node enters the scene tree for the first time.
func _ready():
	self.m_name = self.get_name()
	
	# Overrides the on_body_enter method
	connect(COLLISION_KEY, self, COLLISION_OVERRIDE_NAME)
	set_process(true)
	
	# Initializes the AudioStreamPlayer2D
	self.m_sfx_player = get_node(SFX_PATH)
	
	# Informs the console when Entity is created.
	print(self.m_name + " has spawned!")

# Called every frame.
# @param delta The elapsed time since the previous frame.
func _process(delta):
	pass
	
# Collision detection
func _on_body_enter(other):
	print(self.m_name + " collision with " + other.get_name())
	
	if(other.is_in_group(PLAYER_CLASSIFIER)):
		other.is_dead = true
	
# Plays a given sound effect.
# @param path The sound file path.
func _play_sound_effect(path):
	self.m_sfx_player.stream = load(path)
	self.m_sfx_player.play(DEFAULT_START)
	
# Returns a String representation of the Entity.
# @returns The String representation of the Entity.
func _to_string():
	return "Name: " + self.m_name + "\nHealth: " + self.m_health + "\nAttack: " + self.m_attack
	
# Prints a String representation of the Entity to the console.
func _console():
	print(self._to_string())