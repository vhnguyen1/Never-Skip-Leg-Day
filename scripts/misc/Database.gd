extends Node

# Database Field Names
const PROFILES_DATABASE_TABLE_NAME = "profiles"
const PROFILES_ID_PRIMARY_KEY_FIELD_NAME = "id"
const PROFILES_ID_MAX_LEVEL_REACHED_FIELD_NAME = "level"
const PROFILES_ID_BEST_LEVEL_1_TIME_FIELD_NAME = "time_1"
const PROFILES_ID_BEST_LEVEL_2_TIME_FIELD_NAME = "time_2"
const PROFILES_ID_BEST_LEVEL_3_TIME_FIELD_NAME = "time_3"
const PROFILES_ID_BEST_LEVEL_4_TIME_FIELD_NAME = "time_4"
const PROFILES_ID_BEST_LEVEL_5_TIME_FIELD_NAME = "time_5"

# SQL key terms
const CREATE_TABLE_IF_NOT_EXISTS = "CREATE TABLE IF NOT EXISTS "
const INTEGER_PRIMARY_KEY = " integer PRIMARY KEY"
const INTEGER = " integer"
const TEXT_NOT_NULL = " text NOT NULL"
const SELECT_FROM = "SELECT * FROM "
const INSERT_INTO = "INSERT INTO "
const VALUES = ") VALUES ("
const UPDATE = "UPDATE "
const SET = " SET "
const WHERE = " WHERE "

# Database Field Name Array
const m_profiles_field_names = [PROFILES_ID_PRIMARY_KEY_FIELD_NAME, PROFILES_ID_MAX_LEVEL_REACHED_FIELD_NAME, PROFILES_ID_BEST_LEVEL_1_TIME_FIELD_NAME, PROFILES_ID_BEST_LEVEL_2_TIME_FIELD_NAME, PROFILES_ID_BEST_LEVEL_3_TIME_FIELD_NAME, PROFILES_ID_BEST_LEVEL_4_TIME_FIELD_NAME, PROFILES_ID_BEST_LEVEL_5_TIME_FIELD_NAME]

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
const INITIALIZATION_MESSAGE = "Starting up database..."

# Resource paths
const DATABASE_INSTANCE_PATH = "res://lib/gdsqlite.gdns"
const DATABASE_PATH = "res://godot.sql"

# SQLite module
const SQLite = preload(DATABASE_INSTANCE_PATH)

func _init():
	print(INITIALIZATION_MESSAGE)
	
	# Setup and intialize Database
	var db = _initialize_db()
	if (!db):
		return
	
	# Create table
	var query = CREATE_TABLE_IF_NOT_EXISTS + PROFILES_DATABASE_TABLE_NAME + " ("
	#query += PROFILES_ID_FIELD_NAME + INTEGER_PRIMARY_KEY
	#query += PROFILES_ID_MAX_LEVEL_REACHED_FIELD_NAME + INTEGER
	#query += PROFILES_ID_BEST_LEVEL_1_TIME_FIELD_NAME + TEXT_NOT_NULL
	#query += PROFILES_ID_BEST_LEVEL_2_TIME_FIELD_NAME + TEXT_NOT_NULL
	#query += PROFILES_ID_BEST_LEVEL_3_TIME_FIELD_NAME + TEXT_NOT_NULL
	#query += PROFILES_ID_BEST_LEVEL_4_TIME_FIELD_NAME + TEXT_NOT_NULL
	#query += PROFILES_ID_BEST_LEVEL_5_TIME_FIELD_NAME + TEXT_NOT_NULL
	
	var i = 0
	for field in self.m_profiles_field_names:
		query += field
		query += self.m_profiles_field_types[i]
		i = i + 1
		if i < self.m_profiles_field_names.size():
			query += ", "
		else:
			query += ")"
	print(query)
	
	# Query result
	var result = db.query(query)
	
	# Fetch rows
	query = SELECT_FROM + PROFILES_DATABASE_TABLE_NAME
	result = db.fetch_array(query)
	db.close()
	
	print(result)
	self.m_num_profiles_rows = result.size()
	
	# Check validity of data
	if (!result or result.size() <= ERROR_RESULT):
		# Setup and intialize Database
		db = _initialize_db()
		if (!db):
			return
			
		# Insert new row
		self._insert([DEFAULT_LEVEL, DEFAULT_TIME, DEFAULT_TIME, DEFAULT_TIME, DEFAULT_TIME, DEFAULT_TIME])
		#result = db.query(query)
			# Close database
		db.close()
		
		# Validate result
		if (!result):
			print(ERROR_INSERT)
		else:
			print(CONFIRMATION_MESSAGE)
	else:
		# Print all rows
		for i in result:
			print(i)
	
func _insert(data):
	if (m_profiles_field_names.size() - 1 != data.size()):
		print(ERROR_MISMATCHED_FIELDS)
	
	# Setup and intialize Database
	var db = _initialize_db()
	if (!db):
		return
	
	# Field Names
	var query = INSERT_INTO + PROFILES_DATABASE_TABLE_NAME + "("
	var i = 0
	for field in m_profiles_field_names:
		query += field
		i = i + 1
		if i < self.m_profiles_field_names.size():
			query += ", "
		else:
			query += VALUES
	
	# Actual data
	query += str(self.m_num_profiles_rows + 1)
	query += ", "
	self.m_num_profiles_rows = m_num_profiles_rows + 1
	
	i = 0
	for field in data:
		query += str(field)
		i = i + 1
		if i < self.m_profiles_field_names.size() - 1:
			query += ", "
		else:
			query += ");"
	print (query)
	
	db.query(query)
	
	# Close database
	db.close()

func _update(id, field, new_data):
	# Setup and intialize Database
	var db = _initialize_db()
	if (!db):
		return
	
	var query = UPDATE + PROFILES_DATABASE_TABLE_NAME
	query += SET + field + "='" + new_data + "'"
	query += WHERE + PROFILES_ID_PRIMARY_KEY_FIELD_NAME + "='" + str(id) + "';"
	db.query(query);
	print(query)
	
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

func _print_all_rows():
	# Setup and intialize Database
	var db = _initialize_db()
	if (!db):
		return
	
	var query = SELECT_FROM + PROFILES_DATABASE_TABLE_NAME
	var result = db.fetch_array(query)
	
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