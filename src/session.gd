extends Node
## Session



## Constants
const Q_TABLE_PATH := "user://q_table.json"



## Public Variables
var points := 0

var q_table := {}


## Built-In Virtual Methods
func _enter_tree() -> void:
	var file = File.new()
	if not file.file_exists(Q_TABLE_PATH):
		return
	
	print("Loading q_table.json...")
	if file.open(Q_TABLE_PATH, File.READ) != 0:
		print("Error opening file")
		return
	
	var json := JSON.parse(file.get_as_text())
	if json.error == OK and typeof(json.result) == TYPE_DICTIONARY:
		print(file.get_path_absolute())
		q_table = json.result
	
	if file.is_open():
		file.close()


func _exit_tree() -> void:
	print('Saving q_table.json...')
	var file = File.new()
	if file.open(Q_TABLE_PATH, File.WRITE) != 0:
		print("Error opening file")
		return
	
	print(file.get_path_absolute())
	file.store_line(JSON.print(q_table))
	
	if file.is_open():
		file.close()
