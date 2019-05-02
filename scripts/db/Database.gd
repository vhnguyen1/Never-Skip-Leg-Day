# This class contains the necessary functionality to create, manipulate, and manage
# persistent data in a local SQLite database.
#
# May 01, 2019
# @version 1.0.0
# @author Vincent Nguyen

extends Node

#------------------------- Directory Paths ------------------------------------#

const DATABASE_INSTANCE_PATH = "res://lib/gdsqlite.gdns"
const DATABASE_PATH = "res://scores/super_secret_database.sql"

#------------------------- Constants ------------------------------------#

# Database Field Names
const PROFILES_DATABASE_TABLE_NAME = "profiles"				  # Table Name
const PROFILES_PRIMARY_KEY_FIELD_NAME = "id"				  # Primary Key ID (Integer)
const PROFILES_LEVEL_1_HIGH_SCORE_FIELD_NAME = "sky_points"	  # Sky Level High Score (Integer)
const PROFILES_LEVEL_2_HIGH_SCORE_FIELD_NAME = "ice_points"	  # Ice Level High Score (Integer)
const PROFILES_LEVEL_3_HIGH_SCORE_FIELD_NAME = "space_points" # Space Level High Score (Integer)

# Default values
const DEFAULT_LEVEL = 0
const DEFAULT_POINTS = 0

# SQL key terms
const CREATE_TABLE_IF_NOT_EXISTS = "CREATE TABLE IF NOT EXISTS "
const INTEGER_PRIMARY_KEY = " integer PRIMARY KEY"
const INTEGER = " integer"
const TEXT_NOT_NULL = " text NOT NULL"
const SELECT = "SELECT "
const FROM = " FROM "
const SELECT_FROM = "SELECT * FROM "
const INSERT_INTO = "INSERT INTO "
const VALUES = ") VALUES ("
const UPDATE = "UPDATE "
const SET = " SET "
const WHERE = " WHERE "
const LIMIT = " LIMIT "

# Error and confirmation prompts/messages
const ERROR_MESSAGE = "ERROR: Cannot open database!"
const ERROR_INSERT = "Error: Cannot insert data!"
const ERROR_MISMATCHED_FIELDS = "Error: Field amounts do not match to insert row!"
const ERROR_OPEN_RESULT = null
const ERROR_RESULT = 0
const CONFIRMATION_MESSAGE = "Data inserted into table."
const INITIALIZATION_MESSAGE = "Starting up database..."

#------------------------- Adjustable and Instance Variables #-------------------------#

# Database Field Name Array
const m_profiles_field_names = [PROFILES_PRIMARY_KEY_FIELD_NAME, PROFILES_LEVEL_1_HIGH_SCORE_FIELD_NAME, PROFILES_LEVEL_2_HIGH_SCORE_FIELD_NAME, PROFILES_LEVEL_3_HIGH_SCORE_FIELD_NAME]

# Database Field Type Array (which corresponds to the Field Name Array)
const m_profiles_field_types = [INTEGER_PRIMARY_KEY, INTEGER, INTEGER, INTEGER]

# Number of rows stored in the database
var m_num_profiles_rows = 0

#------------------------- Resources ------------------------------------#

# SQLite module
const SQLite = preload(DATABASE_INSTANCE_PATH)

#------------------------- Functions ------------------------------------#

# Loads up an instance of the local SQLite database. Returns an error
# value if it is unable to open it.
# @returns The database or an error result if it is unable to open.
func _initialize_db():
	# Create gdsqlite instance
	var db = SQLite.new()
	
	# Open database
	if (!db.open_db(DATABASE_PATH)):
		print(ERROR_MESSAGE)
		return ERROR_OPEN_RESULT # null
	else:
		return db

# Constructor that initializes all the necessary resources by creating a new table
# if one does not exist, and adding a default row inside the table if no data is
# stored.
# @returns Nothing if the database is unable to be opened.
func _init():
	print(INITIALIZATION_MESSAGE)
	
	# Setup and intializes database
	var db = _initialize_db()
	if (!db):
		return
	
	# Create table
	var query = CREATE_TABLE_IF_NOT_EXISTS + PROFILES_DATABASE_TABLE_NAME + " ("
	
	# Loops through the field names and types to form a create table query
	# Field names and types arrays should have an identical length
	var i = 0
	for field in m_profiles_field_names:
		query += field
		query += m_profiles_field_types[i]
		i = i + 1
		if i < m_profiles_field_names.size():
			query += ", "
		else:
			query += ")"
	print(query)
	
	# Query result
	var result = db.query(query)
	
	# Fetch rows
	query = SELECT_FROM + PROFILES_DATABASE_TABLE_NAME
	result = db.fetch_array(query)
	print(result)
	
	# Close database
	db.close()
	
	# Check validity of data
	if (!result or result.size() <= ERROR_RESULT):
		# Setup and intialize Database
		db = _initialize_db()
		if (!db):
			return
		
		# Insert new row
		_insert([DEFAULT_LEVEL, DEFAULT_POINTS, DEFAULT_POINTS, DEFAULT_POINTS])
		m_num_profiles_rows = 1
		#result = db.query(query)
		
		# Close database
		db.close()
		
		# Validate result
		if (!result):
			print(ERROR_INSERT)			# Invalid Database
		else:
			print(CONFIRMATION_MESSAGE) # Valid database
	else:
		m_num_profiles_rows = result.size()
		# Print all rows
		for i in result:
			print(i)

