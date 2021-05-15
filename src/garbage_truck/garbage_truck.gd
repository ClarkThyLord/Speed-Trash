extends Area
## Garbage Truck



## Constants
const Q_TABLE_PATH := "user://q_table.json"



## Exported Variables
export var speed := 10.0

export(float, 0.0, 1.0) var deceleration := 0.25

export(float, 0.0, 1.0) var acceleration := 0.25

export(float, 0.0, 100.0) var boost_usage := 1.0

export(float, 0.0, 100.0) var break_usage := 1.0

export(float, 0.0, 100.0) var momentum := 0.0

export(float, 0.0, 100.0) var momentum_growth := 10.0

export var ai := false



## Private Variables
var _breaking := false

var _boosting := false

var _q_table := {}



## OnReady Variables
onready var animation_player : AnimationPlayer = get_node("AnimationPlayer")

onready var view : Area = get_node("View")



## Built-In Virtual Methods
func _enter_tree() -> void:
	if ai:
		var file = File.new()
		if not file.file_exists(Q_TABLE_PATH):
			return
		
		if file.open(Q_TABLE_PATH, File.READ) != 0:
			print("Error opening file")
			return
		
		var json := JSON.parse(file.get_as_text())
		if json.error == OK and typeof(json.result) == TYPE_DICTIONARY:
			print("Loading q_table.json...")
			_q_table = json.result
		
		if file.is_open():
			file.close()


func _exit_tree() -> void:
	if ai:
		print('Saving q_table.json...')
		var file = File.new()
		if file.open(Q_TABLE_PATH, File.WRITE) != 0:
			print("Error opening file")
			return
		
		print(file.get_path_absolute())
		file.store_line(JSON.print(_q_table))
		
		if file.is_open():
			file.close()


func _physics_process(delta : float) -> void:
	if ai:
		var state = str(translation)
		
		var areas := view.get_overlapping_areas()
		if areas.size() > 1:
			for area in areas:
				if area == self:
					continue
				
				if area.translation.z < 0.0:
					state += "(" \
							+ str(area.translation) \
							+ "," + str(area.pointage) + ")"
		
		var state_hash = str(hash(state))
		print(state_hash + " <= " + state)
	else:
		var direction := Vector3.ZERO
		if Input.is_action_pressed("ui_right") and translation.x < 6:
			direction += Vector3.RIGHT
		if Input.is_action_pressed("ui_left") and translation.x > -6:
			direction += Vector3.LEFT
		
		_breaking = Input.is_action_pressed("action_break") and momentum >= break_usage
		if _breaking:
			direction -= direction * deceleration
		
		_boosting = Input.is_action_pressed("action_accelerate") and momentum >= boost_usage
		if _boosting:
			direction += direction * acceleration
		
		translate(direction * speed * delta)
		
		momentum += momentum_growth * delta



## Public Methods
func is_boosting() -> bool:
	return _boosting


func is_breaking() -> bool:
	return _breaking



## Private Methods
func _on_GargabeTruck_area_entered(area : Area):
	if area.is_in_group("obstacles") and not animation_player.is_playing():
		animation_player.play("hit")
