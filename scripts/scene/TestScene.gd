extends Node2D

const database_script_path = "res://scripts/misc/Database.gd"
var database = null

# Called when the node enters the scene tree for the first time.
func _ready():
	database = load(database_script_path).new()
	database._update(1, "time_1", "1")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(database.m_num_profiles_rows)
	database._print_all_rows()
	pass