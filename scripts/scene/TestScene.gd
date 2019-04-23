extends Node2D

const database_script_path = "res://scripts/misc/Database.gd"
var database = null

# Called when the node enters the scene tree for the first time.
func _ready():
	database = load(database_script_path).new()
	#database._update(1, "points", "132")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#database = load(database_script_path).new()
	#print(database.m_num_profiles_rows)
	#database._print_all_rows()
	print(database._get_value(1, database.PROFILES_BEST_LEVEL_1_SCORE_FIELD_NAME))
	pass