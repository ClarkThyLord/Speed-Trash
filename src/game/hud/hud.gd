extends Control



## OnReady Variables
onready var points := get_node("Points")



## Built-In Virtual Methods
func _process(delta : float) -> void:
	points.text = str(get_node("/root/Session").points)
