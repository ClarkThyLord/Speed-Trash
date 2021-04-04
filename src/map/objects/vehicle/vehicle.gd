tool
extends "res://src/map/objects/map_object.gd"



## Enums
enum CarTypes {
	DEFAULT,
}



## Exported Variables
export(CarTypes) var car_type := 0 setget set_car_type



## OnReady Variables
onready var texture : Sprite3D = get_node("Sprite3D")



## Built-In Virtual Methods
func _ready() -> void:
	set_car_type(car_type)



## Public Methods
func set_car_type(value : int) -> void:
	var color : Color
	match car_type:
#		CarTypes.:
#			pass
		_:
			return
	car_type = value


func random() -> void:
	set_car_type(randi() % CarTypes.size())


func player_entered(player) -> void:
	get_node("/root/Session").points = 0
