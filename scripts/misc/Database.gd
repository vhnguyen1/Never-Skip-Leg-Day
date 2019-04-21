extends Node

# Database Field Names
const USER_DATABASE_TABLE_NAME = "profiles"
const USER_ID_FIELD_NAME = "id"
const USER_ID_MAX_LEVEL_REACHED_FIELD_NAME = "level"
const USER_ID_BEST_LEVEL_1_TIME_FIELD_NAME = "time_1"
const USER_ID_BEST_LEVEL_2_TIME_FIELD_NAME = "time_2"
const USER_ID_BEST_LEVEL_3_TIME_FIELD_NAME = "time_3"
const USER_ID_BEST_LEVEL_4_TIME_FIELD_NAME = "time_4"
const USER_ID_BEST_LEVEL_5_TIME_FIELD_NAME = "time_5"

# SQL key terms
const CREATE_TABLE_IF_NOT_EXISTS = "CREATE TABLE IF NOT EXISTS "
const INTEGER_PRIMARY_KEY = " integer PRIMARY KEY,"
const INTEGER = " integer,"
const TEXT_NOT_NULL = " text NOT NULL,"
const SELECT_FROM = "SELECT * FROM "
const INSERT_INTO = "INSERT INTO "
const VALUES = " ) VALUES ( "

# Database Field Name Array
const m_profiles_field_names = [USER_ID_FIELD_NAME, USER_ID_MAX_LEVEL_REACHED_FIELD_NAME, USER_ID_BEST_LEVEL_1_TIME_FIELD_NAME, USER_ID_BEST_LEVEL_2_TIME_FIELD_NAME, USER_ID_BEST_LEVEL_3_TIME_FIELD_NAME, USER_ID_BEST_LEVEL_4_TIME_FIELD_NAME, USER_ID_BEST_LEVEL_5_TIME_FIELD_NAME]

# Database Field Type Array (which corresponds to the Field Name Array)
const m_profiles_field_types = [INTEGER_PRIMARY_KEY, INTEGER, TEXT_NOT_NULL, TEXT_NOT_NULL, TEXT_NOT_NULL, TEXT_NOT_NULL, TEXT_NOT_NULL]

# Number of rows stored in the database
var m_num_profiles_rows = 0

# Default filed values
const DEFAULT_LEVEL = 0
const DEFAULT_TIME = "00:00"

# Error and confirmation prompts/messages
const ERROR_MESSAGE = "ERROR: Cannot open database!"
const ERROR_INSERT = "Error: Cannot insert data!"
const ERROR_MISMATCHED_FIELDS = "Error: Field amounts do not match to insert row!"
const ERROR_OPEN_RESULT = null
const ERROR_RESULT = 0
const CONFIRMATION_MESSAGE = "Data inserted into table."

# Resource paths
const DATABASE_INSTANCE_PATH = "res://lib/gdsqlite.gdns"
const DATABASE_PATH = "res://godot.sql"

# SQLite module
const SQLite = preload(DATABASE_INSTANCE_PATH)

# Called when the node enters the scene tree for the first time.
func _ready():
	# Setup and intialize Database
	var db = _initialize_db()
	if (!db):
		return
	
	# Create table
	var query = CREATE_TABLE_IF_NOT_EXISTS + USER_DATABASE_TABLE_NAME + " ("
	#query += USER_ID_FIELD_NAME + INTEGER_PRIMARY_KEY
	#query += USER_ID_MAX_LEVEL_REACHED_FIELD_NAME + INTEGER
	#query += USER_ID_BEST_LEVEL_1_TIME_FIELD_NAME + TEXT_NOT_NULL
	#query += USER_ID_BEST_LEVEL_2_TIME_FIELD_NAME + TEXT_NOT_NULL
	#query += USER_ID_BEST_LEVEL_3_TIME_FIELD_NAME + TEXT_NOT_NULL
	#query += USER_ID_BEST_LEVEL_4_TIME_FIELD_NAME + TEXT_NOT_NULL
	#query += USER_ID_BEST_LEVEL_5_TIME_FIELD_NAME + TEXT_NOT_NULL
	
	var i = 0
	for field in m_profiles_field_names:
		query += field + m_profiles_field_types[i]
		i = i + 1
	query += ")"
	
	# Query result
	var result = db.query(query)
	
	# Fetch rows
	query = SELECT_FROM + USER_DATABASE_TABLE_NAME
	result = db.fetch_array(query)
	m_num_profiles_rows = result.size()
	
	# Check validity of data
	if (!result or result.size() <= ERROR_RESULT):
		# Insert new row
		_insert([DEFAULT_LEVEL, DEFAULT_TIME, DEFAULT_TIME, DEFAULT_TIME, DEFAULT_TIME, DEFAULT_TIME])
		result = db.query(query)
		
		# Validate result
		if (!result):
			print(ERROR_INSERT)
		else:
			print(CONFIRMATION_MESSAGE)
	else:
		# Print all rows
		for i in result:
			print(i)
	
	# Close database
	db.close()
	
func _insert(data):
	if (m_profiles_field_names.size() - 1 != data.size()):
		print(ERROR_MISMATCHED_FIELDS)
	
	# Setup and intialize Database
	var db = _initialize_db()
	if (!db):
		return
	
	# Field Names
	var query = INSERT_INTO + USER_DATABASE_TABLE_NAME + "("
	for field in m_profiles_field_names:
		query += field + ", "
	query += VALUES
	
	# Actual data
	query += m_num_profiles_rows + 1
	for field in data:
		query += field + ", "
	query += ")"
	
	# Close database
	db.close()
	
func _initialize_db():
	# Create gdsqlite instance
	var db = SQLite.new()
	
	# Open database
	if (!db.open_db(DATABASE_PATH)):
		print(ERROR_MESSAGE)
		return ERROR_OPEN_RESULT # null
	else:
		return db