# Adds a new row into the current database
# @param data The new array to convert and add into the database
# @returns    Nothing if the database is unable to be opened.
func _insert(data):
	# Field names and types arrays should have an identical length
	if (m_profiles_field_names.size() - 1 != data.size()):
		print(ERROR_MISMATCHED_FIELDS)
	
	# Setup and intialize Database
	var db = _initialize_db()
	if (!db):
		return
	
	# Field Names
	var query = INSERT_INTO + PROFILES_DATABASE_TABLE_NAME + "("
	var i = 0
	var size = m_profiles_field_names.size()
	
	# Add field names to the query for inserting
	for field in m_profiles_field_names:
		query += field
		i = i + 1
		if i < size:
			query += ", "
		else:
			query += VALUES
	
	# ID is unique and cannot be specified outside of the Database file.
	# Thus the Database script generates a unique ID for each new entry
	query += str(m_num_profiles_rows + 1)
	query += ", "
	m_num_profiles_rows = m_num_profiles_rows + 1
	
	# Actual data to add to the query
	i = 0
	for field in data:
		query += str(field)
		i = i + 1
		if i < m_profiles_field_names.size() - 1:
			query += ", "
		else:
			query += ");"
	print (query)
	
	# Execute query
	db.query(query)
	
	# Close database
	db.close()

# Updates a specified row's data using it's primary key. If the row is not found, then
# default data is then inserted into the table.
# @param data The new array to convert and add into the database
# @returns    Nothing if the database is unable to be opened.
func _update(id, field, new_data):
	# Setup and intialize Database
	var db = _initialize_db()
	if (!db):
		return
	
	# Form user ID retrieval query
	var query = UPDATE + PROFILES_DATABASE_TABLE_NAME
	query += SET + field + "='" + str(new_data) + "'"
	query += WHERE + PROFILES_PRIMARY_KEY_FIELD_NAME + "='" + str(id) + "';"
	print(query)
	
	# Execute the query and retrieve the resulting success code
	var result = db.query(query);
	
	# If the execution failed, insert a default value into the table
	if (!result):
		_insert([DEFAULT_LEVEL, DEFAULT_POINTS, DEFAULT_POINTS, DEFAULT_POINTS])
	
	# Close database
	db.close()

# Prints out all the rows in the database to the console.
# @returns Nothing if the database is unable to be opened.
func _print_all_rows():
	# Setup and intialize Database
	var db = _initialize_db()
	if (!db):
		return
	
	# Generate query
	var query = SELECT_FROM + PROFILES_DATABASE_TABLE_NAME
	
	# Execute query and get all rows
	var result = db.fetch_array(query)
	
	# Check validity of data
	if (!result or result.size() <= ERROR_RESULT):
		# Insert new row of default values
		_insert([DEFAULT_LEVEL, DEFAULT_POINTS])
		
		# Execute query
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

# Prints out all the rows in the database to the console.
# @param   id    The primary key value to search for
# @param   field The specific data/field in the row to get
# @returns       The desired data if the id is valid, an error result if the
#                id is invalid, or nothing if the database is unable to be opened.
func _get_value(id, field):
	# Setup and intialize Database
	var db = _initialize_db()
	if (!db):
		return
	
	# Retrieve highscore from database
	var query = SELECT + field + FROM + PROFILES_DATABASE_TABLE_NAME
	query += WHERE + PROFILES_PRIMARY_KEY_FIELD_NAME + "='" + str(id) + "'" + LIMIT + "1;"
	print(query)
	
	# Execute query and get all rows within the database
	var rows = db.fetch_array(query)
	
	# Return the desired value (assuming there is one)
	if (rows and not rows.empty()):
		return rows[0][field];
	
	# Insert a default row and return an error result if no rows exist
	_insert([DEFAULT_LEVEL, DEFAULT_POINTS, DEFAULT_POINTS, DEFAULT_POINTS])
	return ERROR_RESULT;