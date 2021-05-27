extends Node
## Session



## Constants
const Q_TABLE_DIR := "res://q_tables"

const Q_TABLE_PATH := Q_TABLE_DIR + "/q_table.json"



## Public Variables
var points := 0 setget set_points



## Private Variables
var q_table := {}



## OnReady Variables
var q_timer := Timer.new()



## Built-In Virtual Methods
func _ready() -> void:
	q_timer.connect("timeout", self, "_on_q_timer_timeout")
	add_child(q_timer)
	q_timer.start(60)


func _enter_tree() -> void:
	load_q_table()

func _exit_tree() -> void:
	save_q_table()



## Public Methods
func set_points(value : int) -> void:
	if value <= 0:
		var datetime := OS.get_datetime()
		print(str(get_node("/root/Session").points) + " at " \
			+ str(datetime["hour"]) + ":" \
			+ str(datetime["minute"]) + ":" \
			+ str(datetime["second"]))
	
	points = value


func save_q_table(path := Q_TABLE_PATH) -> void:
	print('Saving q_table.json...')
	var file = File.new()
	if file.open(path, File.WRITE) != 0:
		print("Error opening file")
		return
	
	print(file.get_path_absolute())
	file.store_line(JSON.print(q_table))
	
	if file.is_open():
		file.close()


func load_q_table(path := Q_TABLE_PATH) -> void:
	var file = File.new()
	if not file.file_exists(path):
		return
	
	print("Loading q_table.json...")
	if file.open(path, File.READ) != 0:
		print("Error opening file")
		return
	
	var json := JSON.parse(file.get_as_text())
	if json.error == OK and typeof(json.result) == TYPE_DICTIONARY:
		print(file.get_path_absolute())
		q_table = json.result
	
	if file.is_open():
		file.close()



## Private Methods
func _on_q_timer_timeout() -> void:
	var datetime := OS.get_datetime()
	save_q_table(Q_TABLE_DIR + "/" \
			+ str(datetime["hour"]) + "-" \
			+ str(datetime["minute"]) + "@" \
			+ str(datetime["day"]) + "-" \
			+ str(datetime["month"]) + "-" \
			+ str(datetime["year"]) \
			+ ".backup.json")
