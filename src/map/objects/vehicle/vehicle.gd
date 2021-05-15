tool
extends "res://src/map/objects/map_object.gd"



## Enums
enum CarTypes {
	CAR,
	RACE_CAR,
	BUS,
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
	var car_texture : Texture
	match value:
		CarTypes.CAR:
			pointage = -2
			speed = 1.0
			car_texture = preload("res://assets/map/objects/vehicle/car.png")
		CarTypes.RACE_CAR:
			pointage = -1
			speed = 0.65
			car_texture = preload("res://assets/map/objects/vehicle/race_car.png")
		CarTypes.BUS:
			pointage = -4
			speed = 1.75
			car_texture = preload("res://assets/map/objects/vehicle/bus.png")
		_:
			return
	car_type = value
	
	if is_instance_valid(texture):
		texture.texture = car_texture


func random() -> void:
	set_car_type(randi() % CarTypes.size())


func player_entered(player) -> void:
	if not player.ai or player.ai_mode == player.AIModes.PLAYING:
		get_node("/root/Session").points = 0
